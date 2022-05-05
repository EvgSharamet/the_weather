//
//  HourlyForecastSection.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 17.01.2022.
//

import Foundation
import UIKit

struct HourlyForecastSectionConfigurator: SectionConfiguratorProtocol {
    //MARK: - data
    
    var data: StringGeneratorForViewService.HourlyStringValue?
    private let cellIdentifier = "HourlyForecastSectionCell"
    
    private struct Const {
        static let imageUrl = "https://openweathermap.org/img/wn/${img-name}@2x.png"
    }
    
    //MARK: - internal functions
    
    func getHeaderView() -> UIView? {
        let view = BaseWidgetView()
        view.setRoundedCorners([.topLeft, .topRight])
        let label = UILabel()
        label.text = " 🕘 HOURLY FORECAST"
        label.textColor = .white.withAlphaComponent(0.7)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
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
            let url = Const.imageUrl.replacingOccurrences(of: "${img-name}", with: val.iconString)
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
        140
    }
}
