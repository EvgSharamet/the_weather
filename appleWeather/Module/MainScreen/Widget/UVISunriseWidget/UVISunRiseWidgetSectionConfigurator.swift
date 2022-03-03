//
//  CurrentDataWidgets.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 20.01.2022.
//

import Foundation
import SnapKit
import UIKit


class UVISunriseWidgetSectionConfigurator: SectionConfiguratorProtocol {
    struct Data {
        let uvindex: StringGeneratorForViewService.UVIndexStringValue
        let sunrise: StringGeneratorForViewService.SunriseStringValue
    }
    
    let cellIdentifier = "UVISunriseWidgetSectionCell"
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
        
        let firstHeader = BaseHeaderView()
        stackView.addArrangedSubview(firstHeader)
        let firstLabel = UILabel()
        firstLabel.text = "🌤 UV-INDEX"
        firstLabel.textColor = .lightGray
        firstHeader.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { maker in
            maker.top.bottom.right.equalToSuperview()
            maker.left.equalToSuperview().inset(10)
        }

        
        let secondHeader = BaseHeaderView()
        stackView.addArrangedSubview(secondHeader)
        let secondLabel = UILabel()
        secondLabel.text = " 🌅 SUNRISE/SUNSET"
        secondLabel.textColor = .lightGray
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
        tableView.register(UVISunriseWidgetSectionView.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UVISunriseWidgetSectionView
        guard let data = data else {
            return cell
        }
        let uviDataStringValue = data.uvindex
        let sunriseDataStringValue = data.sunrise
        
        cell.configure(dataForUVIVidget:  UVIWidget.UVIndexStringValue(number: uviDataStringValue.number, numberValue: uviDataStringValue.numberValue , textValue: uviDataStringValue.textValue, description: uviDataStringValue.description),  dataForSunriseVidget: SunriseWidget.SunriseStringValue(sunrise: sunriseDataStringValue.sunrise, sunset: sunriseDataStringValue.sunset, sunriseValue: sunriseDataStringValue.sunriseValue, sunsetValue: sunriseDataStringValue.sunsetValue))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
