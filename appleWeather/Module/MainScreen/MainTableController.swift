//
//  MainWindowcontroller.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 17.01.2022.
//

import Foundation
import SnapKit
import UIKit


class MainTableController: UIViewController {
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
    
    private var hourlyForecastSection: HourlyForecastSectionConfigurator?
    private var tenDaysForecastSection: TenDaysForecastSectionConfigurator?
    private var uviSunriseWidgetSection: UVISunriseWidgetSectionConfigurator?
    private var windPrecipitationWidgetSection: WindPrecipitationWidgetSectionConfigurator?
    private var feelsLikeHumidityWidgetSection: FeelsLikeHumidityWidgetSectionConfigurator?
    private var visibilityPressureWidgetSection: VisibilityPressureWidgetSectionConfigurator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImageView = UIImageView(image: UIImage(named: "backgroundDayMainScreen"))
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
        
        self.tableView.tableHeaderView = headerView
        headerView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(self.tableView.safeAreaLayoutGuide)
        }
        headerView.prepare()

        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        hourlyForecastSection = HourlyForecastSectionConfigurator(tableView: tableView)
        tenDaysForecastSection = TenDaysForecastSectionConfigurator(tableView: tableView)
        uviSunriseWidgetSection = UVISunriseWidgetSectionConfigurator(tableView: tableView)
        windPrecipitationWidgetSection = WindPrecipitationWidgetSectionConfigurator(tableView: tableView)
        feelsLikeHumidityWidgetSection = FeelsLikeHumidityWidgetSectionConfigurator(tableView: tableView)
        visibilityPressureWidgetSection = VisibilityPressureWidgetSectionConfigurator(tableView: tableView)
        updateData()
    }
    
    private func updateData() {
        let group = DispatchGroup()
        var oneDayResponse: WeatherDataService.OneDayResponse?
        var tenDaysResponse: WeatherDataService.TenDaysResponse?
        
        group.enter()
        group.enter()
        
        LocationService.shared.requestLocation { result in
            switch result {
            case .success(let coordinate):
                WeatherDataService.shared.requestByCurrentDay(location: WeatherDataService.Coordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)) { result in
                    switch result {
                    case .success(let weatherData):
                        oneDayResponse = weatherData
                    case .failure(_):
                        print("Something goes wrong")
                    }
                    group.leave()
                }
            
                WeatherDataService.shared.requestByTenDays(location: WeatherDataService.Coordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)) { result in
                switch result {
                    case .success(let weatherData):
                        tenDaysResponse = weatherData
                    case .failure(_):
                        print("Something goes wrong")
                    }
                    group.leave()
                }
                
            case .failure(_):
                print("Wrong coordinates")
            }
                
            group.notify(queue: .main) {
                guard let oneDayResponse = oneDayResponse, let tenDaysResponse = tenDaysResponse else {
                    return
                }

                self.hourlyForecastSection?.data = StringGeneratorForViewService.shared.getHourlyStringValue(rowDayData: oneDayResponse, rowTenDaysData: tenDaysResponse)
                self.tenDaysForecastSection?.data = StringGeneratorForViewService.shared.getTenDaysStringValue(dataTenDays: tenDaysResponse, currentDay: oneDayResponse)
                self.uviSunriseWidgetSection?.data =  UVISunriseWidgetSectionConfigurator.Data(uvindex: StringGeneratorForViewService.shared.getUVIndexStringValue(rowData: oneDayResponse), sunrise: StringGeneratorForViewService.shared.getSunriseStringValue(rowData: oneDayResponse))
                self.windPrecipitationWidgetSection?.data =  WindPrecipitationWidgetSectionConfigurator.Data(wind: StringGeneratorForViewService.shared.getWindStringValue(rowData: oneDayResponse), precipitation: StringGeneratorForViewService.shared.getPrecipitationStringValue(rowData: tenDaysResponse))
                self.feelsLikeHumidityWidgetSection?.data = FeelsLikeHumidityWidgetSectionConfigurator.Data(feelsLike: StringGeneratorForViewService.shared.getFeelsLikeStringValue(rowData: oneDayResponse), humidity: StringGeneratorForViewService.shared.getHumidityStringValue(rowData: oneDayResponse))
                self.visibilityPressureWidgetSection?.data = VisibilityPressureWidgetSectionConfigurator.Data(visibility: StringGeneratorForViewService.shared.getVisibilityStringValue(rowData: oneDayResponse), pressure: StringGeneratorForViewService.shared.getPressureStringValue(rowData: oneDayResponse))
                
                let dataForHeader = StringGeneratorForViewService.shared.getHeaderStringValue(rowData: oneDayResponse, rowDataForMinMax: tenDaysResponse)
                self.headerView.configure(data: StretchyTableHeaderView.HeaderStringValue(cityName: dataForHeader.cityName, temp: dataForHeader.temp, description: dataForHeader.description, maxMinTemp: dataForHeader.maxMinTemp))
                self.tableView.reloadData()
            }
        }
    }
}

extension MainTableController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections( in tableView: UITableView) -> Int {
        return TableViewSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let currentSection = getSectionConfigurator(section: section) else { return nil }
        return currentSection.getHeaderView()
    }
    
    func tableView(_ tablerView: UITableView, numberOfRowsInSection section : Int) -> Int {
        guard let configurator = getSectionConfigurator(section: section) else {
            return 0
        }
        return configurator.getNumberOfRows()
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

extension MainTableController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       headerView.scrollViewDidScroll(scrollView)
    }
}
