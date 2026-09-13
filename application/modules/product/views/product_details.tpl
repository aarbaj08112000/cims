<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<style>
/* ══ Page Layout ══════════════════════════════════════════════ */
.pd-wrapper { padding: 24px; max-width: 1400px; margin: 0 auto; }

/* ══ Hero Banner ═══════════════════════════════════════════════ */
.pd-hero {
  background: linear-gradient(135deg, #7367f0 0%, #9e95f5 50%, #ce9ffc 100%);
  border-radius: 20px;
  padding: 32px 36px;
  margin-bottom: 28px;
  position: relative;
  overflow: hidden;
  color: #fff;
}
.pd-hero::before {
  content: '';
  position: absolute;
  width: 320px; height: 320px;
  background: rgba(255,255,255,.08);
  border-radius: 50%;
  top: -80px; right: -60px;
}
.pd-hero::after {
  content: '';
  position: absolute;
  width: 180px; height: 180px;
  background: rgba(255,255,255,.06);
  border-radius: 50%;
  bottom: -50px; left: 60px;
}
.pd-hero-breadcrumb a { color: rgba(255,255,255,.75); text-decoration: none; font-size:.85rem; }
.pd-hero-breadcrumb a:hover { color: #fff; }
.pd-hero-breadcrumb span { color: rgba(255,255,255,.5); font-size:.85rem; }
.pd-hero-breadcrumb i { color: rgba(255,255,255,.4); font-size:.7rem; }
.pd-hero h1 { font-size: 1.85rem; font-weight: 700; margin: 8px 0 4px; }
.pd-hero-sub { color: rgba(255,255,255,.8); font-size:.9rem; }

/* ══ Action Buttons ═════════════════════════════════════════════ */
.pd-btn-edit {
  background: #fff; color: #7367f0;
  border: none; border-radius: 10px;
  padding: 10px 22px; font-weight: 600; font-size:.88rem;
  box-shadow: 0 4px 14px rgba(0,0,0,.15);
  transition: all .2s;
  text-decoration: none; display: inline-flex; align-items: center; gap: 6px;
}
.pd-btn-edit:hover { background: #f0eeff; color: #5a52d5; transform: translateY(-1px); }
.pd-btn-back {
  background: rgba(255,255,255,.15); color: #fff;
  border: 1.5px solid rgba(255,255,255,.35); border-radius: 10px;
  padding: 10px 20px; font-weight: 500; font-size:.88rem;
  transition: all .2s; text-decoration: none;
  display: inline-flex; align-items: center; gap: 6px;
}
.pd-btn-back:hover { background: rgba(255,255,255,.25); color:#fff; }

/* ══ Cards ══════════════════════════════════════════════════════ */
.pd-card {
  background: #fff;
  border-radius: 16px;
  border: 1px solid #e8e5ff;
  box-shadow: 0 2px 16px rgba(115,103,240,.07);
  overflow: hidden;
}
.pd-card-header {
  padding: 18px 24px;
  border-bottom: 1px solid #f0eeff;
  display: flex; align-items: center; gap: 12px;
}
.pd-card-icon {
  width: 36px; height: 36px; border-radius: 10px;
  background: linear-gradient(135deg, #7367f0, #9e95f5);
  display: flex; align-items: center; justify-content: center;
  flex-shrink: 0;
}
.pd-card-icon i { color: #fff; font-size: 17px; }
.pd-card-title { font-size: .95rem; font-weight: 700; color: #3d3d3d; margin: 0; }
.pd-card-body { padding: 24px; }

/* ══ Image Gallery ═══════════════════════════════════════════════ */
.pd-main-image-wrap {
  background: #f8f8ff;
  border-radius: 14px;
  border: 2px solid #e8e5ff;
  overflow: hidden;
  display: flex; align-items: center; justify-content: center;
  height: 380px;
}
.pd-main-image-wrap img {
  width: 100%; height: 100%; object-fit: contain; transition: transform .3s;
}
.pd-main-image-wrap img:hover { transform: scale(1.03); }
.pd-thumb-list {
  display: flex; gap: 10px; flex-wrap: wrap; margin-top: 14px;
}
.pd-thumb {
  width: 70px; height: 70px; border-radius: 10px;
  border: 2px solid #e8e5ff; object-fit: cover;
  cursor: pointer; transition: all .2s;
}
.pd-thumb:hover, .pd-thumb.active { border-color: #7367f0; box-shadow: 0 0 0 3px rgba(115,103,240,.2); }

/* ══ Badges ══════════════════════════════════════════════════════ */
.pd-badge-cat {
  background: #f0eeff; color: #7367f0;
  border-radius: 20px; padding: 4px 14px;
  font-size: .78rem; font-weight: 600; letter-spacing: .3px;
}
.pd-badge-stock-ok {
  background: #e8f7ee; color: #28a745;
  border-radius: 20px; padding: 4px 14px; font-size: .78rem; font-weight: 600;
}
.pd-badge-stock-out {
  background: #fef0f0; color: #ea5455;
  border-radius: 20px; padding: 4px 14px; font-size: .78rem; font-weight: 600;
}

/* ══ Price Block ═════════════════════════════════════════════════ */
.pd-price { font-size: 2.2rem; font-weight: 800; color: #7367f0; line-height: 1; }
.pd-price-sub { font-size: .82rem; color: #aaa; text-decoration: line-through; margin-top: 2px; }
.pd-discount-tag {
  display: inline-flex; align-items: center; gap: 4px;
  background: #fff3e0; color: #e65100;
  border: 1.5px solid #ffcc80;
  border-radius: 20px; padding: 3px 12px;
  font-size: .75rem; font-weight: 700;
  vertical-align: middle; margin-left: 8px;
}
.pd-discount-tag i { font-size: .7rem; }

/* ══ Stat Boxes ══════════════════════════════════════════════════ */
.pd-stat-grid { display: grid; grid-template-columns: repeat(3,1fr); gap: 12px; }
.pd-stat-box {
  background: #f8f8ff; border-radius: 12px; padding: 14px 12px;
  border: 1px solid #ebe9fe; text-align: center;
  transition: box-shadow .2s;
}
.pd-stat-box:hover { box-shadow: 0 4px 14px rgba(115,103,240,.12); }
.pd-stat-icon { font-size: 1.4rem; margin-bottom: 4px; }
.pd-stat-label { font-size: .72rem; color: #999; text-transform: uppercase; letter-spacing: .4px; }
.pd-stat-value { font-size: .95rem; font-weight: 700; color: #3d3d3d; margin-top: 2px; }

/* ══ Detail Rows ═════════════════════════════════════════════════ */
.pd-detail-row {
  display: flex; align-items: flex-start; padding: 12px 0;
  border-bottom: 1px solid #f4f4f4; gap: 12px;
}
.pd-detail-row:last-child { border-bottom: none; }
.pd-detail-label { min-width: 130px; font-size: .82rem; color: #999; font-weight: 600; text-transform: uppercase; letter-spacing: .4px; flex-shrink: 0; }
.pd-detail-value { font-size: .9rem; color: #3d3d3d; font-weight: 500; }

/* ══ Attributes ══════════════════════════════════════════════════ */
.pd-attr-table { width: 100%; border-collapse: separate; border-spacing: 0 6px; }
.pd-attr-table tr td:first-child {
  width: 40%; font-weight: 600; color: #555; font-size: .85rem;
  background: #f8f8ff; border-radius: 8px 0 0 8px;
  padding: 10px 16px; border: 1px solid #ebe9fe; border-right: none;
}
.pd-attr-table tr td:last-child {
  color: #3d3d3d; font-size: .88rem;
  background: #fff; border-radius: 0 8px 8px 0;
  padding: 10px 16px; border: 1px solid #ebe9fe; border-left: none;
}

/* ══ Barcode Section ═════════════════════════════════════════════ */
.pd-barcode-wrap {
  background: #fff; border-radius: 12px;
  border: 1px solid #e8e5ff; padding: 18px;
  text-align: center;
}
.pd-barcode-wrap img { max-height: 70px; object-fit: contain; }
.pd-barcode-code {
  font-family: monospace; font-size: .8rem; color: #888; margin-top: 6px;
}
</style>

<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

  <!-- ── Page Header ──────────────────────────────────────────── -->
    <div class="cat-page-header mb-4">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-box"></i>
        </div>
        <div>
          <h1 class="cat-page-title"><%$products[0]['name']%></h1>
          <div class="text-muted small mt-1">Product Details</div>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <a href="<%$base_url%>product">Products</a>
            <i class="ti ti-chevron-right"></i>
            <span><%$products[0]['name']%></span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <a href="<%$base_url%>update_product/<%$products[0]['product_id']%>" class="cat-btn cat-btn-primary text-white">
          <i class="ti ti-edit"></i> Edit Product
        </a>
        <a href="<%$base_url%>product" class="cat-btn cat-btn-outline">
          <i class="ti ti-arrow-left"></i> Back to List
        </a>
      </div>
    </div>

  <!-- ── Main Grid ──────────────────────────────────────────── -->
  <div class="row g-4">

    <!-- ── LEFT COLUMN ── -->
    <div class="col-lg-5">

      <!-- Image Card -->
      <div class="pd-card mb-4">
        <div class="pd-card-header">
          <div class="pd-card-icon"><i class="ti ti-photo"></i></div>
          <h6 class="pd-card-title">Product Gallery</h6>
        </div>
        <div class="pd-card-body">
          <div class="pd-main-image-wrap">
            <%if $products[0]['image']%>
              <img id="mainProductImage"
                src="<%$base_url%>public/uploads/product/product_image/<%$products[0]['product_id']%>/<%$products[0]['image']%>"
                onerror="this.src='<%$base_url%>public/assets/images/no_image.jpg';"
                alt="<%$products[0]['name']%>">
            <%else%>
              <img id="mainProductImage" src="<%$base_url%>public/assets/images/no_image.jpg" alt="No Image">
            <%/if%>
          </div>

          <!-- Thumbs: primary + gallery -->
          <%if $products[0]['image'] || (isset($product_images) && $product_images|@count > 0)%>
          <div class="pd-thumb-list">
            <%if $products[0]['image']%>
            <img class="pd-thumb active"
              src="<%$base_url%>public/uploads/product/product_image/<%$products[0]['product_id']%>/<%$products[0]['image']%>"
              onerror="this.src='<%$base_url%>public/assets/images/no_image.jpg';"
              onclick="switchImage(this, this.src)" alt="Primary">
            <%/if%>
            <%if isset($product_images) && $product_images|@count > 0%>
              <%foreach from=$product_images item=gi%>
              <img class="pd-thumb"
                src="<%$base_url%>public/uploads/product/product_image/<%$products[0]['product_id']%>/gallery/<%$gi['image']%>"
                onerror="this.src='<%$base_url%>public/assets/images/no_image.jpg';"
                onclick="switchImage(this, this.src)" alt="Gallery">
              <%/foreach%>
            <%/if%>
          </div>
          <%/if%>
        </div>
      </div>

      <!-- Barcode Card -->
      <%if $products[0]['line_bar_code']%>
      <div class="pd-card">
        <div class="pd-card-header">
          <div class="pd-card-icon"><i class="ti ti-barcode"></i></div>
          <h6 class="pd-card-title">Barcode</h6>
        </div>
        <div class="pd-card-body">
          <div class="pd-barcode-wrap">
            <img src="<%$base_url%>public/uploads/product/bar_code/<%$products[0]['product_id']%>/<%$products[0]['line_bar_code']%>.png"
              onerror="this.style.display='none'" alt="Barcode">
            <div class="pd-barcode-code mt-2"><%$products[0]['line_bar_code']%></div>
          </div>
        </div>
      </div>
      <%/if%>
    </div>

    <!-- ── RIGHT COLUMN ── -->
    <div class="col-lg-7">

      <!-- Pricing & Stock Card -->
      <div class="pd-card mb-4">
        <div class="pd-card-header">
          <div class="pd-card-icon"><i class="ti ti-box"></i></div>
          <h6 class="pd-card-title"><%$products[0]["name"]%></h6>
        </div>
        <div class="pd-card-body">

          <!-- Badges row -->
          <div class="d-flex align-items-center gap-2 mb-4 flex-wrap">
            <span class="pd-badge-cat"><%$products[0]['category_name']%></span>
            <span class="pd-badge-cat" style="background:#f0f8ff;color:#0d6efd;"><%$products[0]['brand_name']%></span>
            <%if $products[0]['qty'] > 0%>
              <span class="pd-badge-stock-ok"><i class="ti ti-circle-check me-1"></i>In Stock</span>
            <%else%>
              <span class="pd-badge-stock-out"><i class="ti ti-circle-x me-1"></i>Out of Stock</span>
            <%/if%>
          </div>

          <!-- Price -->
          <div class="d-flex align-items-flex-end gap-3 mb-4 flex-wrap">
            <div>
              <div class="pd-price">₹<%$products[0]['price']|default:0|number_format:2%></div>
              <%if $products[0]['actual_price'] && $products[0]['actual_price'] != $products[0]['price']%>
              <div class="pd-price-sub">MRP ₹<%$products[0]['actual_price']|number_format:2%></div>
              <%/if%>
            </div>
            <%if $products[0]['discount'] && $products[0]['discount'] > 0%>
            <span class="pd-discount-tag"><%$products[0]['discount']%>% OFF</span>
            <%/if%>
          </div>

          <!-- Stat Grid -->
          <div class="pd-stat-grid mb-2">
            <div class="pd-stat-box">
              <div class="pd-stat-icon">📦</div>
              <div class="pd-stat-label">Stock</div>
              <div class="pd-stat-value"><%$products[0]['qty']|default:0%> <%$products[0]['unit']|default:'Pcs'%></div>
            </div>
            <div class="pd-stat-box">
              <div class="pd-stat-icon">⚠️</div>
              <div class="pd-stat-label">Alert Qty</div>
              <div class="pd-stat-value"><%$products[0]['alert_qty']|default:'—'%></div>
            </div>
            <div class="pd-stat-box">
              <div class="pd-stat-icon">🏷️</div>
              <div class="pd-stat-label">Purchase Price</div>
              <div class="pd-stat-value">₹<%$products[0]['purchase_price']|default:0|number_format:2%></div>
            </div>
          </div>
        </div>
      </div>

      <!-- Product Details Card -->
      <div class="pd-card mb-4">
        <div class="pd-card-header">
          <div class="pd-card-icon"><i class="ti ti-info-square"></i></div>
          <h6 class="pd-card-title">Product Details</h6>
        </div>
        <div class="pd-card-body py-0">
          <div class="pd-detail-row">
            <span class="pd-detail-label">SKU / Code</span>
            <span class="pd-detail-value"><span class="badge bg-light text-dark fw-semibold border" style="font-family:monospace;"><%$products[0]['product_code']%></span></span>
          </div>
          <div class="pd-detail-row">
            <span class="pd-detail-label">HSN Code</span>
            <span class="pd-detail-value"><%$products[0]['hsn_code']|default:'—'%></span>
          </div>
          <div class="pd-detail-row">
            <span class="pd-detail-label">Tax Rate</span>
            <span class="pd-detail-value"><%$products[0]['tax_rate']|default:0%>%</span>
          </div>
          <div class="pd-detail-row">
            <span class="pd-detail-label">Description</span>
            <span class="pd-detail-value" style="line-height:1.7;"><%$products[0]['description']|nl2br|default:'No description available.'%></span>
          </div>
        </div>
      </div>

      <!-- Attributes Card -->
      <%if isset($product_attrs) && $product_attrs|@count > 0%>
      <div class="pd-card">
        <div class="pd-card-header">
          <div class="pd-card-icon"><i class="ti ti-adjustments-horizontal"></i></div>
          <h6 class="pd-card-title">Specifications</h6>
        </div>
        <div class="pd-card-body">
          <table class="pd-attr-table">
            <%foreach from=$product_attrs item=attr%>
            <tr>
              <td><%$attr['attr_name']%></td>
              <td><%$attr['attr_value']%></td>
            </tr>
            <%/foreach%>
          </table>
        </div>
      </div>
      <%/if%>

    </div><!-- /.col-lg-7 -->
  </div><!-- /.row -->
  </div>
</div>

<script>
  var base_url = <%$base_url|@json_encode%>;

  function switchImage(thumb, src) {
    document.getElementById('mainProductImage').src = src;
    document.querySelectorAll('.pd-thumb').forEach(function(t){ t.classList.remove('active'); });
    thumb.classList.add('active');
  }
</script>
