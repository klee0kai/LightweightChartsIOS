import UIKit
import LightweightCharts

class CustomWatermarkViewController: UIViewController {

    private var chart: LightweightCharts!
    private var series: AreaSeries!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        setupUI()
        setupData()
    }
    
    private func setupUI() {
        let options = ChartOptions(
            watermark: WatermarkOptions(
                color: "rgba(171, 71, 188, 0.5)",
                visible: true,
                text: "Watermark Example",
                fontSize: 24,
                horizontalAlignment: .center,
                verticalAlignment: .center
            ),
            layout: LayoutOptions(backgroundColor: "#ffffff", textColor: "#333"),
            rightPriceScale: VisiblePriceScaleOptions(scaleMargins: PriceScaleMargins(top: 0.1, bottom: 0.2)),
            grid: GridOptions(
                verticalLines: GridLineOptions(color: "#eee"),
                horizontalLines: GridLineOptions(color: "#ffffff")
            )
        )
        let chart = LightweightCharts(options: options)
        view.addSubview(chart)
        chart.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                chart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                chart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                chart.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                chart.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                chart.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                chart.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                chart.topAnchor.constraint(equalTo: view.topAnchor),
                chart.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        self.chart = chart
    }
    
    private func setupData() {
        let options = AreaSeriesOptions(
            topColor: "rgba(171, 71, 188, 0.56)",
            bottomColor: "rgba(171, 71, 188, 0.04)",
            lineColor: "rgba(171, 71, 188, 1)",
            lineWidth: .two
        )
        let series = chart.addAreaSeries(options: options)
        let data = [            
            SingleValueData(time: .string("2018-10-19"), value: 75.46),
            SingleValueData(time: .string("2018-10-22"), value: 76.69),
            SingleValueData(time: .string("2018-10-23"), value: 73.82),
            SingleValueData(time: .string("2018-10-24"), value: 71.50),
            SingleValueData(time: .string("2018-10-25"), value: 72.74),
            SingleValueData(time: .string("2018-10-26"), value: 72.06),
            SingleValueData(time: .string("2018-10-29"), value: 70.56),
            SingleValueData(time: .string("2018-10-30"), value: 73.47),
            SingleValueData(time: .string("2018-10-31"), value: 72.64),
            SingleValueData(time: .string("2018-11-01"), value: 74.28),
            SingleValueData(time: .string("2018-11-02"), value: 72.86),
            SingleValueData(time: .string("2018-11-05"), value: 74.59),
            SingleValueData(time: .string("2018-11-06"), value: 75.48),
            SingleValueData(time: .string("2018-11-07"), value: 76.82),
            SingleValueData(time: .string("2018-11-08"), value: 75.57),
            SingleValueData(time: .string("2018-11-09"), value: 74.25),
            SingleValueData(time: .string("2018-11-12"), value: 74.42),
            SingleValueData(time: .string("2018-11-13"), value: 72.43),
            SingleValueData(time: .string("2018-11-14"), value: 72.51),
            SingleValueData(time: .string("2018-11-15"), value: 73.06),
            SingleValueData(time: .string("2018-11-16"), value: 73.40),
            SingleValueData(time: .string("2018-11-19"), value: 71.23),
            SingleValueData(time: .string("2018-11-20"), value: 68.18),
            SingleValueData(time: .string("2018-11-21"), value: 69.49),
            SingleValueData(time: .string("2018-11-23"), value: 67.31),
            SingleValueData(time: .string("2018-11-26"), value: 68.43),
            SingleValueData(time: .string("2018-11-27"), value: 68.09),
            SingleValueData(time: .string("2018-11-28"), value: 69.30),
            SingleValueData(time: .string("2018-11-29"), value: 69.91),
            SingleValueData(time: .string("2018-11-30"), value: 69.50),
            SingleValueData(time: .string("2018-12-03"), value: 72.42),
            SingleValueData(time: .string("2018-12-04"), value: 70.78),
            SingleValueData(time: .string("2018-12-06"), value: 69.01),
            SingleValueData(time: .string("2018-12-07"), value: 68.57),
            SingleValueData(time: .string("2018-12-10"), value: 67.67),
            SingleValueData(time: .string("2018-12-11"), value: 68.01),
            SingleValueData(time: .string("2018-12-12"), value: 68.79),
            SingleValueData(time: .string("2018-12-13"), value: 69.75),
            SingleValueData(time: .string("2018-12-14"), value: 68.20),
            SingleValueData(time: .string("2018-12-17"), value: 67.02),
            SingleValueData(time: .string("2018-12-18"), value: 64.75),
            SingleValueData(time: .string("2018-12-19"), value: 63.09),
            SingleValueData(time: .string("2018-12-20"), value: 62.19),
            SingleValueData(time: .string("2018-12-21"), value: 61.42),
            SingleValueData(time: .string("2018-12-24"), value: 60.07),
            SingleValueData(time: .string("2018-12-26"), value: 62.54),
            SingleValueData(time: .string("2018-12-27"), value: 61.67),
            SingleValueData(time: .string("2018-12-28"), value: 60.98),
            SingleValueData(time: .string("2018-12-31"), value: 61.55),
            SingleValueData(time: .string("2019-01-02"), value: 60.91),
            SingleValueData(time: .string("2019-01-03"), value: 61.15),
            SingleValueData(time: .string("2019-01-04"), value: 62.81),
            SingleValueData(time: .string("2019-01-07"), value: 62.55),
            SingleValueData(time: .string("2019-01-08"), value: 63.89),
            SingleValueData(time: .string("2019-01-09"), value: 65.45),
            SingleValueData(time: .string("2019-01-10"), value: 64.86),
            SingleValueData(time: .string("2019-01-11"), value: 63.47),
            SingleValueData(time: .string("2019-01-14"), value: 62.45),
            SingleValueData(time: .string("2019-01-15"), value: 63.45),
            SingleValueData(time: .string("2019-01-16"), value: 63.73),
            SingleValueData(time: .string("2019-01-17"), value: 63.96),
            SingleValueData(time: .string("2019-01-18"), value: 64.93),
            SingleValueData(time: .string("2019-01-22"), value: 61.83),
            SingleValueData(time: .string("2019-01-23"), value: 61.94),
            SingleValueData(time: .string("2019-01-24"), value: 63.22),
            SingleValueData(time: .string("2019-01-25"), value: 64.07),
            SingleValueData(time: .string("2019-01-28"), value: 63.20),
            SingleValueData(time: .string("2019-01-29"), value: 63.57),
            SingleValueData(time: .string("2019-01-30"), value: 64.28),
            SingleValueData(time: .string("2019-01-31"), value: 64.27),
            SingleValueData(time: .string("2019-02-01"), value: 64.63),
            SingleValueData(time: .string("2019-02-04"), value: 64.37),
            SingleValueData(time: .string("2019-02-05"), value: 64.57),
            SingleValueData(time: .string("2019-02-06"), value: 63.70),
            SingleValueData(time: .string("2019-02-07"), value: 63.41),
            SingleValueData(time: .string("2019-02-08"), value: 63.37),
            SingleValueData(time: .string("2019-02-11"), value: 62.32),
            SingleValueData(time: .string("2019-02-12"), value: 62.89),
            SingleValueData(time: .string("2019-02-13"), value: 63.72),
            SingleValueData(time: .string("2019-02-14"), value: 63.89),
            SingleValueData(time: .string("2019-02-15"), value: 64.48),
            SingleValueData(time: .string("2019-02-19"), value: 66.38),
            SingleValueData(time: .string("2019-02-20"), value: 67.38),
            SingleValueData(time: .string("2019-02-21"), value: 66.48),
            SingleValueData(time: .string("2019-02-22"), value: 67.54),
            SingleValueData(time: .string("2019-02-25"), value: 66.80),
            SingleValueData(time: .string("2019-02-26"), value: 67.26),
            SingleValueData(time: .string("2019-02-27"), value: 67.25),
            SingleValueData(time: .string("2019-02-28"), value: 65.86),
            SingleValueData(time: .string("2019-03-01"), value: 65.92),
            SingleValueData(time: .string("2019-03-04"), value: 66.04),
            SingleValueData(time: .string("2019-03-05"), value: 66.36),
            SingleValueData(time: .string("2019-03-06"), value: 65.68),
            SingleValueData(time: .string("2019-03-07"), value: 64.41),
            SingleValueData(time: .string("2019-03-08"), value: 63.72),
            SingleValueData(time: .string("2019-03-11"), value: 64.85),
            SingleValueData(time: .string("2019-03-12"), value: 64.96),
            SingleValueData(time: .string("2019-03-13"), value: 65.25),
            SingleValueData(time: .string("2019-03-14"), value: 64.90),
            SingleValueData(time: .string("2019-03-15"), value: 65.12),
            SingleValueData(time: .string("2019-03-18"), value: 66.70),
            SingleValueData(time: .string("2019-03-19"), value: 67.71),
            SingleValueData(time: .string("2019-03-20"), value: 68.60),
            SingleValueData(time: .string("2019-03-21"), value: 68.41),
            SingleValueData(time: .string("2019-03-22"), value: 66.03),
            SingleValueData(time: .string("2019-03-25"), value: 65.06),
            SingleValueData(time: .string("2019-03-26"), value: 65.31),
            SingleValueData(time: .string("2019-03-27"), value: 64.93),
            SingleValueData(time: .string("2019-03-28"), value: 65.49),
            SingleValueData(time: .string("2019-03-29"), value: 65.43),
            SingleValueData(time: .string("2019-04-01"), value: 66.66),
            SingleValueData(time: .string("2019-04-02"), value: 65.92),
            SingleValueData(time: .string("2019-04-03"), value: 65.89),
            SingleValueData(time: .string("2019-04-04"), value: 66.64),
            SingleValueData(time: .string("2019-04-05"), value: 67.28),
            SingleValueData(time: .string("2019-04-08"), value: 67.58),
            SingleValueData(time: .string("2019-04-09"), value: 67.29),
            SingleValueData(time: .string("2019-04-10"), value: 67.04),
            SingleValueData(time: .string("2019-04-11"), value: 65.80),
            SingleValueData(time: .string("2019-04-12"), value: 65.70),
            SingleValueData(time: .string("2019-04-15"), value: 64.53),
            SingleValueData(time: .string("2019-04-16"), value: 64.51),
            SingleValueData(time: .string("2019-04-17"), value: 64.01),
            SingleValueData(time: .string("2019-04-18"), value: 64.59),
            SingleValueData(time: .string("2019-04-22"), value: 65.41),
            SingleValueData(time: .string("2019-04-23"), value: 65.25),
            SingleValueData(time: .string("2019-04-24"), value: 64.45),
            SingleValueData(time: .string("2019-04-25"), value: 64.04),
            SingleValueData(time: .string("2019-04-26"), value: 63.59),
            SingleValueData(time: .string("2019-04-29"), value: 63.67),
            SingleValueData(time: .string("2019-04-30"), value: 63.29),
            SingleValueData(time: .string("2019-05-01"), value: 62.94),
            SingleValueData(time: .string("2019-05-02"), value: 61.85),
            SingleValueData(time: .string("2019-05-03"), value: 62.42),
            SingleValueData(time: .string("2019-05-06"), value: 61.93),
            SingleValueData(time: .string("2019-05-07"), value: 60.05),
            SingleValueData(time: .string("2019-05-08"), value: 60.02),
            SingleValueData(time: .string("2019-05-09"), value: 59.34),
            SingleValueData(time: .string("2019-05-10"), value: 58.94),
            SingleValueData(time: .string("2019-05-13"), value: 57.87),
            SingleValueData(time: .string("2019-05-14"), value: 59.11),
            SingleValueData(time: .string("2019-05-15"), value: 58.41),
            SingleValueData(time: .string("2019-05-16"), value: 58.90),
            SingleValueData(time: .string("2019-05-17"), value: 58.07),
            SingleValueData(time: .string("2019-05-20"), value: 58.10),
            SingleValueData(time: .string("2019-05-21"), value: 58.38),
            SingleValueData(time: .string("2019-05-22"), value: 57.85),
            SingleValueData(time: .string("2019-05-23"), value: 56.31),
            SingleValueData(time: .string("2019-05-24"), value: 57.36),
            SingleValueData(time: .string("2019-05-28"), value: 57.19)
        ]
        series.setData(data: data)
        self.series = series
    }

}
