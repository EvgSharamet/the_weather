//
//  MainWindowcontroller.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 17.01.2022.
//

import Foundation
import SnapKit
import UIKit



class MainTableController: UITableViewController {
    
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
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "night.png")!)
        
        hourlyForecastSection = HourlyForecastSection(tableView: tableView)
        tenDaysForecastSection = TenDaysForecastSection(tableView: tableView)
        uviSunriseWidgetSection = UVISunriseWidgetSection(tableView: tableView)
        windPrecipitationWidgetSection = WindPrecipitationWidgetSection(tableView: tableView)
        feelsLikeHumidityWidgetSection = FeelsLikeHumidityWidgetSection(tableView: tableView)
        visibilityPressureWidgetSection = VisibilityPressureWidgetSection(tableView: tableView)
        
        WeatherDataService.shared.requestByCurrentDay(place: "Калининград") { result in
            switch result {
            case .success(let weatherData):
                print(weatherData)
                self.hourlyForecastSection?.data = weatherData
                self.uviSunriseWidgetSection?.data = weatherData
                self.windPrecipitationWidgetSection?.data = weatherData
                self.feelsLikeHumidityWidgetSection?.data = weatherData
                self.visibilityPressureWidgetSection?.data = weatherData
                self.tableView.reloadData()
            case .failure(_):
                    print("Something goes wrong")
            }
        }
        
        WeatherDataService.shared.requestByTenDays(place: "Калининград") { result in
            switch result {
                case .success(let weatherData):
                    self.tenDaysForecastSection?.data = weatherData
                self.windPrecipitationWidgetSection?.dataForPrecipitation = weatherData.list.first
                    self.tableView.reloadData()
                case .failure(_):
                    print("Something goes wrong")
            }
        }
    }
    
    override func numberOfSections( in tableView: UITableView) -> Int {
        return TableViewSections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let currentSection = getSectionConfigurator(section: section)!
        return currentSection.getHeaderView()
    }
    
    override func tableView(_ tablerView: UITableView, numberOfRowsInSection section : Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let configurator = getSectionConfigurator(section: indexPath.section) else {
            return UITableViewCell()
        }

        let cell =  configurator.tableView(tableView, cellForRowAt: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
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
