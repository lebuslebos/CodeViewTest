//
//  UIColor-Extension.swift
//  CodeViewTest
//
//  Created by 刘军 on 2020/6/4.
//  Copyright © 2020 Lebus. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat){
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
}
