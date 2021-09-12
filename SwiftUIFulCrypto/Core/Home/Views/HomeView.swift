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
    @State private var showSettingView: Bool = false // new sheet
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    
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
            .sheet(isPresented: $showSettingView) {
                SettingsView()
            }
        }
        .background(
            NavigationLink(
                destination: DetailLoadingView(coin: $selectedCoin),
                isActive: $showDetailView,
                label: {
            EmptyView()
        })
        )
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
                    } else {
                        showSettingView.toggle()
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
                .onTapGesture {
                    segue(coin: coin)
                }
//                NavigationLink(
//                    destination: DetailView(coin: coin),
//                    label: {
//                        CoinRowView(coin: coin, showHoldingsColumn: false)
//                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
//                    })
                }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
//        showDetailView = true
        showDetailView.toggle()
        
        
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity( (vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0 )
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                    withAnimation(.default) {
                        // 这是简写
                        vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                        // 这是常规写法
        //                if vm.sortOption == .rank {
        //                    vm.sortOption = .rankReversed
        //                } else {
        //                    vm.sortOption = .rank
        //                }
                    }
                
            }
            
            Spacer()
            if showportfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity( (vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0 )
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                        withAnimation(.default) {
                            // 这是简写
                            vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                        }
                }
                
            }
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity( (vm.sortOption == .price || vm.sortOption == .pricereversed) ? 1.0 : 0 )
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                    withAnimation(.default) {
                        // 这是简写
                        vm.sortOption = vm.sortOption == .price ? .pricereversed : .price
                    }
            }
            
            
           
            Button(action: {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            }, label: {
                Image(systemName: "goforward")
            })
                .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
