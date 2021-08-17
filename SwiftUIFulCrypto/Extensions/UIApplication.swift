//
//  UIApplication.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/17/21.
//

import Foundation
import SwiftUI

extension UIApplication {
    // 结束编辑键盘的函数
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
