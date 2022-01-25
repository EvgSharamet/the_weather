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
        let view = UIView()
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        view.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        let label = UILabel()
        label.text = "📅 TEN DAYS FORECAST"
        view.addSubview(label)
        label.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
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
        guard let data = self.data else {
            return cell }
        
        cell.setData(data: data)
        return cell
    }
}
