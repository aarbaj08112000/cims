<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Product extends MY_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->helper('product_log');
        $this->load->model('Product_model');
        $this->load->model('category/Categories_model');
        $this->load->model('brand/Brand_model');
        $this->load->model('unit_master/Unit_master_model');
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
        $data['time'] = time();
        $this->smarty->loadView('product_list.tpl', $data, 'Yes', 'Yes');
    }

    public function add_product()
    {
        $data['base_url'] = base_url();
        $product_id = decode_id($this->uri->segment(2));
        if ($product_id != "" && is_numeric($product_id)) {
            $data['products'] = $this->Product_model->get_products_details($product_id);
            $data['product_attrs'] = $this->Product_model->get_product_attributes($product_id);
            $data['product_images'] = $this->Product_model->get_product_images($product_id);
        }
        $data['categories'] = $this->Categories_model->get_categories();
        $data['brands'] = $this->Brand_model->get_brands();
        $data['units'] = $this->Unit_master_model->get_units();
        $data['master_attributes'] = $this->Product_model->get_all_attributes();
        $data['currencies'] = $this->Product_model->get_active_currencies();

        $this->load->model('settings/Settings_model');
        $settings_raw = $this->Settings_model->get_all_settings();
        $settings = [];
        foreach ($settings_raw as $setting) {
            $settings[$setting['name']] = $setting;
        }
        $data['settings'] = $settings;
        // pr($data, 1);
        $this->smarty->loadView('add_product.tpl', $data, 'Yes', 'Yes');
    }


    public function product_details()
    {
        $data['base_url'] = base_url();
        $product_id = decode_id($this->uri->segment(2));
        $data['products'] = $this->Product_model->get_products_details($product_id);
        $data['products_image'] = $this->Product_model->get_products_image($product_id);
        $data['product_attrs'] = $this->Product_model->get_product_attributes($product_id);
        $data['product_images'] = $this->Product_model->get_product_images($product_id);
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

        // Images and attributes are handled after product creation
        $image_name = '';

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
            'purchase_currency_id' => $this->input->post("purchase_currency_id"),
            'purchase_price' => $this->input->post("purchase_price"),
            'selling_currency_id' => $this->input->post("selling_currency_id"),
            'actual_price' => $this->input->post("actual_price"),
            'discount' => $this->input->post("discount"),
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

            // 3. Handle Multiple Images
            $gallery_dir = $image_dir . '/gallery/';
            if (!is_dir($gallery_dir)) {
                mkdir($gallery_dir, 0777, true);
            }
            chmod($gallery_dir, 0777);

            if (!empty($_FILES['multi_images']['name'][0])) {
                $images_to_save = [];
                $files = $_FILES['multi_images'];
                $file_count = count($files['name']);
                $primary_image = '';

                for ($i = 0; $i < $file_count; $i++) {
                    if ($files['error'][$i] == 0) {
                        $tmp_name = $files['tmp_name'][$i];
                        $name = time() . '_' . rand(100, 999) . '_' . preg_replace("/[^a-zA-Z0-9.]/", "", $files['name'][$i]);

                        // First image is primary
                        if ($i === 0) {
                            $dest = $image_dir . '/' . $name;
                            if (move_uploaded_file($tmp_name, $dest)) {
                                $primary_image = $name;
                            }
                        } else {
                            $dest = $gallery_dir . $name;
                            if (move_uploaded_file($tmp_name, $dest)) {
                                $images_to_save[] = [
                                    'product_id' => $product_id,
                                    'image' => $name,
                                    'is_primary' => 0,
                                    'sort_order' => $i,
                                    'added_date' => date('Y-m-d H:i:s')
                                ];
                            }
                        }
                    }
                }

                if (!empty($primary_image)) {
                    $this->Product_model->update_product(['image' => $primary_image], $product_id);
                }
                if (!empty($images_to_save)) {
                    $this->Product_model->save_product_images($product_id, $images_to_save);
                }
            }

            // 3b. Handle Attributes
            $attr_names = $this->input->post('attr_name');
            $attr_values = $this->input->post('attr_value');
            if (!empty($attr_names) && is_array($attr_names)) {
                $attrs_to_save = [];
                foreach ($attr_names as $index => $a_name) {
                    if (!empty(trim($a_name))) {
                        $attrs_to_save[] = [
                            'product_id' => $product_id,
                            'attr_name' => trim($a_name),
                            'attr_value' => isset($attr_values[$index]) ? trim($attr_values[$index]) : '',
                            'sort_order' => $index
                        ];
                    }
                }
                if (!empty($attrs_to_save)) {
                    $this->Product_model->save_product_attributes($product_id, $attrs_to_save);
                }
            }

            // 4. Generate Barcode (Filesystem only)
            // Use custom Code 128 generator library
            $this->load->library('barcode_gen');

            $barcode_text = $line_bar_code;
            $barcode_file = $barcode_dir . '/' . $line_bar_code . '.png';

            $this->barcode_gen->generate($barcode_text, $barcode_file);

            log_product_activity([
                'product_id' => $product_id,
                'product_name' => $name,
                'action_type' => 'created',
                'qty_change' => floatval($qty),
                'price_change' => floatval($price),
                'remarks' => 'New product added with stock ' . $qty . ' and sale price ₹' . $price,
                'new_values' => ['name' => $name, 'price' => $price, 'purchase_price' => $purchase_price, 'qty' => $qty, 'unit' => $unit]
            ]);
            $ret_arr['msg'] = 'Product added successfully.';
            $ret_arr['product_id'] = encode_id($product_id);
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
            'purchase_currency_id' => $this->input->post("purchase_currency_id"),
            'purchase_price' => $this->input->post("purchase_price"),
            'selling_currency_id' => $this->input->post("selling_currency_id"),
            'actual_price' => $this->input->post("actual_price"),
            'discount' => $this->input->post("discount"),
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

        // Save multiple new images
        $gallery_dir = $image_dir . '/gallery/';
        if (!is_dir($gallery_dir)) {
            mkdir($gallery_dir, 0777, true);
        }
        chmod($gallery_dir, 0777);

        if (!empty($_FILES['multi_images']['name'][0])) {
            $images_to_save = [];
            $files = $_FILES['multi_images'];
            $file_count = count($files['name']);

            for ($i = 0; $i < $file_count; $i++) {
                if ($files['error'][$i] == 0) {
                    $tmp_name = $files['tmp_name'][$i];
                    $name = time() . '_' . rand(100, 999) . '_' . preg_replace("/[^a-zA-Z0-9.]/", "", $files['name'][$i]);

                    // If no primary image exists, make the first new image the primary
                    if (empty($image_path)) {
                        $dest = $image_dir . '/' . $name;
                        if (move_uploaded_file($tmp_name, $dest)) {
                            $image_path = $name;
                            $data['image'] = $image_path;
                        }
                    } else {
                        $dest = $gallery_dir . $name;
                        if (move_uploaded_file($tmp_name, $dest)) {
                            $images_to_save[] = [
                                'product_id' => $product_id,
                                'image' => $name,
                                'is_primary' => 0,
                                'sort_order' => $i,
                                'added_date' => date('Y-m-d H:i:s')
                            ];
                        }
                    }
                }
            }
            if (!empty($images_to_save)) {
                $this->Product_model->save_product_images($product_id, $images_to_save);
            }
        }

        // Re-check: If primary was removed and no new image was uploaded, promote the first gallery image
        if (empty($image_path)) {
            $first_gallery = $this->db->where('product_id', $product_id)->order_by('sort_order', 'ASC')->limit(1)->get('product_images')->row_array();
            if (!empty($first_gallery)) {
                $promoted_img = $first_gallery['image'];
                if (file_exists($gallery_dir . $promoted_img)) {
                    rename($gallery_dir . $promoted_img, $image_dir . '/' . $promoted_img);
                    $image_path = $promoted_img;
                    $data['image'] = $image_path;
                    $this->db->where('image_id', $first_gallery['image_id'])->delete('product_images');
                }
            }
        }

        // Handle Attributes
        $attr_names = $this->input->post('attr_name');
        $attr_values = $this->input->post('attr_value');
        $this->Product_model->delete_product_attributes($product_id); // clear old
        if (!empty($attr_names) && is_array($attr_names)) {
            $attrs_to_save = [];
            foreach ($attr_names as $index => $a_name) {
                if (!empty(trim($a_name))) {
                    $attrs_to_save[] = [
                        'product_id' => $product_id,
                        'attr_name' => trim($a_name),
                        'attr_value' => isset($attr_values[$index]) ? trim($attr_values[$index]) : '',
                        'sort_order' => $index
                    ];
                }
            }
            if (!empty($attrs_to_save)) {
                $this->Product_model->save_product_attributes($product_id, $attrs_to_save);
            }
        }

        $update_query = $this->Product_model->update_product($data, $product_id);

        if ($update_query) {
            $ret_arr['msg'] = 'Product updated successfully.';
            $ret_arr['product_id'] = encode_id($product_id);
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
        // Save multiple new images
        $gallery_dir = $image_dir . '/gallery/';
        if (!is_dir($gallery_dir)) {
            mkdir($gallery_dir, 0777, true);
        }
        chmod($gallery_dir, 0777);

        if (!empty($_FILES['multi_images']['name'][0])) {
            $images_to_save = [];
            $files = $_FILES['multi_images'];
            $file_count = count($files['name']);

            for ($i = 0; $i < $file_count; $i++) {
                if ($files['error'][$i] == 0) {
                    $tmp_name = $files['tmp_name'][$i];
                    $name = time() . '_' . rand(100, 999) . '_' . preg_replace("/[^a-zA-Z0-9.]/", "", $files['name'][$i]);

                    // If no primary image exists, make the first new image the primary
                    if (empty($image_path)) {
                        $dest = $image_dir . '/' . $name;
                        if (move_uploaded_file($tmp_name, $dest)) {
                            $image_path = $name;
                            $data['image'] = $image_path;
                        }
                    } else {
                        $dest = $gallery_dir . $name;
                        if (move_uploaded_file($tmp_name, $dest)) {
                            $images_to_save[] = [
                                'product_id' => $product_id,
                                'image' => $name,
                                'is_primary' => 0,
                                'sort_order' => $i,
                                'added_date' => date('Y-m-d H:i:s')
                            ];
                        }
                    }
                }
            }
            if (!empty($images_to_save)) {
                $this->Product_model->save_product_images($product_id, $images_to_save);
            }
        }

        // Re-check: If primary was removed and no new image was uploaded, promote the first gallery image
        if (empty($image_path)) {
            $first_gallery = $this->db->where('product_id', $product_id)->order_by('sort_order', 'ASC')->limit(1)->get('product_images')->row_array();
            if (!empty($first_gallery)) {
                $promoted_img = $first_gallery['image'];
                if (file_exists($gallery_dir . $promoted_img)) {
                    rename($gallery_dir . $promoted_img, $image_dir . '/' . $promoted_img);
                    $image_path = $promoted_img;
                    $data['image'] = $image_path;
                    $this->db->where('image_id', $first_gallery['image_id'])->delete('product_images');
                }
            }
        }

        // Handle Attributes
        $attr_names = $this->input->post('attr_name');
        $attr_values = $this->input->post('attr_value');
        $this->Product_model->delete_product_attributes($product_id); // clear old
        if (!empty($attr_names) && is_array($attr_names)) {
            $attrs_to_save = [];
            foreach ($attr_names as $index => $a_name) {
                if (!empty(trim($a_name))) {
                    $attrs_to_save[] = [
                        'product_id' => $product_id,
                        'attr_name' => trim($a_name),
                        'attr_value' => isset($attr_values[$index]) ? trim($attr_values[$index]) : '',
                        'sort_order' => $index
                    ];
                }
            }
            if (!empty($attrs_to_save)) {
                $this->Product_model->save_product_attributes($product_id, $attrs_to_save);
            }
        }

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
        // pr($data, 1);

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


    public function export_pdf()
    {
        $data['products'] = $this->Product_model->get_products();
        $data['base_url'] = base_url();

        $html = $this->smarty->loadView('export_product_pdf.tpl', $data, 'No', 'No', TRUE);

        $this->load->library('Pdf');
        $pdf = new Pdf();
        $pdf->loadHtml($html);
        $pdf->setPaper('A4', 'landscape');
        $pdf->render();
        $pdf->stream('Product_Report_' . date('Y-m-d') . '.pdf', array('Attachment' => 0));
    }

    public function product_ssp()
    {
        $draw = intval($this->input->post('draw'));
        $start = intval($this->input->post('start'));
        $length = intval($this->input->post('length'));

        $search = $this->input->post('search');
        $search_value = isset($search['value']) ? $search['value'] : '';

        $order = $this->input->post('order');
        $order_col = isset($order[0]['column']) ? intval($order[0]['column']) : 0;
        $order_dir = isset($order[0]['dir']) ? $order[0]['dir'] : 'desc';

        $total_records = $this->Product_model->get_products_ssp_count();
        $total_filtered = empty($search_value) ? $total_records : $this->Product_model->get_products_ssp_count($search_value);

        $products = $this->Product_model->get_products_ssp($start, $length, $search_value, $order_col, $order_dir);

        $data = array();
        $time = time();
        foreach ($products as $row) {
            $image_html = '';
            if (!empty($row['image'])) {
                $new_path = FCPATH . "public/uploads/product/product_image/" . $row['product_id'] . "/" . $row['image'];
                $old_path = FCPATH . "public/uploads/product/" . $row['image'];
                if (file_exists($new_path)) {
                    $img_url = base_url("public/uploads/product/product_image/" . $row['product_id'] . "/" . $row['image'] . "?ver=" . $time);
                } elseif (file_exists($old_path)) {
                    $img_url = base_url("public/uploads/product/" . $row['image'] . "?ver=" . $time);
                } else {
                    $img_url = base_url("public/assets/images/no_image.jpg");
                }
                $image_html = '<img src="' . $img_url . '" onerror="this.src=\'' . base_url("public/assets/images/no_image.jpg") . '\';" alt="Product Image" style="width: 50px; height: 50px; object-fit: contain; border-radius: 8px;">';
            } else {
                $image_html = '<img src="' . base_url("public/assets/images/no_image.jpg") . '" alt="No Image" style="width: 50px; height: 50px; object-fit: contain;">';
            }

            $barcode_html = '-';
            if (!empty($row['line_bar_code'])) {
                $barcode_url = base_url("public/uploads/product/bar_code/" . $row['product_id'] . "/" . $row['line_bar_code'] . ".png?ver=" . $time);
                $barcode_html = '<img class="list-barcode-img" src="' . $barcode_url . '" onerror="this.style.display=\'none\'; this.nextElementSibling.style.display=\'inline\';" alt="' . $row['line_bar_code'] . '" style="width: 120px; height: 80px; object-fit: contain; display:block;margin:auto; transition: transform .2s;"><span style="display:none;">-</span><small>' . $row['line_bar_code'] . '</small>';
            }

            $desc_html = '<span title="' . htmlspecialchars($row['description']) . '" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; max-width: 280px; white-space: normal; line-height: 1.45; font-size:.85rem; color:#555;">' . htmlspecialchars($row['description']) . '</span>';

            $status_html = ($row['status'] == 'Active') ? '<span class="cat-badge cat-badge-active"><span class="cat-badge-dot"></span>Active</span>' : '<span class="cat-badge cat-badge-inactive"><span class="cat-badge-dot"></span>Inactive</span>';

            $action_html = '
            <div class="dropdown text-center">
                <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="ti ti-dots-vertical text-muted"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-end" style="">
                    <li><a class="dropdown-item" href="' . base_url('product_details/') . encode_id($row['product_id']) . '"><i class="ti ti-eye me-1"></i> View Details</a></li>
                    <li><a class="dropdown-item" href="' . base_url('update_product/') . encode_id($row['product_id']) . '"><i class="ti ti-pencil me-1"></i> Edit</a></li>
                    <li><a class="dropdown-item update_stock" href="javascript:void(0);" data-id="' . $row['product_id'] . '"><i class="ti ti-box me-1"></i> Update Stock</a></li>
                    <li><a class="dropdown-item regenerate_barcode" href="javascript:void(0);" data-id="' . $row['product_id'] . '"><i class="ti ti-refresh me-1"></i> Regenerate Barcode</a></li>
                    <li><a class="dropdown-item print_barcode text-body" href="javascript:void(0);" data-id="' . $row['product_id'] . '"><i class="ti ti-printer me-1" style="color: inherit !important; background: none !important; box-shadow: none !important; width: auto; height: auto;"></i> Print</a></li>
                    <li><a class="dropdown-item text-danger delete_data" href="javascript:void(0);" data-id="' . $row['product_id'] . '"><i class="ti ti-trash me-1"></i> Delete</a></li>
                </ul>
            </div>';

            $price_formatted = !empty($row['price']) ? number_format((float) $row['price'], 2) : '0.00';
            $purchase_price_formatted = !empty($row['purchase_price']) ? number_format((float) $row['purchase_price'], 2) : '0.00';

            $selling_symbol = !empty($row['selling_currency_symbol']) ? $row['selling_currency_symbol'] . ' ' : '';
            $purchase_symbol = !empty($row['purchase_currency_symbol']) ? $row['purchase_currency_symbol'] . ' ' : '';

            $data[] = array(
                $image_html,
                $barcode_html,
                '<a href="' . base_url('product_details/' . encode_id($row['product_id'])) . '" style="font-weight:600; color:#7367f0; text-decoration:none;" onmouseover="this.style.textDecoration=\'underline\'" onmouseout="this.style.textDecoration=\'none\'">' . htmlspecialchars($row['name']) . '</a>',
                $desc_html,
                $selling_symbol . $price_formatted,
                $purchase_symbol . $purchase_price_formatted,
                $row['unit'],
                $row['qty'],
                $status_html,
                $action_html
            );
        }

        $output = array(
            "draw" => $draw,
            "recordsTotal" => $total_records,
            "recordsFiltered" => $total_filtered,
            "data" => $data
        );

        echo json_encode($output);
    }

}
