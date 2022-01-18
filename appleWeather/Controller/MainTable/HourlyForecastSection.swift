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
    let data: WeatherDataService.OneDayResponse?
    
    func getHeaderView() -> UIView? {
       let headerView = UILabel()
        headerView.backgroundColor = .blue.withAlphaComponent(0.1)
        headerView.text = "☔"
        return headerView
    }
    
    func getHeaderTitle() -> String? {
        return "HOURLY FORECAAST"
    }
    
    
    init(tableView: UITableView){
        tableView.register(HourlyForecastCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func getNumberOfRows() -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HourlyForecastCell
        cell.setData(data: data)
        return cell
    }
}
