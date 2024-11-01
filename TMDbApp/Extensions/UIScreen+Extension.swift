//
//  UIScreen+Extension.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 01/11/24.
//

import UIKit

extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
