//
//  SectionConfiguratorProtocol.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 17.01.2022.
//

import Foundation
import UIKit

protocol SectionConfiguratorProtocol {
    func getHeaderView() -> UIView?
    func getNumberOfRows() -> Int
    func tableView( _ tableView:  UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}
