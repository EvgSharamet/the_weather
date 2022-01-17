//
//  HourlyForecastSection.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 17.01.2022.
//

import Foundation
import UIKit

struct HourlyForecastSection {
    
    let cellIdentifier = "HourlyForecastSectionCell"
    
    init(tableView: UITableView){
        tableView.register(HourlyForecastCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func getNumbersOfRows() -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HourlyForecastCell
        return cell
    }
}
