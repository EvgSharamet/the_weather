//
//  TenDaysForecast.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 20.01.2022.
//

import Foundation
import UIKit
import SnapKit

class TenDaysForecastSectionConfigurator: SectionConfiguratorProtocol {
    //MARK: - data
    
    var data: StringGeneratorForViewService.TenDaysStringValue?
    private let cellIdentifier = "TenDaysForecastSectionCell"
    private struct Const {
        static let imageUrl = "https://openweathermap.org/img/wn/${img-name}@2x.png"
    }
    //MARK: - internal functions 
    func getHeaderView() -> UIView? {
        let view = BaseWidgetView()
        view.setRoundedCorners([.topLeft, .topRight])
        let label = UILabel()
        label.text = " 📅 TEN DAYS FORECAST"
        label.textColor = .white.withAlphaComponent(0.7)
        label.font = UIConst.regular16Font
        view.addSubview(label)
        label.snp.makeConstraints { maker in
            maker.top.bottom.right.equalToSuperview()
            maker.left.equalToSuperview().inset(10)
        }
        return view
    }
    
    func getNumberOfRows() -> Int {
        1
    }
    
    init(tableView: UITableView){
        tableView.register(TenDaysForecastSectionView.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TenDaysForecastSectionView
        guard let data = data else {
            return cell
        }
        var list: [OneDayInfoView.OneDayStringValue] = []
        for dayData in data.list {
            list.append( OneDayInfoView.OneDayStringValue(iconString: dayData.icon, minString: dayData.minString, maxString: dayData.maxString, globalMin: dayData.globalMin, globalMax: dayData.globalMax, localMin: dayData.localMin, localMax: dayData.localMax, pointCoord: dayData.pointCoord, dayOfTheWeek: dayData.dayOfTheWeek, clouds: dayData.clouds, showClouds: dayData.showClouds, showCurrentPointView: dayData.showCurrentPointView))
        }
        cell.configure(data: TenDaysForecastSectionView.TenDaysStringValue(list: list))
        
        let group = DispatchGroup()
        list.forEach{ _ in group.enter() }
        list.enumerated().forEach { item in
            var val = item.element
            let url = Const.imageUrl.replacingOccurrences(of: "${img-name}", with: val.iconString)
            ImageLoaderService.shared.resolveImage(urlString: url) { img in
                    val.icon = img
                list[item.offset] = val
                group.leave()
            }
        }
        group.notify(queue: .main) {
            cell.configure(data: TenDaysForecastSectionView.TenDaysStringValue(list: list))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        500
    }
}
