//
//  HourlyForecastSection.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 17.01.2022.
//

import Foundation
import UIKit

struct HourlyForecastSection: SectionConfiguratorProtocol {
    
    let cellIdentifier = "HourlyForecastSectionCell"
    
    func getHeaderView() -> UIView? {
       let headerView = UILabel()
        headerView.backgroundColor = .blue.withAlphaComponent(0.1)
        headerView.text = "☔"
        return headerView
    }
    
    func getHeaderTitle() -> String? {
        return "HOURLY FORECAST"
    }
    
    init(tableView: UITableView){
        tableView.register(HourlyForecastCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func getNumberOfRows() -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HourlyForecastCell
        cell.prepare()
        
        WeatherDataService.shared.requestByCurrentDay(place: "Калининград") { result in
            switch result {
                case .success(let weatherData):
                    print("HERE")
                    cell.setData(data: weatherData)
                case .failure(_):
                    print("Something goes wrong")
            }
        }
        return cell
    }
}
