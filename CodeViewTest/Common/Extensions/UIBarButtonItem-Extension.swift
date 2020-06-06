//
//  UIBarButtonItem-Extension.swift
//  CodeViewTest
//
//  Created by 刘军 on 2020/6/4.
//  Copyright © 2020 Lebus. All rights reserved.
//

import UIKit

private let iconNaviConfig = UIImage.SymbolConfiguration(scale: .large)

extension UIBarButtonItem{
    
    convenience init(iconName: String) {
        let btn = UIButton()
        let icon = UIImage(systemName: iconName,withConfiguration: iconNaviConfig)
        let iconNormal = icon?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let iconHigh = icon?.withTintColor(.orange, renderingMode: .alwaysOriginal)
        
        btn.setImage(iconNormal, for: .normal)
        btn.setImage(iconHigh, for: .highlighted)
        btn.frame.size = CGSize(width: 40, height: 40)
        
        self.init(customView: btn)
    }
}
