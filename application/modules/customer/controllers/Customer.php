<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Customer extends MY_Controller {
	public function __construct() {
        parent::__construct();
        $this->load->model('Customer_model');
    }
	public function index() {
		$data['base_url'] = base_url();
		$this->smarty->loadView('login.tpl',$data,'No','No');
	}
	public function add_customer()
	{
		$data['base_url'] = base_url();
		$customer_id = $this->uri->segment(2); 
		if($customer_id != ""){
			
			$data['customer'] = $this->Customer_model->get_customer_details($customer_id);
			$data['c_product'] = $this->Customer_model->get_customer_product($customer_id);
		}
		// pr($data['c_product']);
		$data['product'] = $this->Customer_model->get_products();
		$data['company'] = $this->Customer_model->get_company();
		$this->smarty->loadView('add_customer.tpl', $data,'Yes','Yes');
	}
	public function customer_detail()
	{
		$data['base_url'] = base_url();
		$customer_id = $this->uri->segment(2); 
		$data['customer'] = $this->Customer_model->get_customer_details($customer_id);
		$data['c_product'] = $this->Customer_model->get_customer_product($customer_id);
		$data['product'] = $this->Customer_model->get_products();
		$data['company'] = $this->Customer_model->get_company();
		$this->smarty->loadView('customer_detail.tpl', $data,'Yes','Yes');
	}
	public function customer_invoice()
	{
		$data['base_url'] = base_url();
		$customer_id = $this->uri->segment(2); 
		$data['customer'] = $this->Customer_model->get_customer_details($customer_id);
		$data['c_product'] = $this->Customer_model->get_customer_product($customer_id);
    $data['invoice'] = $this->Customer_model->get_customer_product_invoice($customer_id);
		$data['product'] = $this->Customer_model->get_products();
		$data['company'] = $this->Customer_model->get_company();
		$this->smarty->loadView('customer_invoice.tpl', $data,'Yes','Yes');
	}
	public function customer()
	{
		$data['customer'] = $this->Customer_model->get_customer();
		$this->smarty->loadView('customer.tpl', $data,'Yes','Yes');
	}
	
	public function delete_customer_data()
	{
		$ret_arr = [];
		$msg = '';
		$success = 1;
		$customer_id = $this->input->post("customer_id");
		$data = array(
			'is_delete'  => "1",
			'updated_date'=> date("Y-m-d H:i:s"),
			'updated_by'=> $this->session->userdata('user_id'),
			
		);
		$update_query = $this->Customer_model->update_customer($data,$customer_id);
		if ($update_query) {
			$msg = 'Customer delete successfully.';
		} else {
			$msg = 'Error occurred while delete the Customer. Please try again.';
			$success = 0;
		}
		$ret_arr['msg'] = $msg;
		$ret_arr['success'] = $success;
		echo json_encode($ret_arr);
	}

	public function save_customer_data()
{
	$ret_arr = ['success' => 1, 'msg' => ''];
	$customer_count = count($this->Customer_model->get_customer());
	$data = [
		// Basic Info
		'full_name'         => $this->input->post('full_name'),
		'mobile_number'     => $this->input->post('mobile_number'),
		'customer_number'   => "BH00".$customer_count+1,
		'alternate_contact' => $this->input->post('alternate_contact'),
		'email'             => $this->input->post('email'),
		'dob'               => $this->input->post('dob'),
		'gender'            => $this->input->post('gender'),

		// Address
		'address1' => $this->input->post('address1'),
		'address2' => $this->input->post('address2'),
		'city'     => $this->input->post('city'),
		'state'    => $this->input->post('state'),
		'pincode'  => $this->input->post('pincode'),
		'country'  => $this->input->post('country'),

		// Identity
		'pan_number'    => $this->input->post('pan_number'),
		'aadhar_number' => $this->input->post('aadhar_number'),
		'gst_number'    => $this->input->post('gst_number'),

		// Business
		'company_name'      => $this->input->post('company_name'),
		'business_type'     => $this->input->post('business_type'),
		'business_contact'  => $this->input->post('business_contact'),
		'business_address'  => $this->input->post('business_address'),
		'gst_registered'    => $this->input->post('gst_registered'),
		'business_pan'      => $this->input->post('business_pan'),
		'business_email'    => $this->input->post('business_email'),

		// Payment
		'payment_mode'    => $this->input->post('payment_mode'),
		'bank_name'       => $this->input->post('bank_name'),
		'account_holder'  => $this->input->post('account_holder'),
		'account_number'  => $this->input->post('account_number'),
		'ifsc'            => $this->input->post('ifsc'),
		'upi_id'          => $this->input->post('upi_id'),
		'payment_terms'   => $this->input->post('payment_terms'),
		'payment_notes'   => $this->input->post('payment_notes'),

		// Additional
		'customer_type'   => $this->input->post('customer_type'),
		'company_id'      => $this->input->post('company_id'),
		// 'product_id'      => $this->input->post('product_id'),
		// 'product_price'   => $this->input->post('product_price'),
		// 'total_price'     => $this->input->post('total_price'),
		'gst_type'        => $this->input->post('gst_type'),
		'gst_percentage'  => $this->input->post('gst_percentage'),
		'notes'           => $this->input->post('notes'),

		'added_date'      => date("Y-m-d H:i:s"),
		'added_by'        => $this->session->userdata('user_id'),
	];

	$customer_id = $this->Customer_model->add_customer($data);

	if (!$customer_id) {
		echo json_encode(['success' => 0, 'msg' => 'Error saving customer data']);
		return;
	}else{
		$product_ids   = $this->input->post('product_id');
		$product_prices = $this->input->post('product_price');
		$quantities    = $this->input->post('quantity'); 

		if (!empty($product_ids) && is_array($product_ids)) {
			foreach ($product_ids as $index => $product_id) {
				if (!empty($product_id)) {
					$product_data = [
						'product_id'     => $product_id,
						'price'          => isset($product_prices[$index]) ? $product_prices[$index] : null,
						'qty'            => isset($quantities[$index]) ? $quantities[$index] : null,
						'customer_id'    => $customer_id,
						'added_date'     => date("Y-m-d H:i:s"),
						'added_by'       => $this->session->userdata('user_id'),
						'status'         => 'Active'
					];
					$this->Customer_model->insert_customer_product($product_data);
				}
			}
		}

	}

	$base_path = "./public/uploads/customer/$customer_id/";
	$folders = ['profile', 'pan', 'aadhar', 'gst'];

	foreach ($folders as $folder) {
		if (!is_dir($base_path . $folder)) {
			mkdir($base_path . $folder, 0777, true);
		}
	}

	$config = [
		'allowed_types' => 'jpg|jpeg|png|pdf',
		'max_size'      => 5242880,
		'encrypt_name'  => TRUE,
	];

	$upload_files = [
		'profile_photo'   => 'profile',
		'pan_image'       => 'pan',
		'aadhar_image'    => 'aadhar',
		'gst_certificate' => 'gst',
	];

	$this->load->library('upload');
	$file_data = [];

	foreach ($upload_files as $field => $folder) {
		if ($_FILES[$field]['name']) {
			$config['upload_path'] = $base_path . $folder;
			$this->upload->initialize($config);

			if (!$this->upload->do_upload($field)) {
				echo json_encode(['success' => 0, 'msg' => "Failed to upload $field: " . $this->upload->display_errors('', '')]);
				return;
			}

			$upload_data = $this->upload->data();
			$file_data[$field] = $upload_data['file_name'];
		}
	}

	if (!empty($file_data)) {
		$this->Customer_model->update_customer($file_data, $customer_id);
	}

	$ret_arr['msg'] = 'Customer added successfully.';
	echo json_encode($ret_arr);
}

public function update_customer_data()
{
    $ret_arr = ['success' => 1, 'msg' => ''];
	 $customer_id = $this->input->post("customer_id");
    $data = [
        'full_name'         => $this->input->post('full_name'),
        'mobile_number'     => $this->input->post('mobile_number'),
        'alternate_contact' => $this->input->post('alternate_contact'),
        'email'             => $this->input->post('email'),
        'dob'               => $this->input->post('dob'),
        'gender'            => $this->input->post('gender'),

        'address1' => $this->input->post('address1'),
        'address2' => $this->input->post('address2'),
        'city'     => $this->input->post('city'),
        'state'    => $this->input->post('state'),
        'pincode'  => $this->input->post('pincode'),
        'country'  => $this->input->post('country'),

        'pan_number'    => $this->input->post('pan_number'),
        'aadhar_number' => $this->input->post('aadhar_number'),
        'gst_number'    => $this->input->post('gst_number'),

        'company_name'      => $this->input->post('company_name'),
        'business_type'     => $this->input->post('business_type'),
        'business_contact'  => $this->input->post('business_contact'),
        'business_address'  => $this->input->post('business_address'),
        'gst_registered'    => $this->input->post('gst_registered'),
        'business_pan'      => $this->input->post('business_pan'),
        'business_email'    => $this->input->post('business_email'),

        'payment_mode'    => $this->input->post('payment_mode'),
        'bank_name'       => $this->input->post('bank_name'),
        'account_holder'  => $this->input->post('account_holder'),
        'account_number'  => $this->input->post('account_number'),
        'ifsc'            => $this->input->post('ifsc'),
        'upi_id'          => $this->input->post('upi_id'),
        'payment_terms'   => $this->input->post('payment_terms'),
        'payment_notes'   => $this->input->post('payment_notes'),

        'customer_type'   => $this->input->post('customer_type'),
        'company_id'      => $this->input->post('company_id'),
        // 'product_id'      => $this->input->post('product_id'),
        // 'product_price'   => $this->input->post('product_price'),
        // 'total_price'     => $this->input->post('total_price'),
        'gst_type'        => $this->input->post('gst_type'),
        'gst_percentage'  => $this->input->post('gst_percentage'),
        'notes'           => $this->input->post('notes'),

        'updated_date' => date("Y-m-d H:i:s"),
        'updated_by'   => $this->session->userdata('user_id'),
    ];

    $this->Customer_model->update_customer($data, $customer_id);

	$product_ids   = $this->input->post('product_id');    
    $product_prices = $this->input->post('product_price'); 
    $quantities    = $this->input->post('quantity');      

    if (!empty($product_ids)) {
        foreach ($product_ids as $index => $product_id) {
            if (empty($product_id)) continue; 

            $price = isset($product_prices[$index]) ? $product_prices[$index] : 0;
            $qty   = isset($quantities[$index]) ? $quantities[$index] : 0;

            $existing = $this->db->get_where('customer_product', [
                'customer_id' => $customer_id,
                'product_id'  => $product_id
            ])->row_array();

            $product_data = [
                'price'       => $price,
                'qty'         => $qty,
                'updated_date'=> date("Y-m-d H:i:s"),
                'updated_by'  => $this->session->userdata('user_id'),
                'status'      => 'Active'
            ];

            if ($existing) {
                // Update existing record
                $this->db->where('customer_product_id', $existing['customer_product_id']);
                $this->db->update('customer_product', $product_data);
            } else {
                // Insert new record
                $product_data['customer_id'] = $customer_id;
                $product_data['product_id']  = $product_id;
                $product_data['added_date']  = date("Y-m-d H:i:s");
                $product_data['added_by']    = $this->session->userdata('user_id');
                $this->db->insert('customer_product', $product_data);
            }
        }
    }



    // File Upload Handling
    $base_path = "./public/uploads/customer/$customer_id/";
    $folders = ['profile', 'pan', 'aadhar', 'gst'];

    foreach ($folders as $folder) {
        if (!is_dir($base_path . $folder)) {
            mkdir($base_path . $folder, 0777, true);
        }
    }

    $config = [
        'allowed_types' => 'jpg|jpeg|png|pdf',
        'max_size'      => 5242880,
        'encrypt_name'  => TRUE,
    ];

    $upload_files = [
        'profile_photo'   => 'profile',
        'pan_image'       => 'pan',
        'aadhar_image'    => 'aadhar',
        'gst_certificate' => 'gst',
    ];

    $hidden_files = [
        'profile_photo'   => $this->input->post('hidden_profile_photo'),
        'pan_image'       => $this->input->post('hidden_pan_image'),
        'aadhar_image'    => $this->input->post('hidden_aadhar_image'),
        'gst_certificate' => $this->input->post('hidden_gst_certificate'),
    ];

    $this->load->library('upload');
    $file_data = [];

    foreach ($upload_files as $field => $folder) {
        if ($_FILES[$field]['name']) {
            $config['upload_path'] = $base_path . $folder;
            $this->upload->initialize($config);

            // Delete old image if exists
            if (!empty($hidden_files[$field])) {
                $old_path = $base_path . $folder . '/' . $hidden_files[$field];
                if (file_exists($old_path)) {
                    unlink($old_path);
                }
            }

            if (!$this->upload->do_upload($field)) {
                echo json_encode(['success' => 0, 'msg' => "Failed to upload $field: " . $this->upload->display_errors('', '')]);
                return;
            }

            $upload_data = $this->upload->data();
            $file_data[$field] = $upload_data['file_name'];
        } else {
            // Keep existing image
            if (!empty($hidden_files[$field])) {
                $file_data[$field] = $hidden_files[$field];
            }
        }
    }

    if (!empty($file_data)) {
        $this->Customer_model->update_customer($file_data, $customer_id);
    }

    $ret_arr['msg'] = 'Customer updated successfully.';
    echo json_encode($ret_arr);
}

public function get_product_payment_html() {
    $customer_id = $this->input->post('customer_id');
    $data['c_product'] = $this->Customer_model->get_customer_product($customer_id);
    $data['customer'] = $this->Customer_model->get_customer_details($customer_id);

    $html = '
<div class="row">
  <div class="col-md-4 mb-3">
    <label class="form-label fw-bold">Full Name</label>
    <div>' . (!empty($data['customer'][0]['full_name']) ? $data['customer'][0]['full_name'] : '<span class="text-muted">-</span>') . '</div>
  </div>
  <div class="col-md-4 mb-3">
    <label class="form-label fw-bold">Mobile Number</label>
    <div>' . (!empty($data['customer'][0]['mobile_number']) ? $data['customer'][0]['mobile_number'] : '<span class="text-muted">-</span>') . '</div>
  </div>
 
  <div class="col-md-4 mb-3">
    <label class="form-label fw-bold">Email Address</label>
    <div>' . (!empty($data['customer'][0]['email']) ? $data['customer'][0]['email'] : '<span class="text-muted">-</span>') . '</div>
  </div>
  <div class="col-md-4">
    <label class="form-label">Customer Profile Photo</label><br>';
    if (!empty($data['customer'][0]['profile_photo'])) {
        $html .= '<img class="img-data" src="public/uploads/customer/' . $data['customer'][0]['customer_id'] . '/profile/' . $data['customer'][0]['profile_photo'] . '" alt="Profile Photo" style="width: auto; height: 75px; border: 1px solid #ddd; border-radius: 4px; padding: 5px;">';
    } else {
        $html .= '<span class="text-muted">No image available</span>';
    }
    $html .= '
  </div>
  <div class="col-md-3 mb-3">
    <label class="form-label fw-bold">Gender</label>
    <div>' . (!empty($data['customer'][0]['gender']) ? $data['customer'][0]['gender'] : '<span class="text-muted">-</span>') . '</div>
  </div>
</div>
<hr>';

    if (!empty($data['c_product'])) {
        $html .= '<table class="table table-bordered">
        <thead>
          <tr>
            <th class="text-center">Product</th>
            <th class="text-center">Quantity</th>
			<th class="text-center">Handovered Qty</th>
			<th class="text-center">Remaining Qty</th>
            <th class="text-center">Handover Qty</th>
          </tr>
        </thead>
        <tbody>';

      foreach ($data['c_product'] as $cp) {
			$product_name = $cp['product_name'];
			$qty = intval($cp['qty']);
			$handover_qty = intval($cp['handover_qty']);
			$remaining_qty = $qty - $handover_qty;
			$product_id = $cp['product_id'];

			$html .= '<tr>
				<td>' . $product_name . '</td>
				<td class="text-center">' . $qty . '</td>
				<td class="text-center">' . $handover_qty . '</td>
				<td class="text-center">' . $remaining_qty . '</td>
				<td class="text-center">';
				
			if ($remaining_qty > 0) {
				$html .= '<input type="number"
							class="form-control handover-input"
							data-handover-qty="' . $handover_qty . '"
							name="handover_qty[' . $product_id . ']"
							value="' . $remaining_qty . '"
							min="0"
							max="' . $remaining_qty . '">';
			} else {
				$html .= '-';
			}
			
			$html .= '</td>
			</tr>';
		}



        $html .= '</tbody>
      </table>';
    } else {
        $html .= '<p class="text-muted">No products added.</p>';
    }

    // Add Amount field and buttons
    $html .= '
  <div class="row mt-4">

    <div class="col-md-4">
      <label class="form-label fw-bold">Amount Received (₹)</label>
      <input type="number" name="amount_received" id="amount_received" class="form-control" placeholder="Enter amount">
    </div>

    <div class="col-md-4">
      <label class="form-label fw-bold">Transaction Type</label>
      <select name="transaction_type" id="transaction_type" class="form-select">
        <option value="">Select Type</option>
        <option value="Cash">Cash</option>
        <option value="UPI">UPI</option>
        <option value="Bank Transfer">Bank Transfer</option>
        <option value="Cheque">Cheque</option>
      </select>
    </div>

    <div class="col-md-4">
      <label class="form-label fw-bold">Transaction Image</label>
      <input type="file" name="transaction_image" id="transaction_image" class="form-control">
    </div>

  </div>

  <div class="mt-4">
    <button type="button" class="btn btn-success me-2" id="savePaymentBtn" data-id="' . $customer_id . '">Save</button>
    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
  </div>';


    echo $html;
}
public function save_product_payment() {
    $customer_id = $this->input->post('customer_id');
    $amount = $this->input->post('amount_received');
    $transaction_type = $this->input->post('transaction_type');
    $product_ids = $this->input->post('product_ids'); // comma separated
    $handover_qtys = $this->input->post('handover_qtys'); // comma separated
    $old_handover_qtys = $this->input->post('old_handover_qtys'); // comma separated

    // Step 1: Upload image
    $transaction_image = null;
    if (!empty($_FILES['transaction_image']['name'])) {
        $folderPath = './public/uploads/transaction_image/' . $customer_id;
        if (!file_exists($folderPath)) {
            mkdir($folderPath, 0777, true);
        }

        $config['upload_path'] = $folderPath . '/';
        $config['allowed_types'] = 'jpg|jpeg|png|gif';
        $config['file_name'] = time() . '_' . $_FILES['transaction_image']['name'];

        $this->load->library('upload', $config);

        if ($this->upload->do_upload('transaction_image')) {
            $uploadData = $this->upload->data();
            $transaction_image = $uploadData['file_name'];
        } else {
            echo json_encode(['status' => 'error', 'message' => $this->upload->display_errors()]);
            return;
        }
    }

    // Step 2: Prepare
    $invoice_name = 'INV_' . strtoupper(uniqid());
    $product_id_array = explode(',', $product_ids);
    $handover_qty_array = explode(',', $handover_qtys);
    $old_qty_array = explode(',', $old_handover_qtys);

    // Step 3: Save invoice
    $payment_data = [
        'customer_id' => $customer_id,
        'product_id' => $product_ids,
        'handover_qty' => $handover_qtys,
        'amount' => $amount,
        'invoice_name' => $invoice_name,
        'payment_date' => date('Y-m-d H:i:s'),
        'transaction_image' => $transaction_image,
        'transaction_type' => $transaction_type,
        'added_by' => $this->session->userdata('user_id'),
        'added_date' => date('Y-m-d H:i:s'),
    ];

    $insert_id = $this->Customer_model->insert_payment_invoice($payment_data);

    if (!$insert_id) {
        echo json_encode(['status' => 'error', 'message' => 'Failed to save payment.']);
        return;
    }

    // Step 4: Update customer_product
    foreach ($product_id_array as $index => $product_id) {
        $new_qty = (int) $handover_qty_array[$index];
        $old_qty = (int) $old_qty_array[$index];
        $updated_qty = $new_qty + $old_qty;

        $this->Customer_model->update_customer_product_qty($customer_id, $product_id, $updated_qty);
    }

    echo json_encode(['status' => 'success']);
}

public function download_invoice()
{
    require_once(APPPATH . 'libraries/tcpdf/tcpdf.php');
    $this->load->library('smarty'); 
    
    $customer_id = $this->uri->segment(2); 
    $customer_payments_id = $this->uri->segment(3); 
    $customer_data = $this->Customer_model->get_customer_details($customer_id);
	$transaction_data = $this->Customer_model->get_customer_invoice_detail($customer_payments_id);
	$company_data = $this->Customer_model->get_company($data['customer'][0]['company_id']);
   if (!empty($company_data)) {
    $row = $company_data[0];

    $company = [
        'logo'   => base_url('public/uploads/company/'.$row['company_id'].'/logo/' . $row['company_logo']),
        'name'   => $row['company_name'],
        'gst'    => 'GSTIN: ' . $row['gst_number'],
        'email'  => $row['email'],
        'phone'  => '+91-' . $row['phone'],
        'address'=> $row['address'] . ', ' . $row['city'] . ', ' . $row['state'] . ' - ' . $row['pincode'],
    ];
} 

   if (!empty($customer_data)) {
    $row = $customer_data[0]; // Get the first record

    $customer = [
        'id'    => $row['customer_number'],
        'name'  => $row['full_name'],
        'email' => $row['email'],
        'phone' => $row['mobile_number']
    ];
}

   if (!empty($transaction_data)) {
    $t = $transaction_data[0]; // Get the first transaction

    $transaction = [
        'type'       => $t['transaction_type'],
        'invoice_no' => $t['invoice_name'],
        'date'       => date('d-m-Y', strtotime($t['payment_date'])),
        // 'amount'     => $t['amount'],
        // 'image'      => base_url('public/uploads/transaction_image/' . $t['customer_id'] . '/' . $t['transaction_image']),
    ];
    $total_amount = $t['amount'].'- Rupees Only';


$product_ids = explode(',', $t['product_id']);      // [1, 2]
$handover_qtys = explode(',', $t['handover_qty']);  // [1, 5]

$products_from_db = $this->Customer_model->get_products_by_ids($product_ids);
$product_map = [];
foreach ($products_from_db as $prod) {
    $product_map[$prod['product_id']] = $prod['name'];
}

$products = [];
foreach ($product_ids as $index => $prod_id) {
    $prod_id = trim($prod_id);
    $qty = isset($handover_qtys[$index]) ? (int) $handover_qtys[$index] : 0;

    if (isset($product_map[$prod_id])) {
        $products[] = [
            'name' => $product_map[$prod_id],
            'qty'  => $qty,
        ];
    }
}
}
    

    // ===================== TCPDF Setup =========================
    $pdf = new TCPDF('P', PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
    $pdf->SetCreator('System');
    $pdf->SetAuthor($company['name']);
    $pdf->SetTitle('Invoice ' . $transaction['invoice_no']);
    $pdf->setPrintHeader(false);
    $pdf->setPrintFooter(false);
    $pdf->AddPage();

    // ===================== HTML Content ========================
$html = '<style>
    body {
        font-family: sans-serif;
        font-size: 10px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 10px;
    }
    .info-table, .info-table td, .info-table th {
        border: 1px solid #000;
        padding: 5px;
    }
    .section-title {
        background-color: #f0f0f0;
        font-weight: bold;
        padding: 5px;
        border: 1px solid #000;
        margin-top: 10px;
    }
    .product-table th {
        background-color: #f2f2f2;
        border: 1px solid #000;
        padding: 6px;
        text-align: left;
    }
    .product-table td {
        border: 1px solid #000;
        padding: 6px;
    }
    .signature-section {
        margin-top: 10px;
        text-align: right;
    }
</style>';

$html .= '
<table>
    <tr>
        <td width="25%">
            <img src="' . $company['logo'] . '" height="60">
        </td>
        <td width="75%">
            <b style="font-size:12px;">' . $company['name'] . '</b><br>
            GST: ' . $company['gst'] . '<br>
            Email: ' . $company['email'] . '<br>
            Phone: ' . $company['phone'] . '<br>
            Address: ' . $company['address'] . '
        </td>
    </tr>
</table><br>';

$html .= '<div class="section-title">Customer Information</div>
<table class="info-table">
    <tr>
        <td width="25%"><b>Customer Number:</b></td>
        <td width="25%">' . $customer['id'] . '</td>
        <td width="25%"><b>Name:</b></td>
        <td width="25%">' . $customer['name'] . '</td>
    </tr>
    <tr>
        <td><b>Email:</b></td>
        <td>' . $customer['email'] . '</td>
        <td><b>Phone Number:</b></td>
        <td>' . $customer['phone'] . '</td>
    </tr>
</table><br>';

$html .= '<div class="section-title">Transaction Information</div>
<table class="info-table">
    <tr>
        <td width="33%"><b>Transaction Type:</b></td>
        <td width="33%"><b>Invoice Number:</b></td>
        <td width="34%"><b>Transaction Date:</b></td>
    </tr>
    <tr>
        <td>' . $transaction['type'] . '</td>
        <td>' . $transaction['invoice_no'] . '</td>
        <td>' . $transaction['date'] . '</td>
    </tr>
</table><br>';

$html .= '<div class="section-title">Product Details</div>
<table class="product-table">
    <tr>
        <th width="80%">Product Name</th>
        <th width="20%">Quantity</th>
    </tr>';

foreach ($products as $prod) {
    $html .= '<tr><td>' . $prod['name'] . '</td><td>' . $prod['qty'] . '</td></tr>';
}

$html .= '</table>
<h4 style="text-align:right; font-size:10px;">Total Amount: <b>' . $total_amount . '</b></h4><br>';

$html .= '<div class="signature-section">
    <p>Authorized Signature</p>
    <img src="' . $company['signature'] . '" height="40"><br>
    <b>' . $company['name'] . '</b>
</div>';



    // Write HTML to PDF
    $pdf->writeHTML($html, true, false, true, false, '');

    // Output the PDF
    $pdf->Output("Invoice_{$transaction['invoice_no']}.pdf", 'D'); // D = Download
}


	
}

