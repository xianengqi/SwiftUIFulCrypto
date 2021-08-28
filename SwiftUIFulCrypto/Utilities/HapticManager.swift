//
//  HapticManager.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/28/21.
//

import Foundation
import SwiftUI

// 震动 触发类
class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
