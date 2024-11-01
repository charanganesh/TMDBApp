//
//  SwiftUI+Extensions.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 01/11/24.
//

import Foundation
import SwiftUI
import Combine

extension View {
    /// A backwards compatible wrapper for iOS 14 `onChange`
    @ViewBuilder func onValueChanged<T: Equatable>(of value: T, perform onChange: @escaping (T, T?) -> Void) -> some View {
        if #available(iOS 14.0, *) {
            self.onChange(of: value) { oldValue, newValue in
                onChange(oldValue, newValue)
            }
        } else {
            self.onReceive(Just(value)) { (value) in
                onChange(value, nil)
            }
        }
    }
}
