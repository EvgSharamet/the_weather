//
//  MainWindowcontroller.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 17.01.2022.
//

import Foundation
import SnapKit
import UIKit



class MainTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    let headerView = StretchyTableHeaderView()
    
    private enum TableViewSections: Int, CaseIterable {
        case hourlyForecast = 0
        case tenDaysForecast
        case uviSunriseWidgets
        case windPrecipitationWidgets
        case feelsLikeHumidityWidgets
        case visibilityPressureWidgets
    }
    
    private var hourlyForecastSection: HourlyForecastSection?
    private var tenDaysForecastSection: TenDaysForecastSection?
    private var uviSunriseWidgetSection: UVISunriseWidgetSection?
    private var windPrecipitationWidgetSection: WindPrecipitationWidgetSection?
    private var feelsLikeHumidityWidgetSection: FeelsLikeHumidityWidgetSection?
    private var visibilityPressureWidgetSection: VisibilityPressureWidgetSection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImageView = UIImageView(image: UIImage(named: "backgroundMainTable"))
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.height.equalTo(view.safeAreaLayoutGuide)
            maker.left.right.equalTo(view.safeAreaLayoutGuide).inset(10)
            maker.bottom.equalToSuperview()
        }
        
        self.view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
        headerView.prepare()
        self.tableView.tableHeaderView = headerView

        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        hourlyForecastSection = HourlyForecastSection(tableView: tableView)
        tenDaysForecastSection = TenDaysForecastSection(tableView: tableView)
        uviSunriseWidgetSection = UVISunriseWidgetSection(tableView: tableView)
        windPrecipitationWidgetSection = WindPrecipitationWidgetSection(tableView: tableView)
        feelsLikeHumidityWidgetSection = FeelsLikeHumidityWidgetSection(tableView: tableView)
        visibilityPressureWidgetSection = VisibilityPressureWidgetSection(tableView: tableView)
        updateData()
    }
    
    private func updateData() {
        let group = DispatchGroup()
        var oneDayResponse: WeatherDataService.OneDayResponse?
        var tenDaysResponse: WeatherDataService.TenDaysResponse?
        
        group.enter()
        group.enter()
        
        WeatherDataService.shared.requestByCurrentDay(place: "Калининград") { result in
            switch result {
            case .success(let weatherData):
                oneDayResponse = weatherData
            case .failure(_):
                print("Something goes wrong")
            }
            group.leave()
        }
        
        WeatherDataService.shared.requestByTenDays(place: "Калининград") { result in
            switch result {
            case .success(let weatherData):
                tenDaysResponse = weatherData
            case .failure(_):
                print("Something goes wrong")
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            guard let oneDayResponse = oneDayResponse else {
                return
            }
            guard let tenDaysResponse = tenDaysResponse else {
                return
            }

            self.hourlyForecastSection?.data = StringGeneratorForViewService.shared.getHourlyStringValue(rowDayData: oneDayResponse, rowTenDaysData: tenDaysResponse)
            self.tenDaysForecastSection?.data = StringGeneratorForViewService.shared.getTenDaysStringValue(dataTenDays: tenDaysResponse, currentDay: oneDayResponse)
            self.uviSunriseWidgetSection?.data = (StringGeneratorForViewService.shared.getUVIndexStringValue(rowData: oneDayResponse), StringGeneratorForViewService.shared.getSunriseStringValue(rowData: oneDayResponse))
            self.windPrecipitationWidgetSection?.data = (StringGeneratorForViewService.shared.getWindStringValue(rowData: oneDayResponse), StringGeneratorForViewService.shared.getPrecipitationStringValue(rowData: tenDaysResponse))
            self.feelsLikeHumidityWidgetSection?.data = (StringGeneratorForViewService.shared.getFeelsLikeStringValue(rowData: oneDayResponse), StringGeneratorForViewService.shared.getHumidityStringValue(rowData: oneDayResponse))
            self.visibilityPressureWidgetSection?.data = (StringGeneratorForViewService.shared.getVisibilityStringValue(rowData: oneDayResponse), StringGeneratorForViewService.shared.getPressureStringValue(rowData: oneDayResponse))
            
            let dataForHeader = StringGeneratorForViewService.shared.getHeaderStringValue(rowData: oneDayResponse, rowDataForMinMax: tenDaysResponse)
            print("DDAAAATTTAAAAA = \(dataForHeader)")
            self.headerView.configure(data: StretchyTableHeaderView.HeaderStringValue(cityName: dataForHeader.cityName, temp: dataForHeader.temp, description: dataForHeader.description, maxMinTemp: dataForHeader.maxMinTemp))
            self.tableView.reloadData()
        }
    }
}

extension MainTableController {
    
    func numberOfSections( in tableView: UITableView) -> Int {
        return TableViewSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let currentSection = getSectionConfigurator(section: section)!
        return currentSection.getHeaderView()
    }
    
    func tableView(_ tablerView: UITableView, numberOfRowsInSection section : Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let configurator = getSectionConfigurator(section: indexPath.section) else {
            return UITableViewCell()
        }
        let cell = configurator.tableView(tableView, cellForRowAt: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let configurator = getSectionConfigurator(section: indexPath.section) else {
            return UITableView.automaticDimension
        }
        return configurator.tableView(tableView, heightForRowAt: indexPath)
    }
    
    private func getSectionConfigurator(section: Int) -> SectionConfiguratorProtocol? {
        guard let section = TableViewSections(rawValue: section) else { return nil }
        switch section {
        case .hourlyForecast:
            return hourlyForecastSection
    
        case .tenDaysForecast:
            return tenDaysForecastSection
       
        case .uviSunriseWidgets:
            return uviSunriseWidgetSection
            
        case .windPrecipitationWidgets:
            return windPrecipitationWidgetSection
       
        case .feelsLikeHumidityWidgets:
            return feelsLikeHumidityWidgetSection
            
        case .visibilityPressureWidgets:
            return visibilityPressureWidgetSection
        }
    }
}
