//
//  MainNavigationController.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 14.01.2022.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    
    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainWindow = MainTableController()
        pushViewController(mainWindow, animated: true)
    }
}
