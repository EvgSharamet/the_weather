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
    var data: WeatherDataService.OneDayResponse? 
    
    func getHeaderView() -> UIView? {
        let view = HeaderViewWithRoundedCorner()
        let label = UILabel()
        label.text = " 🕘 HOURLY FORECAST"
        view.addSubview(label)
        label.snp.makeConstraints { maker in
            maker.top.bottom.right.equalToSuperview()
            maker.left.equalToSuperview().inset(10)
        }
        return view
    }
    
    init(tableView: UITableView){
        tableView.register(HourlyForecastSectionView.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func getNumberOfRows() -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HourlyForecastSectionView

        guard let data = self.data else { return cell }
        cell.configure(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}
