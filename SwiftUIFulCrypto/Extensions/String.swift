//
//  String.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 9/9/21.
//

import Foundation

extension String {
    
    // 可以摆脱HTML代码
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
