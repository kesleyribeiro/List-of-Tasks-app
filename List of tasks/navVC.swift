//
//  navVC.swift
//  List of tasks
//
//  Created by Kesley Ribeiro on 30/Mar/17.
//  Copyright © 2017 App ao Cubo. All rights reserved.
//

import UIKit

class navVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Cor do título da Nav. Controller
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        // Cor do background da Nav. Controller / Nav. Bar
        self.navigationBar.barTintColor = blueColor

        // Desabilitar o translúcido
        self.navigationBar.isTranslucent = false
    }
    
    // Status bar em branco
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
