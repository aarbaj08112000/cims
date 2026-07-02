$(document).ready(function () {
	grid.init();
})

const grid = {
	init: function () {

	},
	setDefaultView: function (module_name) {
		var default_page_dispay = default_page_view_type[module_name];
		if (default_page_dispay == "Grid") {
			$(".toggle-grid-btn .table").removeClass("active");
			$(".toggle-grid-btn .grid").addClass("active");
		} else {
			$(".toggle-grid-btn .grid").removeClass("active");
			$(".toggle-grid-btn .table").addClass("active");
		}
	},
	gridStructure: function (module_name = "", row_data = [], no_data_message) {
		let that = this;
		grid_html = "";
		switch (module_name) {
			case "User":
				grid_html = `<div class="row g-4 p-3">`;
				if (row_data.length > 0) {
					for (var i = 0; i < row_data.length; i++) {
						var row_details = row_data[i]._aData;

						// Extract the modal target from the Action column HTML (col 5)
						var actionHtml  = row_details[5] || '';
						var modalMatch  = actionHtml.match(/data-bs-target="(#updatePromo\d+)"/);
						var modalTarget = modalMatch ? modalMatch[1] : '';

						var isActive    = (row_details[4] || '').trim() === 'Active';
						var statusClass = isActive ? 'cat-badge-active' : 'cat-badge-inactive';
						var statusText  = (row_details[4] || '').trim() || '—';
						var name        = (row_details[0] || '').trim();
						var email       = (row_details[1] || '').trim();
						var role        = (row_details[3] || '').trim() || '—';
						var initials    = name.charAt(0).toUpperCase() || 'U';
						var palette     = ['#696cff','#27ae60','#f59e0b','#e74c3c','#0dcaf0','#6f42c1'];
						var color       = palette[name.charCodeAt(0) % palette.length];

						let row_html = `
						<div class="col-xl-3 col-lg-4 col-md-6 col-12">
						  <div style="
						    background:#fff;
						    border-radius:14px;
						    border:1px solid #e2e6ef;
						    box-shadow:0 2px 20px rgba(0,0,0,0.06);
						    overflow:hidden;
						    transition:transform .25s,box-shadow .25s;
						    font-family:'Inter',sans-serif;
						  "
						  onmouseover="this.style.transform='translateY(-4px)';this.style.boxShadow='0 10px 30px rgba(0,0,0,0.12)';"
						  onmouseout="this.style.transform='';this.style.boxShadow='0 2px 20px rgba(0,0,0,0.06)';">

						    <!-- Colour bar -->
						    <div style="height:5px;background:linear-gradient(90deg,${color},${color}88);"></div>

						    <!-- Avatar + Name -->
						    <div style="padding:20px 20px 14px;display:flex;align-items:center;gap:14px;">
						      <div style="
						        width:52px;height:52px;border-radius:50%;flex-shrink:0;
						        background:${color}18;color:${color};
						        border:2px solid ${color}44;
						        display:flex;align-items:center;justify-content:center;
						        font-size:1.3rem;font-weight:800;
						      ">${initials}</div>
						      <div style="flex:1;min-width:0;">
						        <div style="font-size:.93rem;font-weight:700;color:#1e293b;
						          white-space:nowrap;overflow:hidden;text-overflow:ellipsis;" title="${name}">${name}</div>
						        <div style="font-size:.76rem;color:#8490a7;
						          white-space:nowrap;overflow:hidden;text-overflow:ellipsis;margin-top:2px;" title="${email}">${email}</div>
						      </div>
						    </div>

						    <!-- Divider -->
						    <div style="height:1px;background:#f1f3f9;margin:0 18px;"></div>

						    <!-- Info rows -->
						    <div style="padding:12px 18px 0;">
						      <div style="display:flex;align-items:center;gap:8px;padding:5px 0;border-bottom:1px solid #f8f9fc;">
						        <span style="font-size:.7rem;font-weight:700;color:#8490a7;text-transform:uppercase;letter-spacing:.5px;width:60px;flex-shrink:0;">Role</span>
						        <span style="font-size:.84rem;color:#3d4f6f;font-weight:600;">${role}</span>
						      </div>
						      <div style="display:flex;align-items:center;gap:8px;padding:5px 0;">
						        <span style="font-size:.7rem;font-weight:700;color:#8490a7;text-transform:uppercase;letter-spacing:.5px;width:60px;flex-shrink:0;">Status</span>
						        <span class="cat-badge ${statusClass}" style="padding:3px 10px;font-size:.71rem;">
						          <span class="cat-badge-dot"></span>${statusText}
						        </span>
						      </div>
						    </div>

						    <!-- Footer -->
						    <div style="padding:12px 18px 16px;display:flex;justify-content:flex-end;">
						      <button class="cat-btn cat-btn-primary"
						        style="height:32px;padding:0 14px;font-size:.8rem;"
						        ${modalTarget ? 'data-bs-toggle="modal" data-bs-target="'+modalTarget+'"' : ''}>
						        <i class="ti ti-edit" style="font-size:.9rem;"></i> Edit
						      </button>
						    </div>

						  </div>
						</div>`;
						grid_html += row_html;

					}
				} else {
					grid_html += that.noDataFound(no_data_message);
				}
				grid_html += `</div>`;
				break;

			default:
				break;
		}

		return grid_html;
	},
	noDataFound: function (no_data_message) {
		no_data_html = `<div class="col-12 text-center grid-no-message mt-5 pt-5">${no_data_message}</div>`;
		return no_data_html;
	}
}