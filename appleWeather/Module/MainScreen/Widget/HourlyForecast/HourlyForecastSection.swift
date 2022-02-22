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
    var data: StringGeneratorForViewService.HourlyStringValue?
    
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

        var list:[OneHourInfoView.OneHourStringValue] = []
        guard let data = data else {
            return cell
        }
        
        for hourData in data.list {
            list.append(OneHourInfoView.OneHourStringValue(date: hourData.dateString, icon: hourData.icon, clouds: hourData.clouds, showClouds: hourData.showClouds, temp: hourData.temp))
        }

        cell.configure(data: HourlyForecastSectionView.HourlyForecastStringValue(list: list))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}
