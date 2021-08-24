//
//  XMarkButton.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/24/21.
//

import SwiftUI

struct XMarkButton: View {
    // 关闭按钮的方法
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
// 关闭按钮的方法
        presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.headline)
            })
            }
        }

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
