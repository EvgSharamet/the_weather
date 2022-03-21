//
//  FeelsLikeHumiditySidgetView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit

class FeelsLikeHumidityWidgetSectionConfigurator: SectionConfiguratorProtocol {
    struct Data {
        let feelsLike: StringGeneratorForViewService.FeelsLikeStringValue
        let humidity: StringGeneratorForViewService.HumidityStringValue
    }

    private let cellIdentifier = "FeelsLikeHumidityWidgetSectionCell"
    var data: Data?
    
    func getHeaderView() -> UIView? {
        let view = UIView()
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        let firstHeader = BaseWidgetView()
        firstHeader.setRoundedCorners([.topLeft, .topRight])
        stackView.addArrangedSubview(firstHeader)
        let firstLabel = UILabel()
        firstLabel.text = "🌡 FEELS LIKE"
        firstLabel.textColor = .white.withAlphaComponent(0.7)
        firstLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        firstHeader.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { maker in
            maker.top.bottom.right.equalToSuperview()
            maker.left.equalToSuperview().inset(10)
        }

        let secondHeader = BaseWidgetView()
        secondHeader.setRoundedCorners([.topLeft, .topRight])
        stackView.addArrangedSubview(secondHeader)
        let secondLabel = UILabel()
        secondLabel.text = "🌫 HUMIDITY"
        secondLabel.textColor = .white.withAlphaComponent(0.7)
        secondLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        secondHeader.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { maker in
            maker.top.bottom.right.equalToSuperview()
            maker.left.equalToSuperview().inset(10)
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

        let feelsLikeDataStringValue = data.feelsLike
        let humidityDataStringValue = data.humidity
        cell.configure(dataForFeelsLikeWidget: FeelsLikeWidget.FeelsLikeStringValue(feelsLikeValue: feelsLikeDataStringValue.feelsLikeValue, description: feelsLikeDataStringValue.description), dataForHumidityWidget: HumidityWidget.HumidityStringValue(humidityValue: humidityDataStringValue.humidityValue, description: humidityDataStringValue.description))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}


