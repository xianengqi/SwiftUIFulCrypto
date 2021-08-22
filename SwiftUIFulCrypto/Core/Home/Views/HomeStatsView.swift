//
//  HomeStaticView.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/22/21.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @Binding var showProtfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showProtfolio ? .trailing : .leading )
    }
}

struct HomeStaticView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showProtfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
