//
//  CurrentDataWidgets.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 20.01.2022.
//

import Foundation
import SnapKit
import UIKit



class UVISunriseWidgetSection: SectionConfiguratorProtocol {
    
    let cellIdentifier = "UVISunriseWidgetSectionCell"
    var data: WeatherDataService.OneDayResponse?
    
    func getHeaderView() -> UIView? {
        let view = UIView()
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        view.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        let firstLabel = UILabel()
        firstLabel.text = "☀️ UV-INDEX"
        stackView.addArrangedSubview(firstLabel)
        
        let secondLabel = UILabel()
        secondLabel.text = "🌅 SUNRISE"
        stackView.addArrangedSubview(secondLabel)
        return view
    }
    
    func getNumberOfRows() -> Int {
        1
    }
    
    init(tableView: UITableView){
        tableView.register(UVISunriseWidgetSectionView.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UVISunriseWidgetSectionView
        return cell
    }
}

