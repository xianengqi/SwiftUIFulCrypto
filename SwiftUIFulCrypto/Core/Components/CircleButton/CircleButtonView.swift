//
//  CircleButtonView.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/3/21.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10,
                x: 0,
                y: 0
            )
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "info")
                .previewLayout(.sizeThatFits) // 更改为合适的预览模式
            
//            CircleButtonView(iconName: "plus")
//                .previewLayout(.sizeThatFits) // 更改为合适的预览模式
//                .colorScheme(.dark)
        }
    }
}
