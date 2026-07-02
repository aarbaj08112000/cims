<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<style>
    :root {
        --dash-primary: #7367f0;
        --dash-success: #28c76f;
        --dash-danger: #ea5455;
        --dash-warning: #ff9f43;
        --dash-info: #00cfe8;
        --dash-secondary: #82868b;
        --dash-bg: #f8f7fa;
        --card-shadow: var(--cat-shadow, 0 2px 16px rgba(91,95,199,0.09));
        --card-shadow-hover: 0 8px 24px rgba(91,95,199,0.15);
    }

    .dashboard-wrapper {
        padding: 2rem;
    }

    .header-section {
        margin-bottom: 2.5rem;
    }

    .header-section h2 {
        font-weight: 800;
        color: #2f2b3d;
        letter-spacing: -0.04em;
        margin-bottom: 0.25rem;
    }

    .header-section p {
        font-size: 1.1rem;
        opacity: 0.8;
    }

    /* Metric Cards Redesign */
    .metric-card-premium {
        background: #fff;
        border-radius: var(--cat-radius, 12px);
        padding: 1.25rem;
        border: 1px solid var(--cat-border, rgba(115, 103, 240, 0.05));
        box-shadow: var(--card-shadow);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .metric-card-premium:hover {
        transform: translateY(-8px);
        box-shadow: var(--card-shadow-hover);
        border-color: rgba(115, 103, 240, 0.2);
    }

    .metric-icon-box {
        width: 48px;
        height: 48px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 1rem;
        font-size: 1.4rem;
        transition: transform 0.3s ease;
    }

    .metric-card-premium:hover .metric-icon-box {
        transform: scale(1.1) rotate(5deg);
    }

    .icon-blue { background: linear-gradient(135deg, rgba(115, 103, 240, 0.15), rgba(115, 103, 240, 0.05)); color: #7367f0; }
    .icon-green { background: linear-gradient(135deg, rgba(40, 199, 111, 0.15), rgba(40, 199, 111, 0.05)); color: #28c76f; }
    .icon-orange { background: linear-gradient(135deg, rgba(255, 159, 67, 0.15), rgba(255, 159, 67, 0.05)); color: #ff9f43; }
    .icon-red { background: linear-gradient(135deg, rgba(234, 84, 85, 0.15), rgba(234, 84, 85, 0.05)); color: #ea5455; }
    .icon-cyan { background: linear-gradient(135deg, rgba(0, 207, 232, 0.15), rgba(0, 207, 232, 0.05)); color: #00cfe8; }
    .icon-indigo { background: linear-gradient(135deg, rgba(30, 42, 210, 0.15), rgba(30, 42, 210, 0.05)); color: #1e2ad2; }

    .metric-info h3 {
        font-size: 1.35rem;
        font-weight: 700;
        color: #2f2b3d;
        margin: 0;
        letter-spacing: -0.01em;
    }

    .metric-info span {
        font-size: 0.85rem;
        color: #82868b;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 0.02em;
    }

    /* Section Cards */
    .dashboard-card {
        background: #fff;
        border-radius: var(--cat-radius, 12px);
        border: 1px solid var(--cat-border, #e8ecf3);
        box-shadow: var(--card-shadow);
        height: 100%;
        overflow: hidden;
        transition: box-shadow 0.3s ease;
    }

    .dashboard-card:hover {
        box-shadow: var(--card-shadow-hover);
    }

    .card-title-box {
        padding: 1.25rem 1.5rem;
        border-bottom: 1px solid var(--cat-border, #f1f1f2);
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: #fff;
    }

    .card-title-box h5 {
        margin: 0;
        font-weight: 600;
        color: #2f2b3d;
        font-size: 1.05rem;
    }

    .card-body-content {
        padding: 1.5rem;
    }

    /* Tiny Progress Bars/Stats */
    .mini-stat-item {
        margin-bottom: 1.5rem;
        padding: 1rem;
        background: #fdfdff;
        border-radius: 12px;
        border: 1px solid #f1f1f2;
    }

    .mini-stat-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 0.5rem;
        font-size: 0.85rem;
        font-weight: 600;
        color: #5d596c;
    }

    .progress-tiny {
        height: 8px;
        border-radius: 10px;
        background-color: #f1f1f2;
    }

    /* Activity List */
    .activity-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .activity-item {
        display: flex;
        align-items: center;
        padding: 1rem 0;
        border-bottom: 1px solid #f8f7fa;
        transition: transform 0.2s ease;
    }

    .activity-item:hover {
        transform: translateX(3px);
    }

    .activity-item:last-child { border-bottom: none; }

    .activity-point {
        width: 10px;
        height: 10px;
        border-radius: 50%;
        margin-right: 1rem;
        flex-shrink: 0;
    }

    .activity-text {
        font-size: 0.85rem;
        color: #5d596c;
        font-weight: 500;
    }

    .activity-time {
        margin-left: auto;
        font-size: 0.8rem;
        color: #b9b9c3;
        font-weight: 500;
    }

    /* Badge Label Styling */
    .badge-label-purple { background: rgba(115, 103, 240, 0.12); color: #7367f0; padding: 0.5rem 1rem; border-radius: 8px; font-weight: 700; }
    .badge-label-success { background: rgba(40, 199, 111, 0.12); color: #28c76f; padding: 0.5rem 1rem; border-radius: 8px; font-weight: 700; }
    .badge-label-danger { background: rgba(234, 84, 85, 0.12); color: #ea5455; padding: 0.5rem 1rem; border-radius: 8px; font-weight: 700; }
    .badge-label-warning { background: rgba(255, 159, 67, 0.12); color: #ff9f43; padding: 0.5rem 1rem; border-radius: 8px; font-weight: 700; }

    /* Table Styling */
    .table thead th {
        background-color: rgba(115, 103, 240, 0.03);
        border: none;
        text-transform: uppercase;
        font-size: 0.75rem;
        letter-spacing: 0.1em;
        font-weight: 700;
        color: #82868b;
        padding: 1rem 1.5rem;
    }

    .table tbody td {
        padding: 1.25rem 1.5rem;
        vertical-align: middle;
        border-color: #f8f7fa;
    }

    .table-hover tbody tr:hover {
        background-color: rgba(115, 103, 240, 0.02);
    }

    /* Month Summary Widget */
    .month-summary-box {
        margin-top: 1.5rem;
        padding: 1.5rem;
        background: linear-gradient(135deg, rgba(115, 103, 240, 0.03), rgba(115, 103, 240, 0.01));
        border-radius: 16px;
        border: 1px dashed rgba(115, 103, 240, 0.2);
        display: flex;
        justify-content: space-around;
        align-items: center;
    }

    .summary-item {
        text-align: center;
    }

    .summary-item .label {
        display: block;
        font-size: 0.75rem;
        font-weight: 600;
        color: #82868b;
        text-transform: uppercase;
        margin-bottom: 0.25rem;
        letter-spacing: 0.02em;
    }

    .summary-item .value {
        display: block;
        font-size: 1.15rem;
        font-weight: 700;
        color: #2f2b3d;
    }

    .summary-divider {
        width: 1px;
        height: 40px;
        background-color: rgba(115, 103, 240, 0.1);
    }
</style>

</style>

<!-- Load ApexCharts -->
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>

<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <!-- Page Header -->
    <div class="cat-page-header mb-4">
      <div class="cat-page-header-left">
        <div class="cat-page-icon"><i class="ti ti-chart-pie"></i></div>
        <div>
          <h1 class="cat-page-title">Dashboard Analytics</h1>
          <nav class="cat-breadcrumb">
             <span class="text-muted">Discover your business trends and performance at a glance.</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <button class="cat-btn cat-btn-primary">
            <i class="ti ti-download"></i> Export Report
        </button>
      </div>
    </div>

    <!-- 6 Summary Cards Row -->
    <div class="row g-4 mb-4">
        <!-- Total Sales -->
        <div class="col-xl-2 col-lg-4 col-md-6">
            <div class="metric-card-premium">
                <div class="metric-icon-box icon-blue">
                    <i class="ti ti-currency-dollar"></i>
                </div>
                <div class="metric-info">
                    <h3><%$stats.total_sales|default:0|number_format:0%></h3>
                    <span>Total Sales</span>
                </div>
            </div>
        </div>
        <!-- Total Orders -->
        <div class="col-xl-2 col-lg-4 col-md-6">
            <div class="metric-card-premium">
                <div class="metric-icon-box icon-indigo">
                    <i class="ti ti-shopping-cart"></i>
                </div>
                <div class="metric-info">
                    <h3><%$stats.total_orders_count|default:0%></h3>
                    <span>Total Orders</span>
                </div>
            </div>
        </div>
        <!-- Total Stock -->
        <div class="col-xl-2 col-lg-4 col-md-6">
            <div class="metric-card-premium">
                <div class="metric-icon-box icon-green">
                    <i class="ti ti-box"></i>
                </div>
                <div class="metric-info">
                    <h3><%$stats.total_stock_qty|default:0|number_format:0%></h3>
                    <span>Total Stock</span>
                </div>
            </div>
        </div>
        <!-- Total Categories -->
        <div class="col-xl-2 col-lg-4 col-md-6">
            <div class="metric-card-premium">
                <div class="metric-icon-box icon-orange">
                    <i class="ti ti-category"></i>
                </div>
                <div class="metric-info">
                    <h3><%$stats.total_categories|default:0%></h3>
                    <span>Categories</span>
                </div>
            </div>
        </div>
        <!-- Low Stock -->
        <div class="col-xl-2 col-lg-4 col-md-6">
            <div class="metric-card-premium">
                <div class="metric-icon-box icon-red">
                    <i class="ti ti-alert-triangle"></i>
                </div>
                <div class="metric-info">
                    <h3 class="text-danger"><%$stats.low_stock_count|default:0%></h3>
                    <span>Low Stock</span>
                </div>
            </div>
        </div>
         <!-- Total Customers -->
         <div class="col-xl-2 col-lg-4 col-md-6">
            <div class="metric-card-premium">
                <div class="metric-icon-box icon-cyan">
                    <i class="ti ti-user-check"></i>
                </div>
                <div class="metric-info">
                    <h3><%$stats.total_customers|default:0%></h3>
                    <span>Customers</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Row -->
    <div class="row g-4 mb-4">
        <!-- Main Sales Bar Chart -->
        <div class="col-xl-8">
            <div class="dashboard-card pt-2">
                <div class="card-title-box">
                    <h5>Monthly Sales & Orders</h5>
                    <div class="badge badge-label-purple">Analytics</div>
                </div>
                <div class="card-body-content">
                    <div id="salesOrdersChart" style="min-height: 400px;"></div>
                    
                    <!-- New Current Month Stats Widget -->
                    <div class="month-summary-box">
                        <div class="summary-item">
                            <span class="label"><i class="ti ti-calendar-event me-1"></i> This Month Sales</span>
                            <span class="value text-primary"><%$settings.company_currency.value|default:"$"%><%$curr_month_stats.month_sales|default:0|number_format:2%></span>
                        </div>
                        <div class="summary-divider"></div>
                        <div class="summary-item">
                            <span class="label"><i class="ti ti-shopping-cart me-1"></i> This Month Orders</span>
                            <span class="value text-success"><%$curr_month_stats.month_orders|default:0%></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Category Pie Chart -->
        <div class="col-xl-4">
            <div class="dashboard-card pt-2">
                <div class="card-title-box">
                    <h5>Category Distribution</h5>
                </div>
                <div class="card-body-content d-flex flex-column align-items-center">
                    <div id="categoryPieChart" style="min-height: 300px; width: 100%;"></div>
                    <div class="w-100 mt-4">
                        <h6 class="mb-3 fw-bold">Summary Status</h6>
                        <!-- Mini Stats Example -->
                        <div class="mini-stat-item">
                            <div class="mini-stat-header">
                                <span>Total Revenue Growth</span>
                                <span class="text-success">+12.5%</span>
                            </div>
                            <div class="progress progress-tiny">
                                <div class="progress-bar bg-success" style="width: 75%"></div>
                            </div>
                        </div>
                        <div class="mini-stat-item">
                            <div class="mini-stat-header">
                                <span>Inventory Turn rate</span>
                                <span class="text-info">85%</span>
                            </div>
                            <div class="progress progress-tiny">
                                <div class="progress-bar bg-info" style="width: 85%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bottom Lists Row -->
    <div class="row g-4">
        <!-- Recent Orders -->
        <div class="col-xl-5 col-lg-6">
            <div class="dashboard-card">
                <div class="card-title-box">
                    <h5>Recent Transactions</h5>
                    <a href="sales_list" class="text-primary small fw-bold">View All</a>
                </div>
                <div class="card-body-content p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0" style="font-size: 0.85rem;">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4">ID</th>
                                    <th>Customer</th>
                                    <th>Date</th>
                                    <th class="text-end pe-4">Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%foreach from=$recent_sales item=sale%>
                                <tr>
                                    <td class="ps-4 fw-semibold">#<%$sale.sales_id%></td>
                                    <td><%$sale.customer_name|default:'Walk-in'%></td>
                                    <td><%$sale.sales_date|date_format:"%d %b"%></td>
                                    <td class="text-end pe-4 fw-bold text-dark"><%$settings.company_currency.value%><%$sale.total_amount|number_format:2%></td>
                                </tr>
                                <%/foreach%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Products & Low Stock -->
        <div class="col-xl-7 col-lg-6">
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="dashboard-card">
                        <div class="card-title-box">
                            <h5>New Products</h5>
                        </div>
                        <div class="card-body-content">
                            <ul class="activity-list">
                                <%foreach from=$recent_products item=p%>
                                <li class="activity-item">
                                    <div class="activity-point bg-primary"></div>
                                    <div class="activity-text fw-semibold"><%$p.name|truncate:25%></div>
                                    <div class="activity-time"><%$p.qty%> in stock</div>
                                </li>
                                <%/foreach%>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="dashboard-card">
                        <div class="card-title-box">
                            <h5 class="text-danger">Low Stock Alerts</h5>
                        </div>
                        <div class="card-body-content">
                            <ul class="activity-list">
                                <%foreach from=$low_stock_alerts item=l%>
                                <li class="activity-item">
                                    <div class="activity-point bg-danger"></div>
                                    <div class="activity-text"><%$l.product_name|truncate:20%></div>
                                    <div class="activity-time text-danger fw-bold"><%$l.qty%> / <%$l.alert_qty%></div>
                                </li>
                                <%/foreach%>
                                <%if count($low_stock_alerts) == 0%>
                                    <li class="activity-item">
                                        <div class="activity-text text-muted">All stock levels healthy.</div>
                                    </li>
                                <%/if%>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- Area Chart for Area Trends -->
                <div class="col-12">
                    <div class="dashboard-card">
                        <div class="card-title-box">
                            <h5>Sales Trend (Daily)</h5>
                        </div>
                        <div class="card-body-content">
                            <div id="salesTrendChart" style="min-height: 200px;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
  </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Data from PHP
        const mLabels = <%if isset($monthly_sales_labels)%><%$monthly_sales_labels|@json_encode%><%else%>[]<%/if%>;
        const mSales = <%if isset($monthly_sales_values)%><%$monthly_sales_values|@json_encode%><%else%>[]<%/if%>;
        const mOrders = <%if isset($monthly_order_values)%><%$monthly_order_values|@json_encode%><%else%>[]<%/if%>;
        
        const catLabels = <%if isset($cat_labels)%><%$cat_labels|@json_encode%><%else%>[]<%/if%>;
        const catValues = <%if isset($cat_values)%><%$cat_values|@json_encode%><%else%>[]<%/if%>;

        const trendLabels = <%if isset($trend_labels)%><%$trend_labels|@json_encode%><%else%>[]<%/if%>;
        const trendValues = <%if isset($trend_values)%><%$trend_values|@json_encode%><%else%>[]<%/if%>;

        // 1. Sales & Orders Bar/Line Chart
        var salesOrdersOptions = {
            series: [{
                name: 'Sales Revenue',
                type: 'column',
                data: mSales
            }, {
                name: 'Order Count',
                type: 'line',
                data: mOrders
            }],
            chart: {
                height: 400,
                type: 'line',
                toolbar: { show: false },
                fontFamily: 'var(--cat-font)',
                dropShadow: {
                    enabled: true,
                    color: '#000',
                    top: 18,
                    left: 7,
                    blur: 10,
                    opacity: 0.1
                }
            },
            stroke: {
                width: [0, 4],
                curve: 'smooth',
                dashArray: [0, 0]
            },
            plotOptions: {
                bar: {
                    columnWidth: '45%',
                    borderRadius: 8,
                    borderRadiusApplication: 'around', // 'around', 'end'
                    borderRadiusWhenStacked: 'last',
                }
            },
            colors: ['#7367f0', '#28c76f'],
            dataLabels: {
                enabled: false
            },
            fill: {
                opacity: [0.85, 1],
                gradient: {
                    inverseColors: false,
                    shade: 'light',
                    type: "vertical",
                    opacityFrom: 1,
                    opacityTo: 0.45,
                    stops: [0, 100, 100, 100]
                }
            },
            labels: mLabels,
            markers: {
                size: 5,
                colors: ['#fff'],
                strokeColors: '#28c76f',
                strokeWidth: 2,
                hover: {
                    size: 8,
                }
            },
            legend: {
                position: 'top',
                horizontalAlign: 'right',
                offsetY: -30,
                fontWeight: 600,
                fontSize: '14px',
                markers: {
                    radius: 12
                }
            },
            xaxis: {
                axisBorder: { show: false },
                axisTicks: { show: false },
                labels: {
                    style: { colors: '#82868b', fontWeight: 600 }
                }
            },
            grid: {
                borderColor: '#f1f1f2',
                strokeDashArray: 4,
                padding: {
                    bottom: 0
                }
            },
            yaxis: [{
                title: { text: 'Monthly Revenue', style: { color: '#7367f0', fontWeight: 700, fontSize: '12px' } },
                labels: {
                    style: { colors: '#82868b', fontWeight: 600 },
                    formatter: function(val) { return '<%$settings.company_currency.value|default:"$"%>' + val.toLocaleString(); }
                }
            }, {
                opposite: true,
                title: { text: 'Orders Count', style: { color: '#28c76f', fontWeight: 700, fontSize: '12px' } },
                labels: {
                    style: { colors: '#82868b', fontWeight: 600 }
                }
            }],
            tooltip: {
                shared: true,
                intersect: false,
                theme: 'light',
                y: {
                    formatter: function(y) {
                        if (typeof y !== "undefined") {
                            return y.toFixed(0);
                        }
                        return y;
                    }
                }
            }
        };
        var salesOrdersChart = new ApexCharts(document.querySelector("#salesOrdersChart"), salesOrdersOptions);
        salesOrdersChart.render();

        // 2. Category Pie Chart
        var catPieOptions = {
            series: catValues,
            chart: {
                type: 'donut',
                height: 350,
                fontFamily: 'var(--cat-font)'
            },
            labels: catLabels,
            colors: ['#7367f0', '#28c76f', '#ff9f43', '#00cfe8', '#ea5455'],
            legend: {
                position: 'bottom',
                fontSize: '14px',
                fontWeight: 600
            },
            dataLabels: { enabled: false },
            plotOptions: {
                pie: {
                    donut: {
                        size: '75%',
                        labels: {
                            show: true,
                            total: {
                                show: true,
                                label: 'Total Qty',
                                fontSize: '15px',
                                fontWeight: 600,
                                color: '#82868b',
                                formatter: function(w) {
                                    return w.globals.seriesTotals.reduce((a, b) => a + b, 0)
                                }
                            },
                            value: {
                                show: true,
                                fontSize: '24px',
                                fontWeight: 800,
                                color: '#2f2b3d'
                            }
                        }
                    }
                }
            }
        };
        var categoryPieChart = new ApexCharts(document.querySelector("#categoryPieChart"), catPieOptions);
        categoryPieChart.render();

        // 3. Sales Trend Area Chart
        var trendOptions = {
            series: [{
                name: 'Daily Sales',
                data: trendValues
            }],
            chart: {
                height: 250,
                type: 'area',
                toolbar: { show: false },
                zoom: { enabled: false },
                fontFamily: 'var(--cat-font)'
            },
            colors: ['#7367f0'],
            dataLabels: { enabled: false },
            stroke: { curve: 'smooth', width: 3 },
            grid: {
                borderColor: '#f1f1f2',
                strokeDashArray: 5,
                xaxis: { lines: { show: true } },
                yaxis: { lines: { show: true } },
                padding: { top: 0, right: 0, bottom: 0, left: 0 }
            },
            xaxis: {
                categories: trendLabels,
                labels: { 
                    style: { colors: '#82868b', fontWeight: 600 },
                    rotate: -45,
                    offsetY: 5
                },
                axisBorder: { show: false },
                axisTicks: { show: false }
            },
            yaxis: {
                labels: {
                    style: { colors: '#82868b', fontWeight: 600 },
                    formatter: function(val) { return val.toFixed(0); }
                }
            },
            fill: {
                type: 'gradient',
                gradient: {
                    shadeIntensity: 1,
                    opacityFrom: 0.5,
                    opacityTo: 0.05,
                    stops: [0, 90, 100]
                }
            },
            markers: {
                size: 4,
                colors: ['#7367f0'],
                strokeColors: '#fff',
                strokeWidth: 2,
                hover: { size: 7 }
            },
            tooltip: {
                theme: 'light',
                y: {
                    formatter: function(val) {
                        return '<%$settings.company_currency.value|default:"$"%>' + val.toLocaleString();
                    }
                }
            }
        };
        var salesTrendChart = new ApexCharts(document.querySelector("#salesTrendChart"), trendOptions);
        salesTrendChart.render();
    });
</script>

