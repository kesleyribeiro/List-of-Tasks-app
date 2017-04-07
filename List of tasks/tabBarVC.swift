//
//  tabBarVC.swift
//  List of tasks
//
//  Created by Kesley Ribeiro on 30/Mar/17.
//  Copyright © 2017 App ao Cubo. All rights reserved.
//

import UIKit

class tabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Item color of tabBar
        self.tabBar.tintColor = .white
        
        // Background color of tabBar
        self.tabBar.barTintColor = blueColor
        
        // No translucent
        self.tabBar.isTranslucent = false
        
        // Text color of icon in tabBar
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.gray], for: UIControlState())
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .selected)
        
        // New icon color of tabBar
        for item in self.tabBar.items! as [UITabBarItem] {
            if let imagem = item.image {
                item.image = imagem.imageColor(UIColor.gray).withRenderingMode(.alwaysOriginal)
            }
        }
        
        // Call the function of animation
        animationListTasks()
    }    
    
    // Animation List of Tasks
    func animationListTasks() {
        
        // New view
        let viewAnimation = UIView()
        
        viewAnimation.frame = self.view.frame // Define the size equal view size
        viewAnimation.backgroundColor = blueColor // View color
        self.view.addSubview(viewAnimation) // Add viewAnimation to view controller
        
        // List of Tasks icon
        let icon = UIImageView() // Define var of type UIImageView to save the image
        icon.image = UIImage(named: "listTasksIcon.png") // Refer to save the image
        icon.frame.size.width = 160 // Width of image
        icon.frame.size.height = 200 // Height of image
        icon.center = view.center // To center the image with view size
        self.view.addSubview(icon) // Add image to view controller
        
        // To initiate the first animation - zoom in
        UIView.animate(withDuration: 0.7, delay: 0.5, options: .curveLinear, animations: {

            // To make small icon
            icon.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        }) { (finished:Bool) in
            
            // Finished the firts animation
            if finished {

                // Second animation - zoom in
                UIView.animate(withDuration: 1.5, animations: {
                    
                    // To make big icon
                    icon.transform = CGAffineTransform(scaleX: 30, y: 30)
                    
                    // Third animation - hide icon
                    UIView.animate(withDuration: 1, delay: 0.3, options: .curveLinear, animations: {
                        
                        // Hide icon and viewAnimation
                        icon.alpha = 0
                        viewAnimation.alpha = 0
                        
                    }, completion: nil)
                })
            }
        }
    }
    
}

// Nova classe para referenciar o ícone na tabBar controller
extension UIImage {
    
    // Esta classe customiza a imagem do ícone
    func imageColor(_ color: UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        
        color.setFill()
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return image
    }
}
