//
//  SettingsView.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 9/13/21.
//

import SwiftUI

struct SettingsView: View {
    // 因为这里的 url是固定不变的，所以我用！解开，显示解包，在实际开发中不建议这样使用。
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    let coffeeURL = URL(string: "https://www.google.com")
    let coingeckoURL = URL(string: "https://www.google.com")
    let personalURL = URL(string: "https://www.google.com")
    
    var body: some View {
        NavigationView {
            List {
                swiftfulThinkingSection
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            // 添加左上角的后退按钮
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


extension SettingsView {
    private var swiftfulThinkingSection: some View {
        Section(header: Text("Swiftful Thinking")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following a @SwiftfulThinking course on Youtube.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Subsecribe on Youtube", destination: youtubeURL)
        }
    }
    
    
}
