//
//  SwiftUIFulCryptoApp.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/3/21.
//

import SwiftUI

@main
struct SwiftUIFulCryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
