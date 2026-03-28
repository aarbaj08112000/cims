<style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

    :root {
        --dash-primary: #7367f0;
        --dash-success: #28c76f;
        --dash-danger: #ea5455;
        --dash-warning: #ff9f43;
        --dash-info: #00cfe8;
        --dash-secondary: #82868b;
        
        /* Gradients */
        --grad-blue: linear-gradient(135deg, #7367f0 0%, #ce9ffc 100%);
        --grad-green: linear-gradient(135deg, #28c76f 0%, #81fbb8 100%);
        --grad-orange: linear-gradient(135deg, #ff9f43 0%, #feb019 100%);
        --grad-red: linear-gradient(135deg, #ea5455 0%, #ff8a71 100%);
        --grad-cyan: linear-gradient(135deg, #00cfe8 0%, #a2f9ff 100%);
        --grad-indigo: linear-gradient(135deg, #1e2ad2 0%, #838aec 100%);
    }

    body {
        font-family: 'Inter', sans-serif !important;
        background-color: #f8f7fa;
    }

    .dashboard-wrapper {
        padding: 1.5rem;
    }

    .header-section {
        margin-bottom: 2rem;
    }

    .header-section h2 {
        font-weight: 700;
        color: #444050;
        letter-spacing: -0.02em;
    }

    /* Metric Cards Redesign */
    .metric-card-premium {
        background: #fff;
        border-radius: 16px;
        padding: 1.5rem;
        border: 1px solid rgba(0,0,0,0.05);
        box-shadow: 0 4px 24px 0 rgba(34, 41, 47, 0.05);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    .metric-card-premium:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 32px 0 rgba(34, 41, 47, 0.1);
    }

    .metric-icon-box {
        width: 48px;
        height: 48px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 1rem;
        font-size: 1.5rem;
    }

    .icon-blue { background: rgba(115, 103, 240, 0.12); color: #7367f0; }
    .icon-green { background: rgba(40, 199, 111, 0.12); color: #28c76f; }
    .icon-orange { background: rgba(255, 159, 67, 0.12); color: #ff9f43; }
    .icon-red { background: rgba(234, 84, 85, 0.12); color: #ea5455; }
    .icon-cyan { background: rgba(0, 207, 232, 0.12); color: #00cfe8; }
    .icon-indigo { background: rgba(30, 42, 210, 0.12); color: #1e2ad2; }

    .metric-info h3 {
        font-size: 1.75rem;
        font-weight: 800;
        color: #444050;
        margin: 0;
    }

    .metric-info span {
        font-size: 0.875rem;
        color: #82868b;
        font-weight: 500;
    }

    /* Section Cards */
    .dashboard-card {
        background: #fff;
        border-radius: 16px;
        border: 1px solid rgba(0,0,0,0.05);
        box-shadow: 0 4px 24px 0 rgba(34, 41, 47, 0.05);
        height: 100%;
        overflow: hidden;
    }

    .card-title-box {
        padding: 1.5rem;
        border-bottom: 1px solid #f1f1f2;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .card-title-box h5 {
        margin: 0;
        font-weight: 700;
        color: #444050;
        font-size: 1.1rem;
    }

    .card-body-content {
        padding: 1.5rem;
    }

    /* Tiny Progress Bars/Stats */
    .mini-stat-item {
        margin-bottom: 1.25rem;
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
        height: 6px;
        border-radius: 10px;
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
        padding: 0.85rem 0;
        border-bottom: 1px solid #f8f7fa;
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
        font-size: 0.875rem;
        color: #5d596c;
    }

    .activity-time {
        margin-left: auto;
        font-size: 0.75rem;
        color: #b9b9c3;
    }

    /* Badge Label Styling */
    .badge-label-purple { background: rgba(115, 103, 240, 0.12); color: #7367f0; }
    .badge-label-success { background: rgba(40, 199, 111, 0.12); color: #28c76f; }
    .badge-label-danger { background: rgba(234, 84, 85, 0.12); color: #ea5455; }
    .badge-label-warning { background: rgba(255, 159, 67, 0.12); color: #ff9f43; }

</style>

<!-- Load ApexCharts -->
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>

<div class="dashboard-wrapper">
    <!-- Header -->
    <div class="header-section d-flex justify-content-between align-items-center">
        <div>
            <h2>Dashboard Overview</h2>
            <p class="text-muted mb-0">Welcome back! Here's what's happening today.</p>
        </div>
        <div class="d-flex gap-2">
            <button class="btn btn-primary btn-sm px-3 shadow-sm rounded-pill"><i class="ti ti-download me-1"></i> Report</button>
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
                    <div id="salesOrdersChart" style="min-height: 380px;"></div>
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
                height: 380,
                type: 'line',
                toolbar: { show: false },
                zoom: { enabled: false }
            },
            stroke: {
                width: [0, 4],
                curve: 'smooth'
            },
            colors: ['#7367f0', '#28c76f'],
            dataLabels: {
                enabled: false
            },
            labels: mLabels,
            legend: {
                position: 'top',
                horizontalAlign: 'left'
            },
            yaxis: [{
                title: { text: 'Revenue (<%$settings.company_currency.value|default:"$"%>)', style: { color: '#7367f0' } },
            }, {
                opposite: true,
                title: { text: 'Orders', style: { color: '#28c76f' } }
            }]
        };
        var salesOrdersChart = new ApexCharts(document.querySelector("#salesOrdersChart"), salesOrdersOptions);
        salesOrdersChart.render();

        // 2. Category Pie Chart
        var catPieOptions = {
            series: catValues,
            chart: {
                type: 'donut',
                height: 300
            },
            labels: catLabels,
            colors: ['#7367f0', '#28c76f', '#ff9f43', '#00cfe8', '#ea5455'],
            legend: {
                position: 'bottom'
            },
            plotOptions: {
                pie: {
                    donut: {
                        size: '70%',
                        labels: {
                            show: true,
                            total: {
                                show: true,
                                label: 'Products',
                                fontWeight: 700,
                                formatter: function(w) {
                                    return w.globals.seriesTotals.reduce((a, b) => a + b, 0)
                                }
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
                height: 200,
                type: 'area',
                toolbar: { show: false },
                sparkline: { enabled: false }
            },
            colors: ['#7367f0'],
            dataLabels: { enabled: false },
            stroke: { curve: 'smooth', width: 2 },
            xaxis: {
                categories: trendLabels,
                labels: { show: false },
                axisBorder: { show: false },
                axisTicks: { show: false }
            },
            yaxis: { show: false },
            fill: {
                type: 'gradient',
                gradient: {
                    shadeIntensity: 1,
                    opacityFrom: 0.7,
                    opacityTo: 0.3,
                    stops: [0, 90, 100]
                }
            }
        };
        var salesTrendChart = new ApexCharts(document.querySelector("#salesTrendChart"), trendOptions);
        salesTrendChart.render();
    });
</script>

