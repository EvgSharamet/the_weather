//
//  WindPrecipitationWidgetSection.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import UIKit
import SnapKit


class WindPrecipitationWidgetSection: SectionConfiguratorProtocol {
    let cellIdentifier = "WindHumidityWidgetSectionCell"
    var data: (StringGeneratorForViewService.WindStringValue, StringGeneratorForViewService.PrecipitationStringValue)?
    var precipitationHeaderLabel = UILabel()
    
    func getHeaderView() -> UIView? {
        let view = UIView()
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        let firstHeader = BaseHeaderView()
        stackView.addArrangedSubview(firstHeader)
        let firstLabel = UILabel()
        firstLabel.text = "💨 WIND"
        firstLabel.textColor = .lightGray
        firstHeader.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { maker in
            maker.top.bottom.right.equalToSuperview()
            maker.left.equalToSuperview().inset(10)
        }
   
        let secondHeader = BaseHeaderView()
        stackView.addArrangedSubview(secondHeader)
        precipitationHeaderLabel.textColor = .lightGray
        secondHeader.addSubview(precipitationHeaderLabel)
        precipitationHeaderLabel.snp.makeConstraints { maker in
            maker.top.bottom.right.equalToSuperview()
            maker.left.equalToSuperview().inset(10)
        }

        return view
    }
    
    func getNumberOfRows() -> Int {
        1
    }
    
    init(tableView: UITableView){
        tableView.register(WindPrecipitationWidgetSectionView.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WindPrecipitationWidgetSectionView
 
        guard let data = data else {
            return cell
        }

        let windDataStringValue = data.0
        let precipitationDataStringValue = data.1
        precipitationHeaderLabel.text = precipitationDataStringValue.textForHeader
        
        cell.configure(dataForWindVidget: WindWidget.WindStringValue(windSpeed: windDataStringValue.windSpeed, windMeasure: windDataStringValue.windMeasure, windDeg: windDataStringValue.windDeg), dataForPrecipitationWidget: PrecipitationWidget.PrecipitationStringValue (weatherType: precipitationDataStringValue.weatherType, textForHeader: precipitationDataStringValue.textForHeader, currentValue: precipitationDataStringValue.currentValue, futureValue: precipitationDataStringValue.futureValue))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}


