//
//  TenDaysForecast.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 20.01.2022.
//

import Foundation
import UIKit
import SnapKit

class TenDaysForecastSection: SectionConfiguratorProtocol {
   
    let cellIdentifier = "TenDaysForecastSectionCell"
    
    func getHeaderView() -> UIView? {
        let headerView = UILabel()
        headerView.text = "🗓 10 DAY FORECAST"
        return headerView
    }
    
    func getNumberOfRows() -> Int {
        1
    }
    
    init(tableView: UITableView){
        tableView.register(TenDaysForecastSectionView.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TenDaysForecastSectionView
    
        WeatherDataService.shared.requestByTenDays(place: "Калининград") { result in
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
