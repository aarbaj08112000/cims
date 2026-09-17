<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

:root {
    --pd-primary: #696cff;
    --pd-primary-dark: #5b5fc7;
    --pd-primary-light: #ededfa;
    --pd-success: #27ae60;
    --pd-success-light: #e8f8f0;
    --pd-warning: #f59e0b;
    --pd-warning-light: #fef3c7;
    --pd-danger: #e74c3c;
    --pd-danger-light: #fdecea;
    --pd-gray-50: #f8f9fc;
    --pd-gray-100: #f1f3f9;
    --pd-gray-200: #e2e6ef;
    --pd-gray-500: #8490a7;
    --pd-gray-700: #3d4f6f;
    --pd-gray-900: #1e293b;
    --pd-font: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
    --pd-radius: 12px;
    --pd-shadow: 0 2px 20px rgba(0,0,0,0.06);
}

.pd-stat-card {
    background: #fff;
    border-radius: var(--pd-radius);
    box-shadow: var(--pd-shadow);
    border: 1px solid var(--pd-gray-200);
    padding: 1.25rem;
    display: flex;
    align-items: center;
    gap: 1rem;
    transition: all 0.25s ease;
    height: 100%;
}
.pd-stat-card:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
.pd-stat-icon {
    width: 52px; height: 52px;
    border-radius: var(--pd-radius);
    display: flex; align-items: center; justify-content: center;
    font-size: 1.4rem; flex-shrink: 0;
}
.pd-stat-icon.purple { background: var(--pd-primary-light); color: var(--pd-primary); }
.pd-stat-icon.green  { background: var(--pd-success-light); color: var(--pd-success); }
.pd-stat-icon.amber  { background: var(--pd-warning-light); color: var(--pd-warning); }
.pd-stat-icon.red    { background: var(--pd-danger-light);  color: var(--pd-danger); }
.pd-stat-label {
    font-size: 0.78rem; font-weight: 500; color: var(--pd-gray-500);
    text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 2px;
}
.pd-stat-value { font-size: 1.35rem; font-weight: 700; color: var(--pd-gray-900); line-height: 1.2; }
.pd-stat-value.text-primary { color: var(--pd-primary) !important; }

.pd-detail-card {
    background: #fff; border-radius: var(--pd-radius);
    box-shadow: var(--pd-shadow); border: 1px solid var(--pd-gray-200);
    overflow: hidden; height: 100%; transition: box-shadow 0.25s ease;
}
.pd-detail-card:hover { box-shadow: 0 6px 24px rgba(0,0,0,0.09); }
.pd-detail-header {
    background: linear-gradient(135deg, #f8f9fc 0%, #fff 100%);
    border-bottom: 1px solid var(--pd-gray-200);
    padding: 1rem 1.25rem;
    display: flex; align-items: center; justify-content: space-between;
}
.pd-detail-header h6 {
    font-size: 0.95rem; font-weight: 700; color: var(--pd-gray-900);
    margin: 0; display: flex; align-items: center; gap: 0.5rem;
}
.pd-detail-header h6 i { color: var(--pd-primary); font-size: 1.2rem; }
.pd-detail-body { padding: 1.25rem; }

.pd-info-row { display: flex; align-items: center; gap: 1rem; padding: 0.75rem 0; border-bottom: 1px solid var(--pd-gray-100); }
.pd-info-row:last-child { border-bottom: none; padding-bottom: 0; }
.pd-info-icon {
    width: 36px; height: 36px; border-radius: 8px; flex-shrink: 0;
    display: flex; align-items: center; justify-content: center;
    background: var(--pd-primary-light); color: var(--pd-primary); font-size: 1rem;
}
.pd-info-icon.green  { background: var(--pd-success-light); color: var(--pd-success); }
.pd-info-icon.amber  { background: var(--pd-warning-light); color: var(--pd-warning); }
.pd-info-icon.purple { background: var(--pd-primary-light); color: var(--pd-primary); }
.pd-info-label { font-size: 0.73rem; font-weight: 600; color: var(--pd-gray-500); text-transform: uppercase; letter-spacing: 0.4px; }
.pd-info-value { font-size: 0.95rem; font-weight: 600; color: var(--pd-gray-900); }

.pd-table-wrap {
    background: #fff; border-radius: var(--pd-radius);
    box-shadow: var(--pd-shadow); border: 1px solid var(--pd-gray-200); overflow: hidden;
}
.pd-table-header {
    display: flex; align-items: center; justify-content: space-between;
    padding: 1rem 1.5rem;
    background: linear-gradient(135deg, #f8f9fc 0%, #fff 100%);
    border-bottom: 1px solid var(--pd-gray-200);
}
.pd-table-header h6 { font-size: 0.95rem; font-weight: 700; color: var(--pd-gray-900); margin: 0; display: flex; align-items: center; gap: 0.5rem; }
.pd-table-header h6 i { color: var(--pd-primary); font-size: 1.2rem; }
.pd-items-count { font-size: 0.8rem; font-weight: 600; color: var(--pd-primary); background: var(--pd-primary-light); padding: 0.2rem 0.75rem; border-radius: 20px; }

.pd-table-wrap table { width: 100%; border-collapse: collapse; }
.pd-table-wrap thead tr { background: var(--pd-gray-50); }
.pd-table-wrap thead th { padding: 0.85rem 1.25rem; font-size: 0.75rem; font-weight: 700; color: var(--pd-gray-500); text-transform: uppercase; letter-spacing: 0.5px; border-bottom: 1px solid var(--pd-gray-200); }
.pd-table-wrap tbody tr { transition: background 0.15s ease; }
.pd-table-wrap tbody tr:hover { background: var(--pd-gray-50); }
.pd-table-wrap tbody td { padding: 1rem 1.25rem; font-size: 0.9rem; color: var(--pd-gray-700); border-bottom: 1px solid var(--pd-gray-100); vertical-align: middle; }
.pd-table-wrap tbody tr:last-child td { border-bottom: none; }
.pd-product-name { font-weight: 600; color: var(--pd-gray-900); font-size: 0.9rem; }
.pd-product-code { font-size: 0.75rem; color: var(--pd-gray-500); margin-top: 2px; }
.pd-qty-badge { display: inline-block; background: var(--pd-primary-light); color: var(--pd-primary); font-weight: 700; font-size: 0.85rem; padding: 0.2rem 0.75rem; border-radius: 20px; }
.pd-price { font-weight: 600; color: var(--pd-gray-700); }

.pd-grand-total {
    display: flex; align-items: center; justify-content: space-between;
    background: linear-gradient(135deg, var(--pd-primary) 0%, var(--pd-primary-dark) 100%);
    padding: 1rem 1.5rem; color: #fff;
}
.pd-grand-total-label { font-size: 0.95rem; font-weight: 600; opacity: 0.9; }
.pd-grand-total-value { font-size: 1.5rem; font-weight: 800; }

.pd-discount-row {
    display: flex; align-items: center; justify-content: space-between;
    padding: 0.6rem 1.5rem; background: var(--pd-gray-50);
    border-top: 1px solid var(--pd-gray-200);
}
.pd-discount-row .label { font-size: 0.85rem; font-weight: 600; color: var(--pd-gray-500); }
.pd-discount-row .value { font-size: 0.95rem; font-weight: 700; color: var(--pd-danger); }

.pd-badge { display: inline-flex; align-items: center; gap: 0.4rem; font-size: 0.78rem; font-weight: 600; padding: 0.25rem 0.75rem; border-radius: 20px; }
.pd-badge-success { background: var(--pd-success-light); color: var(--pd-success); }
.pd-badge-warning { background: var(--pd-warning-light); color: var(--pd-warning); }
.pd-badge-dot { width: 6px; height: 6px; border-radius: 50%; background: currentColor; }


</style>

<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- Page Header -->
    <div class="cat-page-header mb-4">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-file-invoice"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Purchase Return Details</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <a href="<%$base_url%>purchase_return_list">Sales History</a>
            <i class="ti ti-chevron-right"></i>
            <span><%$return['return_no']%></span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        
        
        
        <a href="<%$base_url%>purchase_return_list" class="cat-btn cat-btn-outline">
          <i class="ti ti-arrow-left"></i> Back to List
        </a>
      </div>
    </div>

    <!-- ========== Stat Cards Row ========== -->
    <div class="row g-3 mb-4">
      <div class="col-lg-3 col-md-6">
        <div class="pd-stat-card">
          <div class="pd-stat-icon purple"><i class="ti ti-receipt"></i></div>
          <div>
            <div class="pd-stat-label">Return No</div>
            <div class="pd-stat-value text-primary"><%$return['return_no']%></div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="pd-stat-card">
          <div class="pd-stat-icon green"><i class="ti ti-currency-rupee"></i></div>
          <div>
            <div class="pd-stat-label">Grand Total</div>
            <div class="pd-stat-value"><%$return['currency_symbol']|default:''%> <%$return['total_return_amount']|number_format:2%></div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="pd-stat-card">
          <div class="pd-stat-icon amber"><i class="ti ti-stack-2"></i></div>
          <div>
            <div class="pd-stat-label">Total Qty</div>
            <div class="pd-stat-value"><%$totalQty%> Units</div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="pd-stat-card">
          <div class="pd-stat-icon green" style="background: <%if $return['payment_mode'] == 'Cash'%>var(--pd-success-light)<%else%>var(--pd-warning-light)<%/if%>; color: <%if $return['payment_mode'] == 'Cash'%>var(--pd-success)<%else%>var(--pd-warning)<%/if%>;"><i class="ti ti-credit-card"></i></div>
          <div>
            <div class="pd-stat-label">Payment Mode</div>
            <div class="pd-stat-value"><%$return['payment_mode']%></div>
          </div>
        </div>
      </div>
    </div>

    <!-- ========== Detail Cards ========== -->
    <div class="row g-3 mb-4">

      <!-- Return Information Card -->
      <div class="col-lg-4 col-md-6">
        <div class="pd-detail-card">
          <div class="pd-detail-header">
            <h6><i class="ti ti-file-description"></i> Return Information</h6>
          </div>
          <div class="pd-detail-body">
            <div class="pd-info-row">
              <div class="pd-info-icon"><i class="ti ti-calendar"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Return Date</div>
                <div class="pd-info-value"><%$return['return_date']|date_format:'%d %b %Y'%></div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon"><i class="ti ti-receipt"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Return No</div>
                <div class="pd-info-value"><%$return['return_no']%></div>
              </div>
            </div>

            <div class="pd-info-row">
              <div class="pd-info-icon red"><i class="ti ti-discount"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Original Bill No</div>
                <div class="pd-info-value" style="color: var(--pd-primary);"><%$return['original_bill_no']%></div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon green"><i class="ti ti-check"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Total Refund</div>
                <div class="pd-info-value" style="color: var(--pd-success); font-size: 1.05rem;"><%$return['currency_symbol']|default:''%> <%$return['total_return_amount']|number_format:2%></div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Supplier Information Card -->
      <div class="col-lg-4 col-md-6">
        <div class="pd-detail-card">
          <div class="pd-detail-header">
            <h6><i class="ti ti-user"></i> Supplier Information</h6>
          </div>
          <div class="pd-detail-body">
            <div class="pd-info-row">
              <div class="pd-info-icon"><i class="ti ti-user-circle"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Supplier Name</div>
                <div class="pd-info-value"><%$return['supplier_name']|default:'Walk-in Customer'%></div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon"><i class="ti ti-phone"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Mobile Number</div>
                <div class="pd-info-value"><%$return['customer_phone_number']|default:'N/A'%></div>
              </div>
            </div>


          </div>
        </div>
      </div>

      <!-- Quick Overview Card -->
      <div class="col-lg-4 col-md-12">
        <div class="pd-detail-card">
          <div class="pd-detail-header">
            <h6><i class="ti ti-chart-bar"></i> Quick Overview</h6>
          </div>
          <div class="pd-detail-body">
            <div class="pd-info-row">
              <div class="pd-info-icon green"><i class="ti ti-package"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Total Products</div>
                <div class="pd-info-value"><%$items|@count%> Items</div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon amber"><i class="ti ti-stack-2"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Total Quantity</div>
                <div class="pd-info-value"><%$totalQty%> Units</div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon purple"><i class="ti ti-receipt"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Invoice Reference</div>
                <div class="pd-info-value"><%$return['return_no']%></div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon purple"><i class="ti ti-currency-rupee"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Total Refund</div>
                <div class="pd-info-value" style="color: var(--pd-primary); font-size: 1.05rem;"><%$return['currency_symbol']|default:''%> <%$return['total_return_amount']|number_format:2%></div>
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>

    <!-- ========== Returned Items Table ========== -->
    <div class="pd-table-wrap mb-4">
      <div class="pd-table-header">
        <h6><i class="ti ti-list-details"></i> Returned Items</h6>
        <span class="pd-items-count"><%$items|@count%> item<%if $items|@count > 1%>s<%/if%></span>
      </div>
      <div class="table-responsive">
        <table>
          <thead>
            <tr>
              <th style="width:50px">#</th>
              <th>Product</th>
              <th class="text-center" style="width:100px">Qty</th>
              <th class="text-end" style="width:140px">Return Price</th>
              <th class="text-end" style="width:140px">Total</th>
            </tr>
          </thead>
          <tbody>
            <%assign var='idx' value=1%>
            <%foreach from=$items item=item%>
            <tr>
              <td><span class="pd-qty-badge"><%$idx%></span></td>
              <td>
                <div class="pd-product-name"><%$item['product_name']%> <%if $item['brand_name']%><span class="text-muted" style="font-size:0.9em;font-weight:normal;">- <%$item['brand_name']%></span><%/if%></div>
                <div class="pd-product-code"><%$item['product_code']%></div>
              </td>
              <td class="text-center"><span class="pd-qty-badge"><%$item['qty']%></span></td>
              <td class="text-end pd-price"><%$item['currency_symbol']|default:''%> <%$item['purchase_price']|number_format:2%></td>
              <td class="text-end pd-price"><%$item['currency_symbol']|default:''%> <%$item['total_amount']|number_format:2%></td>
            </tr>
            <%assign var='idx' value=$idx+1%>
            <%/foreach%>
          </tbody>
        </table>
      </div>
      
      <div class="pd-grand-total">
        <span class="pd-grand-total-label">Grand Total</span>
        <span class="pd-grand-total-value"><%$return['currency_symbol']|default:''%> <%$return['total_return_amount']|number_format:2%></span>
      </div>
    </div>

  </div>
</div>
