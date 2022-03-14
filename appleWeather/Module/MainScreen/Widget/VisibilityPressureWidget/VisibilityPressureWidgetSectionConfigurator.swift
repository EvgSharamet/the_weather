//
//  VisibilityPressureWidgetSectionView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit


class VisibilityPressureWidgetSectionConfigurator: SectionConfiguratorProtocol {
    struct Data {
        let visibility: StringGeneratorForViewService.VisibilityStringValue
        let pressure: StringGeneratorForViewService.PressureStringValue
    }
    
    var data: Data?
    let cellIdentifier = "VisibilityPressureWidgetSectionCell"
    
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
        firstLabel.text = "👁‍🗨 VISIBILITY"
        firstLabel.textColor = .lightGray
        firstHeader.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { maker in
            maker.top.bottom.right.equalToSuperview()
            maker.left.equalToSuperview().inset(10)
        }
       
        let secondHeader = BaseHeaderView()
        stackView.addArrangedSubview(secondHeader)
        let secondLabel = UILabel()
        secondLabel.text = "⏲ PRESSURE"
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
        tableView.register(VisibilityPressureWidgetSectionView.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VisibilityPressureWidgetSectionView
        guard let data = data else {
            return cell
        }
        
        let dataForVisibilityWidget = data.visibility
        let dataForPressureWidget = data.pressure
        cell.configure(dataForVisibilityWidget: VisibilityWidget.VisibilityStringValue(visibilityValue: dataForVisibilityWidget.visibilityValue, description: dataForVisibilityWidget.description),dataForPressureWidget: PressureWidget.PressureStringValue(pressureValue: dataForPressureWidget.pressureValue, degreesForGraph: dataForPressureWidget.degreesForGraph, aboveNorm: dataForPressureWidget.aboveNorm, willRise: dataForPressureWidget.willRise, description: dataForPressureWidget.description))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}


