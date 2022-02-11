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
        firstLabel.text = "🌤 UV-INDEX"
        firstLabel.textColor = .lightGray
        firstHeader.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        let secondHeader = HeaderViewWithRoundedCorner()
        stackView.addArrangedSubview(secondHeader)
        let secondLabel = UILabel()
        secondLabel.text = " 🌅 SUNRISE/SUNSET"
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
        tableView.register(UVISunriseWidgetSectionView.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UVISunriseWidgetSectionView
        guard let data = data else {
            return cell
        }
        
        let uviDataStringValue = StringGeneratorForViewService.shared.getUVIndexStringValue(rowData: data)
        let sunriseDataStringValue = StringGeneratorForViewService.shared.getSunriseStringValue(rowData: data)
        
        cell.setData(dataForUVIVidget:  UVIWidget.UVIndexStringValue(number: uviDataStringValue.number, numberValue: uviDataStringValue.numberValue , textValue: uviDataStringValue.textValue, description: uviDataStringValue.description),  dataForSunriseVidget: SunriseWidget.SunriseStringValue(sunrise: sunriseDataStringValue.sunrise, sunset: sunriseDataStringValue.sunset, sunriseValue: sunriseDataStringValue.sunriseValue, sunsetValue: sunriseDataStringValue.sunsetValue))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
