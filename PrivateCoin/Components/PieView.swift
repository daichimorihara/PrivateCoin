//
//  PieView.swift
//  PrivateCoin
//
//  Created by Daichi Morihara on 2022/09/08.
//

import SwiftUI

struct PieView: View {
    @ObservedObject var vm: CoinViewModel
    
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                ForEach(vm.slices) { slice in
                    PieChart(pieData: slice)
                }
                
                Circle()
                    .fill(Color.theme.background)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                
                VStack {
                    Text("Total")
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.secondary)
                    Text(vm.totalValue.asValue())
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
    }
}

struct PieView_Previews: PreviewProvider {
    static var previews: some View {
        PieView(vm: CoinViewModel())
    }
}
