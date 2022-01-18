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
    
    
    public func getHeaderView() -> String {
      /*  let header = UILabel()
        header.snp.makeConstraints { maker in
            maker.height.equalTo(20)
            maker.width.equalTo(300)
        }
        header.backgroundColor = .blue.withAlphaComponent(0.4)
        header.text = "HOURLY FORECAST"
        */
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
        return cell
    }
}
