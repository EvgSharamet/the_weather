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
        let view = BaseHeaderView()
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
            list.append(OneHourInfoView.OneHourStringValue(date: hourData.dateString, iconString: hourData.iconString,icon: hourData.icon, clouds: hourData.clouds, showClouds: hourData.showClouds, temp: hourData.temp, sunsetSunriseView: hourData.sunriseSunset))
        }
        
        cell.configure(data: HourlyForecastSectionView.HourlyForecastStringValue(list: list))
        
        let group = DispatchGroup()
        list.forEach{ _ in group.enter() }
        list.enumerated().forEach { item in
            var val = item.element
            let url = "https://openweathermap.org/img/wn/\(val.iconString)@2x.png"
            if let _ = val.icon {
                list[item.offset] = val
                group.leave()
            }
            else {
                ImageLoaderService.shared.resolveImage(urlString: url) { img in
                    val.icon = img
                    list[item.offset] = val
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            cell.configure(data: HourlyForecastSectionView.HourlyForecastStringValue(list: list))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}
