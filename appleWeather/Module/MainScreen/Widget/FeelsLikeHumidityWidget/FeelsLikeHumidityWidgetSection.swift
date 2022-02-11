//
//  FeelsLikeHumiditySidgetView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit


class FeelsLikeHumidityWidgetSection: SectionConfiguratorProtocol {
    
    let cellIdentifier = "FeelsLikeHumidityWidgetSectionCell"
    var data: WeatherDataService.OneDayResponse?
    
    func getHeaderView() -> UIView? {
        let view = UIView()
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        let firstHeader = HeaderViewWithRoundedCorner()
        stackView.addArrangedSubview(firstHeader)
        let firstLabel = UILabel()
        firstLabel.text = "🌡 FEELS LIKE"
        firstLabel.textColor = .lightGray
        firstHeader.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        let secondHeader = HeaderViewWithRoundedCorner()
        stackView.addArrangedSubview(secondHeader)
        let secondLabel = UILabel()
        secondLabel.text = "🌫 HUMIDITY"
        secondLabel.textColor = .lightGray
        secondHeader.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        return view
    }
    
    func getNumberOfRows() -> Int {
        1
    }
    
    init(tableView: UITableView){
        tableView.register(FeelsLikeHumidityWidgetSectionView.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FeelsLikeHumidityWidgetSectionView
        guard let data = data else {
            return cell
        }

        let feelsLikeDataStringValue = StringGeneratorForViewService.shared.getFeelsLikeStringValue(rowData: data)
        let humidityDataStringValue = StringGeneratorForViewService.shared.getHumidityStringValue(rowData: data)
        cell.setData(dataForFeelsLikeWidget: FeelsLikeWidget.FeelsLikeStringValue(feelsLikeValue: feelsLikeDataStringValue.feelsLikeValue, description: feelsLikeDataStringValue.description), dataForHumidityWidget: HumidityWidget.HumidityStringValue(humidityValue: humidityDataStringValue.humidityValue, description: humidityDataStringValue.description))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}


