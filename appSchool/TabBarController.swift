//
//  TabBarController.swift
//  appSchool
//
//  Created by CaioCunha on 13/05/24.
//

import UIKit

class TabBarController: UITabBarController
{
    @IBInspectable var initialIndex: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = initialIndex
    }
}
