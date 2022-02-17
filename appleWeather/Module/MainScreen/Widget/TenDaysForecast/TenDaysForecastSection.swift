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
    var data: WeatherDataService.TenDaysResponse?
    
    func getHeaderView() -> UIView? {
        let view = HeaderViewWithRoundedCorner()
        
        let label = UILabel()
        label.text = " 📅 TEN DAYS FORECAST"
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
        
        let dataForTenDaysSection = StringGeneratorForViewService.shared.getTenDaysStringValue(rowData: data)
        var list: [OneDayInfoView.OneDayStringValue] = []
        for dayData in dataForTenDaysSection.list {
            list.append( OneDayInfoView.OneDayStringValue(icon: dayData.icon, min: dayData.min, max: dayData.max, leftOffset: dayData.leftOffset, distributionIndicatorWidth: dayData.indicatorRealWidth, dayOfTheWeek: dayData.dayOfTheWeek))
        }
        
        cell.setData(data: TenDaysForecastSectionView.TenDaysStringValue(list: list, todayPoint:  dataForTenDaysSection.todayPoint))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        450
    }
}
