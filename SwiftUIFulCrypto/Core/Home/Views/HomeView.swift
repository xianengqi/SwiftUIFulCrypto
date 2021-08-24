//
//  HomeView.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/3/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showportfolio: Bool = false // animate right
    @State private var showportfolioView: Bool = false // new sheet
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showportfolioView , content: {
                    PortfolioView()
                        .environmentObject(vm)
                })

            
            // content layer
            VStack {
                homeHeader
                HomeStatsView(showProtfolio: $showportfolio)
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if !showportfolio {
                    allCoinsList
                    .transition(.move(edge: .leading))
                }
                if showportfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
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
        .environmentObject(dev.homeVM)
    }
}

// HomeView对应主视图的HomeView
extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showportfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showportfolio {
                        showportfolioView.toggle()
                    }
                }
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
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showportfolio {
                Text("Holdings")
            }
            
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
