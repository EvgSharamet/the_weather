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
        headerView.text = "🕘 HOURLY FORECAST"
        return headerView
    }
    
    init(tableView: UITableView){
        tableView.register(HourlyForecastSectionView.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func getNumberOfRows() -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HourlyForecastSectionView
        
        WeatherDataService.shared.requestByCurrentDay(place: "Калининград") { result in
            switch result {
                case .success(let weatherData):
                    cell.setData(data: weatherData)
                case .failure(_):
                    print("Something goes wrong")
            }
        }
        return cell
    }
}
