import UIKit
import LightweightCharts

class CustomPriceFormatterViewController: UIViewController {

    enum SourceType: CaseIterable {
        case js
        case native
        
        var title: String {
            switch self {
            case .js:
                return "JavaScript"
            case .native:
                return "Swift"
            }
        }
    }
    
    enum FormatterType: CaseIterable {
        case dollar
        case pound
        
        var formatterString: String {
            switch self {
            case .dollar: return "function(price) { return '$' + price.toFixed(2); }"
            case .pound: return "function(price) { return '\u{00A3}' + price.toFixed(2); }"
            }
        }
        
        var formatterClosure: (BarPrice) -> String {
            switch self {
            case .dollar: return { "🦄$\(($0 * 100).rounded() / 100)" }
            case .pound: return { "☁️\u{00A3}\(($0 * 100).rounded() / 100)" }
            }
        }
        
        var title: String {
            switch self {
            case .dollar: return "Dollar"
            case .pound: return "Pound"
            }
        }
        
    }
    
    private var chart: LightweightCharts!
    private var series: AreaSeries!
    
    private var selectedFormat: FormatterType = .dollar {
        didSet {
            updateFormatter()
        }
    }
    private var selectedSource: SourceType = .js {
        didSet {
            updateFormatter()
        }
    }
    
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
        let sourceSegmentedControl = UISegmentedControl(items: SourceType.allCases.map { $0.title })
        sourceSegmentedControl.addTarget(self, action: #selector(sourceValueChanged), for: .valueChanged)
        view.addSubview(sourceSegmentedControl)
        sourceSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                sourceSegmentedControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                sourceSegmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                sourceSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                sourceSegmentedControl.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        sourceSegmentedControl.selectedSegmentIndex = 0
        
        let formatterSegmentedControl = UISegmentedControl(items: FormatterType.allCases.map { $0.title })
        formatterSegmentedControl.addTarget(self, action: #selector(formatterValueChanged), for: .valueChanged)
        view.addSubview(formatterSegmentedControl)
        formatterSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                formatterSegmentedControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                formatterSegmentedControl.bottomAnchor.constraint(equalTo: sourceSegmentedControl.topAnchor, constant: -8)
            ])
        } else {
            NSLayoutConstraint.activate([
                formatterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                formatterSegmentedControl.bottomAnchor.constraint(equalTo: sourceSegmentedControl.topAnchor, constant: -8)
            ])
        }
        formatterSegmentedControl.selectedSegmentIndex = 0
        
        
        let options = ChartOptions(
            layout: LayoutOptions(backgroundColor: "#000", textColor: "rgba(255, 255, 255, 0.8)"),
            rightPriceScale: VisiblePriceScaleOptions(borderColor: "rgba(255, 255, 255, 0.8)"),
            timeScale: TimeScaleOptions(borderColor: "rgba(255, 255, 255, 0.8)"),
            crosshair: CrosshairOptions(mode: .normal),
            grid: GridOptions(
                verticalLines: GridLineOptions(color: "rgba(255, 255, 255, 0.2)"),
                horizontalLines: GridLineOptions(color: "rgba(255, 255, 255, 0.2)")
            ),
            localization: LocalizationOptions(priceFormatter: .javaScript(FormatterType.allCases[0].formatterString))
        )
        let chart = LightweightCharts(options: options)
        view.addSubview(chart)
        chart.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                chart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                chart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                chart.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                chart.bottomAnchor.constraint(equalTo: formatterSegmentedControl.topAnchor, constant: -8)
            ])
        } else {
            NSLayoutConstraint.activate([
                chart.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                chart.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                chart.topAnchor.constraint(equalTo: view.topAnchor),
                chart.bottomAnchor.constraint(equalTo: formatterSegmentedControl.topAnchor, constant: -8)
            ])
        }
        self.chart = chart
    }
    
    private func setupData() {
        let options = AreaSeriesOptions(
            topColor: "rgba(21, 101, 192, 0.5)",
            bottomColor: "rgba(21, 101, 192, 0.5)",
            lineColor: "rgba(255, 255, 255, 0.8)",
            lineWidth: .two,
            crosshairMarkerBorderColor: "rgba(255, 255, 255, 1)",
            crosshairMarkerBackgroundColor: "rgba(100, 50, 20, 1)"
        )
        let series = chart.addAreaSeries(options: options)
        let data = [
            SingleValueData(time: .string("2018-10-19"), value: 72.35),
            SingleValueData(time: .string("2018-10-22"), value: 72.57),
            SingleValueData(time: .string("2018-10-23"), value: 72.10),
            SingleValueData(time: .string("2018-10-24"), value: 70.54),
            SingleValueData(time: .string("2018-10-25"), value: 69.96),
            SingleValueData(time: .string("2018-10-26"), value: 70.40),
            SingleValueData(time: .string("2018-10-29"), value: 71.45),
            SingleValueData(time: .string("2018-10-30"), value: 72.87),
            SingleValueData(time: .string("2018-10-31"), value: 73.61),
            SingleValueData(time: .string("2018-11-01"), value: 73.12),
            SingleValueData(time: .string("2018-11-02"), value: 72.27),
            SingleValueData(time: .string("2018-11-05"), value: 73.12),
            SingleValueData(time: .string("2018-11-06"), value: 73.31),
            SingleValueData(time: .string("2018-11-07"), value: 75.08),
            SingleValueData(time: .string("2018-11-08"), value: 75.48),
            SingleValueData(time: .string("2018-11-09"), value: 74.86),
            SingleValueData(time: .string("2018-11-12"), value: 74.69),
            SingleValueData(time: .string("2018-11-13"), value: 74.61),
            SingleValueData(time: .string("2018-11-14"), value: 74.09),
            SingleValueData(time: .string("2018-11-15"), value: 74.84),
            SingleValueData(time: .string("2018-11-16"), value: 76.06),
            SingleValueData(time: .string("2018-11-19"), value: 76.35),
            SingleValueData(time: .string("2018-11-20"), value: 74.78),
            SingleValueData(time: .string("2018-11-21"), value: 74.79),
            SingleValueData(time: .string("2018-11-23"), value: 74.67),
            SingleValueData(time: .string("2018-11-26"), value: 75.44),
            SingleValueData(time: .string("2018-11-27"), value: 76.34),
            SingleValueData(time: .string("2018-11-28"), value: 77.23),
            SingleValueData(time: .string("2018-11-29"), value: 77.91),
            SingleValueData(time: .string("2018-11-30"), value: 79.34),
            SingleValueData(time: .string("2018-12-03"), value: 79.22),
            SingleValueData(time: .string("2018-12-04"), value: 78.21),
            SingleValueData(time: .string("2018-12-06"), value: 78.37),
            SingleValueData(time: .string("2018-12-07"), value: 76.72),
            SingleValueData(time: .string("2018-12-10"), value: 77.42),
            SingleValueData(time: .string("2018-12-11"), value: 77.11),
            SingleValueData(time: .string("2018-12-12"), value: 78.01),
            SingleValueData(time: .string("2018-12-13"), value: 79.01),
            SingleValueData(time: .string("2018-12-14"), value: 76.48),
            SingleValueData(time: .string("2018-12-17"), value: 75.23),
            SingleValueData(time: .string("2018-12-18"), value: 74.33),
            SingleValueData(time: .string("2018-12-19"), value: 73.77),
            SingleValueData(time: .string("2018-12-20"), value: 73.49),
            SingleValueData(time: .string("2018-12-21"), value: 72.90),
            SingleValueData(time: .string("2018-12-24"), value: 71.15),
            SingleValueData(time: .string("2018-12-26"), value: 74.00),
            SingleValueData(time: .string("2018-12-27"), value: 75.38),
            SingleValueData(time: .string("2018-12-28"), value: 75.37),
            SingleValueData(time: .string("2018-12-31"), value: 76.41),
            SingleValueData(time: .string("2019-01-02"), value: 75.59),
            SingleValueData(time: .string("2019-01-03"), value: 74.04),
            SingleValueData(time: .string("2019-01-04"), value: 76.27),
            SingleValueData(time: .string("2019-01-07"), value: 75.43),
            SingleValueData(time: .string("2019-01-08"), value: 75.99),
            SingleValueData(time: .string("2019-01-09"), value: 75.41),
            SingleValueData(time: .string("2019-01-10"), value: 74.48),
            SingleValueData(time: .string("2019-01-11"), value: 74.90),
            SingleValueData(time: .string("2019-01-14"), value: 73.37),
            SingleValueData(time: .string("2019-01-15"), value: 74.50),
            SingleValueData(time: .string("2019-01-16"), value: 74.61),
            SingleValueData(time: .string("2019-01-17"), value: 75.60),
            SingleValueData(time: .string("2019-01-18"), value: 75.87),
            SingleValueData(time: .string("2019-01-22"), value: 75.83),
            SingleValueData(time: .string("2019-01-23"), value: 75.44),
            SingleValueData(time: .string("2019-01-24"), value: 73.17),
            SingleValueData(time: .string("2019-01-25"), value: 72.95),
            SingleValueData(time: .string("2019-01-28"), value: 72.92),
            SingleValueData(time: .string("2019-01-29"), value: 73.23),
            SingleValueData(time: .string("2019-01-30"), value: 73.37),
            SingleValueData(time: .string("2019-01-31"), value: 74.43),
            SingleValueData(time: .string("2019-02-01"), value: 76.45),
            SingleValueData(time: .string("2019-02-04"), value: 76.87),
            SingleValueData(time: .string("2019-02-05"), value: 77.15),
            SingleValueData(time: .string("2019-02-06"), value: 77.39),
            SingleValueData(time: .string("2019-02-07"), value: 76.82),
            SingleValueData(time: .string("2019-02-08"), value: 77.52),
            SingleValueData(time: .string("2019-02-11"), value: 76.71),
            SingleValueData(time: .string("2019-02-12"), value: 78.52),
            SingleValueData(time: .string("2019-02-13"), value: 79.02),
            SingleValueData(time: .string("2019-02-14"), value: 78.94),
            SingleValueData(time: .string("2019-02-15"), value: 79.81),
            SingleValueData(time: .string("2019-02-19"), value: 79.24),
            SingleValueData(time: .string("2019-02-20"), value: 79.43),
            SingleValueData(time: .string("2019-02-21"), value: 79.83),
            SingleValueData(time: .string("2019-02-22"), value: 80.77),
            SingleValueData(time: .string("2019-02-25"), value: 80.38),
            SingleValueData(time: .string("2019-02-26"), value: 80.74),
            SingleValueData(time: .string("2019-02-27"), value: 80.62),
            SingleValueData(time: .string("2019-02-28"), value: 81.29),
            SingleValueData(time: .string("2019-03-01"), value: 81.65),
            SingleValueData(time: .string("2019-03-04"), value: 81.37),
            SingleValueData(time: .string("2019-03-05"), value: 81.70),
            SingleValueData(time: .string("2019-03-06"), value: 80.76),
            SingleValueData(time: .string("2019-03-07"), value: 80.45),
            SingleValueData(time: .string("2019-03-08"), value: 79.80),
            SingleValueData(time: .string("2019-03-11"), value: 80.87),
            SingleValueData(time: .string("2019-03-12"), value: 81.23),
            SingleValueData(time: .string("2019-03-13"), value: 81.60),
            SingleValueData(time: .string("2019-03-14"), value: 81.49),
            SingleValueData(time: .string("2019-03-15"), value: 81.57),
            SingleValueData(time: .string("2019-03-18"), value: 81.35),
            SingleValueData(time: .string("2019-03-19"), value: 81.91),
            SingleValueData(time: .string("2019-03-20"), value: 82.08),
            SingleValueData(time: .string("2019-03-21"), value: 82.95),
            SingleValueData(time: .string("2019-03-22"), value: 82.29),
            SingleValueData(time: .string("2019-03-25"), value: 82.35),
            SingleValueData(time: .string("2019-03-26"), value: 82.92),
            SingleValueData(time: .string("2019-03-27"), value: 82.29),
            SingleValueData(time: .string("2019-03-28"), value: 82.63),
            SingleValueData(time: .string("2019-03-29"), value: 83.17),
            SingleValueData(time: .string("2019-04-01"), value: 83.30),
            SingleValueData(time: .string("2019-04-02"), value: 83.21),
            SingleValueData(time: .string("2019-04-03"), value: 83.18),
            SingleValueData(time: .string("2019-04-04"), value: 81.85),
            SingleValueData(time: .string("2019-04-05"), value: 81.15),
            SingleValueData(time: .string("2019-04-08"), value: 80.95),
            SingleValueData(time: .string("2019-04-09"), value: 80.80),
            SingleValueData(time: .string("2019-04-10"), value: 80.82),
            SingleValueData(time: .string("2019-04-11"), value: 79.84),
            SingleValueData(time: .string("2019-04-12"), value: 79.43),
            SingleValueData(time: .string("2019-04-15"), value: 78.53),
            SingleValueData(time: .string("2019-04-16"), value: 77.56),
            SingleValueData(time: .string("2019-04-17"), value: 73.92),
            SingleValueData(time: .string("2019-04-18"), value: 73.19),
            SingleValueData(time: .string("2019-04-22"), value: 73.46),
            SingleValueData(time: .string("2019-04-23"), value: 74.60),
            SingleValueData(time: .string("2019-04-24"), value: 74.73),
            SingleValueData(time: .string("2019-04-25"), value: 76.34),
            SingleValueData(time: .string("2019-04-26"), value: 76.63),
            SingleValueData(time: .string("2019-04-29"), value: 76.78),
            SingleValueData(time: .string("2019-04-30"), value: 78.71),
            SingleValueData(time: .string("2019-05-01"), value: 78.72),
            SingleValueData(time: .string("2019-05-02"), value: 79.52),
            SingleValueData(time: .string("2019-05-03"), value: 80.00),
            SingleValueData(time: .string("2019-05-06"), value: 79.48),
            SingleValueData(time: .string("2019-05-07"), value: 77.90),
            SingleValueData(time: .string("2019-05-08"), value: 78.18),
            SingleValueData(time: .string("2019-05-09"), value: 78.33),
            SingleValueData(time: .string("2019-05-10"), value: 78.19),
            SingleValueData(time: .string("2019-05-13"), value: 77.17),
            SingleValueData(time: .string("2019-05-14"), value: 77.42),
            SingleValueData(time: .string("2019-05-15"), value: 77.55),
            SingleValueData(time: .string("2019-05-16"), value: 79.13),
            SingleValueData(time: .string("2019-05-17"), value: 78.72),
            SingleValueData(time: .string("2019-05-20"), value: 78.88),
            SingleValueData(time: .string("2019-05-21"), value: 79.50),
            SingleValueData(time: .string("2019-05-22"), value: 80.98),
            SingleValueData(time: .string("2019-05-23"), value: 81.02),
            SingleValueData(time: .string("2019-05-24"), value: 81.17),
            SingleValueData(time: .string("2019-05-28"), value: 81.10)
        ]
        series.setData(data: data)
        self.series = series
    }

    private func updateFormatter() {
        let method: JavaScriptMethod<BarPrice, String>
        switch selectedSource {
        case .js:
            method = .javaScript(selectedFormat.formatterString)
        case .native:
            method = .closure(selectedFormat.formatterClosure)
        }
        
        let options = ChartOptions(localization: LocalizationOptions(priceFormatter: method))
        chart.applyOptions(options: options)
    }
    
    @objc private func formatterValueChanged(_ sender: UISegmentedControl) {
        selectedFormat = FormatterType.allCases[sender.selectedSegmentIndex]
    }
    
    @objc private func sourceValueChanged(_ sender: UISegmentedControl) {
        selectedSource = SourceType.allCases[sender.selectedSegmentIndex]
    }
    
}
