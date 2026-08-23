<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Product extends MY_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Product_model');
        $this->load->model('category/Categories_model');
        $this->load->model('brand/Brand_model');
    }
    public function index()
    {
        $data['base_url'] = base_url();
        $this->smarty->loadView('login.tpl', $data, 'No', 'No');
    }
    /* add update user module */

    public function product()
    {
        $data['products'] = $this->Product_model->get_products();
        $data['base_url'] = base_url();
        $this->smarty->loadView('product_list.tpl', $data, 'Yes', 'Yes');
    }

    public function add_product()
    {
        $data['base_url'] = base_url();
        $product_id = $this->uri->segment(2);
        if ($product_id != "") {
            $data['products'] = $this->Product_model->get_products_details($product_id);
        }
        $data['categories'] = $this->Categories_model->get_categories();
        $data['brands'] = $this->Brand_model->get_brands();
        // pr($data);
        $this->smarty->loadView('add_product.tpl', $data, 'Yes', 'Yes');
    }


    public function product_details()
    {
        $data['base_url'] = base_url();
        $product_id = $this->uri->segment(2);
        $data['products'] = $this->Product_model->get_products_details($product_id);
        $data['products_image'] = $this->Product_model->get_products_image($product_id);
        // pr($data);
        $this->smarty->loadView('product_details.tpl', $data, 'Yes', 'Yes');
    }

    public function save_product_data()
    {
        $ret_arr = ['success' => 1, 'msg' => ''];

        // 1. Prepare data for initial insertion
        $product_code = $this->input->post("product_code");
        if (empty($product_code)) {
            $product_code = 'PRD-' . time();
        }

        $line_bar_code = $this->input->post("line_bar_code");
        if (empty($line_bar_code)) {
            $line_bar_code = time() . rand(100, 999);
        }

        $upload_data = [];
        $image_name = '';

        // Ensure root upload directory exists and is writable using Absolute Path
        // FCPATH includes trailing slash
        $upload_root = FCPATH . 'public/uploads/product/';
        if (!is_dir($upload_root)) {
            mkdir($upload_root, 0777, true);
        }
        chmod($upload_root, 0777);

        // Handle Image Upload First (to temp location or just validate)
        if (!empty($_FILES['image']['name'])) {
            $config = [
                'upload_path' => $upload_root,
                'allowed_types' => 'jpg|jpeg|png|gif|webp',
                'max_size' => 5242880, // 5MB
                'encrypt_name' => TRUE,
                'file_ext_tolower' => TRUE
            ];
            $this->load->library('upload', $config);
            if (!$this->upload->do_upload('image')) {
                $ret_arr['msg'] = $this->upload->display_errors();
                $ret_arr['success'] = 0;
                echo json_encode($ret_arr);
                return;
            }
            $upload_data = $this->upload->data();
            $image_name = $upload_data['file_name'];
        }

        $data = [
            'product_code' => $product_code,
            'line_bar_code' => $line_bar_code,
            'name' => $this->input->post("name"),
            'category_id' => $this->input->post("category_id"),
            'brand_id' => $this->input->post("brand_id"),
            'hsn_code' => $this->input->post("hsn_code"),
            'unit' => $this->input->post("unit"),
            'alert_qty' => $this->input->post("alert_qty"),
            'qty' => $this->input->post("qty"),
            'purchase_price' => $this->input->post("purchase_price"),
            'price' => $this->input->post("price"),
            'tax_rate' => $this->input->post("tax_rate"),
            'description' => $this->input->post("description"),
            'image' => $image_name, // Store filename, path logic handled in view
            'size' => $this->input->post("size"),
            'color' => $this->input->post("color"),
            'material' => $this->input->post("material"),
            'added_date' => date("Y-m-d H:i:s"),
            'added_by' => $this->session->userdata('user_id'),
        ];

        $product_id = $this->Product_model->add_product($data);

        if ($product_id) {
            // 2. Create Subfolders
            $image_dir = $upload_root . 'product_image/' . $product_id;
            $barcode_dir = $upload_root . 'bar_code/' . $product_id;

            if (!is_dir($image_dir)) {
                mkdir($image_dir, 0777, true);
            }
            chmod($image_dir, 0777);

            if (!is_dir($barcode_dir)) {
                mkdir($barcode_dir, 0777, true);
            }
            chmod($barcode_dir, 0777);

            // 3. Move Image
            if ($image_name) {
                $source_path = $upload_root . $image_name;
                $dest_path = $image_dir . '/' . $image_name;
                rename($source_path, $dest_path);
            }

            // 4. Generate Barcode (Filesystem only)
            // Use custom Code 128 generator library
            $this->load->library('barcode_gen');

            $barcode_text = $line_bar_code;
            $barcode_file = $barcode_dir . '/' . $line_bar_code . '.png';

            $this->barcode_gen->generate($barcode_text, $barcode_file);

            $ret_arr['msg'] = 'Product added successfully.';
        } else {
            $ret_arr['msg'] = 'Error occurred while adding the Product.';
            $ret_arr['success'] = 0;
        }

        echo json_encode($ret_arr);
    }

    public function update_product_data()
    {
        $ret_arr = ['success' => 1, 'msg' => ''];

        $product_id = $this->input->post("product_id");
        $old_image = $this->input->post("product_image");
        $image_path = $old_image;

        // Directory structure
        $upload_root = FCPATH . 'public/uploads/product/';
        if (!is_dir($upload_root)) {
            mkdir($upload_root, 0777, true);
        }
        chmod($upload_root, 0777);

        $image_dir = $upload_root . 'product_image/' . $product_id;
        if (!is_dir($image_dir)) {
            mkdir($image_dir, 0777, true);
        }
        chmod($image_dir, 0777);

        // Ensure barcode dir exists
        $barcode_dir = $upload_root . 'bar_code/' . $product_id;
        if (!is_dir($barcode_dir)) {
            mkdir($barcode_dir, 0777, true);
        }
        chmod($barcode_dir, 0777);

        // Check if barcode image exists, if not generate it
        $line_bar_code = $this->input->post("line_bar_code");
        if (!empty($line_bar_code)) {
            $barcode_file = $barcode_dir . '/' . $line_bar_code . '.png';
            if (!file_exists($barcode_file)) {
                $this->load->library('barcode_gen');
                $this->barcode_gen->generate($line_bar_code, $barcode_file);
            }
        }


        if (!empty($_FILES['image']['name'])) {
            $config = [
                'upload_path' => $upload_root, // Upload to temp/root product first
                'allowed_types' => 'jpg|jpeg|png|gif|webp',
                'max_size' => 5242880,
                'encrypt_name' => TRUE,
                'file_ext_tolower' => TRUE
            ];

            $this->load->library('upload', $config);

            if ($this->upload->do_upload('image')) {
                $upload_data = $this->upload->data();
                $new_image_name = $upload_data['file_name'];
                $image_path = $new_image_name;

                // Move new image to subfolder
                rename($upload_root . $new_image_name, $image_dir . '/' . $new_image_name);

                // Delete old image
                $old_path_sub = $image_dir . '/' . $old_image;
                $old_path_root = $upload_root . $old_image; // Check legacy root path too

                if (!empty($old_image)) {
                    if (file_exists($old_path_sub)) {
                        unlink($old_path_sub);
                    } elseif (file_exists($old_path_root)) {
                        unlink($old_path_root);
                    }
                }
            } else {
                $ret_arr['msg'] = $this->upload->display_errors();
                $ret_arr['success'] = 0;
                echo json_encode($ret_arr);
                return;
            }
        }

        $data = [
            'product_code' => $this->input->post("product_code"),
            'line_bar_code' => $this->input->post("line_bar_code"), // Kept from post but logic should imply it's not regenerated
            'name' => $this->input->post("name"),
            'category_id' => $this->input->post("category_id"),
            'brand_id' => $this->input->post("brand_id"),
            'hsn_code' => $this->input->post("hsn_code"),
            'unit' => $this->input->post("unit"),
            'alert_qty' => $this->input->post("alert_qty"),
            'qty' => $this->input->post("qty"),
            'purchase_price' => $this->input->post("purchase_price"),
            'price' => $this->input->post("price"),
            'tax_rate' => $this->input->post("tax_rate"),
            'description' => $this->input->post("description"),
            'image' => $image_path,
            'size' => $this->input->post("size"),
            'color' => $this->input->post("color"),
            'material' => $this->input->post("material"),
            'updated_date' => date("Y-m-d H:i:s"),
            'updated_by' => $this->session->userdata('user_id'),
        ];

        $update_query = $this->Product_model->update_product($data, $product_id);

        if ($update_query) {
            $ret_arr['msg'] = 'Product updated successfully.';
        } else {
            $ret_arr['msg'] = 'Error occurred while updating the Product.';
            $ret_arr['success'] = 0;
        }

        echo json_encode($ret_arr);
    }



    public function regenerate_barcode()
    {
        $ret_arr = array();
        $product_id = $this->input->post("product_id");
        $success = 0;
        $msg = "";

        if (!empty($product_id)) {
            // Get product details to find the barcode text
            $product_data = $this->Product_model->get_products_details($product_id);

            if (!empty($product_data) && isset($product_data[0]['line_bar_code'])) {
                $line_bar_code = $product_data[0]['line_bar_code'];

                // Define paths
                $upload_root = FCPATH . 'public/uploads/product/';
                $barcode_dir = $upload_root . 'bar_code/' . $product_id;

                // Ensure directory exists
                if (!is_dir($barcode_dir)) {
                    mkdir($barcode_dir, 0777, true);
                }
                chmod($barcode_dir, 0777);

                $barcode_file = $barcode_dir . '/' . $line_bar_code . '.png';

                // Delete existing file if it exists
                if (file_exists($barcode_file)) {
                    unlink($barcode_file);
                }

                // Generate new barcode
                $this->load->library('barcode_gen');
                if ($this->barcode_gen->generate($line_bar_code, $barcode_file)) {
                    $success = 1;
                    $msg = "Barcode regenerated successfully.";
                } else {
                    $msg = "Failed to generate barcode image.";
                }
            } else {
                $msg = "Product not found or missing barcode text.";
            }
        } else {
            $msg = "Invalid Product ID.";
        }

        $ret_arr['success'] = $success;
        $ret_arr['msg'] = $msg;
        echo json_encode($ret_arr);
    }

    public function delete_product_data()
    {
        $ret_arr = [];
        $msg = '';
        $success = 1;
        $product_id = $this->input->post("product_id");
        $data = array(
            'is_delete' => "1",
            'updated_date' => date("Y-m-d H:i:s"),
            'updated_by' => $this->session->userdata('user_id'),

        );
        $update_query = $this->Product_model->update_product($data, $product_id);
        if ($update_query) {
            $msg = 'Product delete successfully.';
        } else {
            $msg = 'Error occurred while delete the Product. Please try again.';
            $success = 0;
        }
        $ret_arr['msg'] = $msg;
        $ret_arr['success'] = $success;
        echo json_encode($ret_arr);
    }

    public function update_stock()
    {
        $ret_arr = array();
        $product_id = $this->input->post("product_id");
        $add_qty = $this->input->post("qty");
        $remarks = $this->input->post("remarks");
        $user_id = $this->session->userdata('user_id');

        $success = 0;
        $msg = "";

        if (!empty($product_id) && is_numeric($add_qty) && $add_qty != 0) {

            if ($this->Product_model->update_stock($product_id, $add_qty, $user_id, $remarks)) {
                $success = 1;
                $msg = "Stock updated successfully.";
            } else {
                $msg = "Failed to update stock.";
            }
        } else {
            $msg = "Invalid data. Quantity must not be zero.";
        }

        $ret_arr['success'] = $success;
        $ret_arr['msg'] = $msg;
        echo json_encode($ret_arr);
    }

    public function get_product_for_print()
    {
        $product_id = $this->input->post("product_id");
        $ret_arr = ['success' => 0, 'data' => []];

        if (!empty($product_id)) {
            $product_data = $this->Product_model->get_products_details($product_id);
            if (!empty($product_data)) {
                $ret_arr['success'] = 1;
                $ret_arr['data'] = $product_data[0];
                $ret_arr['data']['barcode_url'] = base_url() . "public/uploads/product/bar_code/" . $product_id . "/" . $product_data[0]['line_bar_code'] . ".png";
            }
        }

        echo json_encode($ret_arr);
    }

    public function print_barcode_thermal_pdf($product_id, $count = 1)
    {
        $product_data = $this->Product_model->get_products_details($product_id);
        if (empty($product_data)) {
            show_404();
            return;
        }

        $product = $product_data[0];
        $count = (int) $count;
        if ($count < 1)
            $count = 1;

        // Encode barcode as base64 so dompdf can embed it
        $barcode_path = FCPATH . "public/uploads/product/bar_code/" . $product_id . "/" . $product['line_bar_code'] . ".png";
        $barcode_base64 = '';
        $barcode_class = 'bar-code';
        if (file_exists($barcode_path)) {
            $mime = mime_content_type($barcode_path);
            $barcode_base64 = 'data:' . $mime . ';base64,' . base64_encode(file_get_contents($barcode_path));
        }
        $product['barcode_base64'] = $barcode_base64;
        $product['barcode_class'] = $barcode_class;

        // Build labels array
        $labels = array();
        for ($i = 0; $i < $count; $i++) {
            $labels[] = $product;
        }

        $data['labels'] = $labels;
        $data['base_url'] = base_url();

        $html = $this->smarty->loadView('barcode_print_thermal_pdf.tpl', $data, 'No', 'No', TRUE);

        $this->load->library('Pdf');
        $pdf = new Pdf();
        $pdf->loadHtml($html);

        // 48mm printing width = ~136 points.
        // Height increased to 148 points to comfortably fit the new Price line
        $customPaper = array(0, 0, 136, 134);
        $pdf->setPaper($customPaper);
        $pdf->render();
        $pdf->stream('Barcode_Thermal_' . $product['product_code'] . '.pdf', ['Attachment' => 0]);
    }

    public function print_barcode_pdf($product_id, $count = 1)
    {
        $product_data = $this->Product_model->get_products_details($product_id);
        if (empty($product_data)) {
            show_404();
            return;
        }

        $product = $product_data[0];
        $count = (int) $count;
        if ($count < 1)
            $count = 1;

        // Encode barcode as base64 so dompdf can embed it
        $barcode_path = FCPATH . "public/uploads/product/bar_code/" . $product_id . "/" . $product['line_bar_code'] . ".png";
        $barcode_base64 = '';
        $barcode_class = 'bar-code';
        if (file_exists($barcode_path)) {
            $mime = mime_content_type($barcode_path);
            $barcode_base64 = 'data:' . $mime . ';base64,' . base64_encode(file_get_contents($barcode_path));
            list($img_w, $img_h) = getimagesize($barcode_path);
            if ($img_w && $img_h) {
                // If the image is roughly square, it's a QR code
                if (abs($img_w - $img_h) < 20) {
                    $barcode_class = 'qr-code';
                }
            }
        }
        $product['barcode_base64'] = $barcode_base64;
        $product['barcode_class'] = $barcode_class;

        // Build labels array — one entry per copy needed
        $labels = array();
        for ($i = 0; $i < $count; $i++) {
            $labels[] = $product;
        }

        $data['labels'] = $labels;
        $data['base_url'] = base_url();

        $html = $this->smarty->loadView('barcode_print_pdf.tpl', $data, 'No', 'No', TRUE);

        $this->load->library('Pdf');
        $pdf = new Pdf();
        $pdf->loadHtml($html);
        $pdf->setPaper('A4', 'portrait');
        $pdf->render();
        $pdf->stream('Barcode_' . $product['product_code'] . '.pdf', ['Attachment' => 0]);
    }


    public function scan_barcode()
    {
        $data['base_url'] = base_url();
        $this->smarty->loadView('scan_barcode.tpl', $data, 'Yes', 'Yes');
    }

    public function get_product_by_barcode()
    {
        $barcode = $this->input->post('barcode');
        $ret_arr = ['success' => 0, 'data' => null, 'msg' => ''];

        if (!empty($barcode)) {
            $product_data = $this->Product_model->get_product_by_barcode_text($barcode);
            if (!empty($product_data)) {
                $ret_arr['success'] = 1;
                $ret_arr['data'] = $product_data;
                $ret_arr['data']['barcode_url'] = base_url() . "public/uploads/product/bar_code/" . $product_data['product_id'] . "/" . $product_data['line_bar_code'] . ".png";
                $ret_arr['msg'] = 'Product found.';
            } else {
                $ret_arr['msg'] = 'Product not found for the given barcode.';
            }
        } else {
            $ret_arr['msg'] = 'Barcode is required.';
        }

        echo json_encode($ret_arr);
    }

}
