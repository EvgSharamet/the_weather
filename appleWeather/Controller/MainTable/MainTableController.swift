//
//  MainWindowcontroller.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 17.01.2022.
//

import Foundation
import SnapKit
import UIKit

class MainTableController: UITableViewController {
    
    private enum TableViewSections: Int, CaseIterable {
        case hourlyForecast = 0
    }
    
    private var hourlyForecastSection: HourlyForecastSection?
   // private var tenDaysForecastSection: TenDaysForecastSection?
   // private var precepitaionSection: PrecepitationSection?
   // private var widgetsSection: WidgetsSection?
    
    private let identifier = "TableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6
        hourlyForecastSection = HourlyForecastSection(tableView: tableView)
    }
    
    override func numberOfSections( in tableView: UITableView) -> Int {
        return TableViewSections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "\(section) Section Header"
    }
    
    override func tableView(_ tablerView: UITableView, numberOfRowsInSection section : Int) -> Int {
        return TableViewSections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = getSectionConfigurator(section: indexPath.section)
        let cell = currentSection?.tableView(tableView, cellForRowAt: indexPath)
        return cell
        /*  let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ImagePreviewTableViewMultiCell
        
        var data: [ImagePreviewTableViewMultiCell.ImageItemWithIndex?] = CatalogDataService.shared.data.items.enumerated()
            .dropFirst(indexPath.row * MainTableViewController.colNumber)
            .prefix(MainTableViewController.colNumber)
            .map{ .init(imageItem: $0.element, index: $0.offset) }
        
        for _ in 0 ..< MainTableViewController.colNumber { data.append(nil) }
        data = [ImagePreviewTableViewMultiCell.ImageItemWithIndex?] (data.prefix(MainTableViewController.colNumber))
        
        let itemSelectedHandler: ImagePreviewTableViewMultiCell.ItemSelectedHandler = { [weak self] (iwi) -> Void in self?.onItemSelectedDelegate?(iwi.index)}
        
        cell.configure(items: data,itemSelectedHandler: itemSelectedHandler )
        
        return cell */
    }

    
    
    private func getSectionConfigurator(section: Int) -> SectionConfiguratorProtocol? {
        guard let section = TableViewSections(rawValue: section) else { return nil }
        switch section {
        case .hourlyForecast:
            return hourlyForecastSection
        }
    }

}