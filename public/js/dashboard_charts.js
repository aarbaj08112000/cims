document.addEventListener('DOMContentLoaded', function () {
    const successColor = '#28c76f'; // Green
    const dangerColor = '#ff6b6b';  // Salmon/Orange-Red
    const violetColor = '#7367f0'; // Brand Theme

    // Top Selling Palette
    const doughnutPalette = ['#7367f0', '#8e44ad', '#a29bfe', '#2ecc71', '#00cfe8'];

    // Sales Trend Chart (Last 12 Months)
    const salesCtx = document.getElementById('salesPurchasesChart');
    if (salesCtx && typeof monthlySalesLabels !== 'undefined') {
        new Chart(salesCtx, {
            type: 'bar',
            data: {
                labels: monthlySalesLabels,
                datasets: [
                    {
                        label: 'Sales',
                        data: monthlySalesValues,
                        backgroundColor: violetColor,
                        borderRadius: 4,
                        barPercentage: 0.6,
                        categoryPercentage: 0.5
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: { usePointStyle: true, boxWidth: 8 }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: { drawBorder: false },
                        ticks: {
                            callback: function (value) {
                                if (value >= 1000) return (value / 1000) + 'k';
                                return value;
                            }
                        }
                    },
                    x: {
                        grid: { display: false },
                        drawBorder: false
                    }
                }
            }
        });
    }

    // Top Selling Products (Doughnut)
    const stockCtx = document.getElementById('stockStatusChart');
    if (stockCtx && typeof topProductLabels !== 'undefined') {
        new Chart(stockCtx, {
            type: 'doughnut',
            data: {
                labels: topProductLabels,
                datasets: [{
                    data: topProductValues,
                    backgroundColor: doughnutPalette,
                    borderWidth: 0,
                    hoverOffset: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: { usePointStyle: true, boxWidth: 8, padding: 15 }
                    }
                }
            }
        });
    }
});
