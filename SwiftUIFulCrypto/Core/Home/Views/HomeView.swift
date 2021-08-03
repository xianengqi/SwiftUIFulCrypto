//
//  HomeView.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/3/21.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showportfolio: Bool = false
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                homeHeader
                
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true) // `navigationBarHidden` 隐藏默认导航栏
        }
    }
}

// HomeView对应主视图的HomeView
extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showportfolio ? "plus" : "info")
                .animation(.none)
                .background(
                    CircleButtonAnimationView(animate: $showportfolio)
                )
            Spacer()
            Text(showportfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showportfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showportfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)

    }
}
