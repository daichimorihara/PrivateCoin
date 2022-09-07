//
//  PortView.swift
//  PrivateCoin
//
//  Created by Daichi Morihara on 2022/09/04.
//

import SwiftUI

struct PortView: View {
    @StateObject var vm = CoinViewModel()
    @State private var showEdit = false
    
    var body: some View {
        VStack {
            header
            title
            List {
                ForEach(vm.portCoins) { coin in
                    PortRow(coin: coin, allocation: coin.currentValue / vm.totalValue * 100)
                }
            }
            .listStyle(PlainListStyle())
            
            Spacer()
        }
        .fullScreenCover(isPresented: $showEdit) {
            
        } content: {
            AddPortVIew()
        }

        
    }
    
    
}

struct PortView_Previews: PreviewProvider {
    static var previews: some View {
        PortView()
    }
}

extension PortView {
    private var header: some View {
        Text("My holdings")
            .foregroundColor(.theme.base)
            .font(.headline)
            .fontWeight(.heavy)
            .frame(width: UIScreen.main.bounds.width)
            .overlay(
                Button(action: {
                    showEdit.toggle()
                }, label: {
                    Text("Edit")
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        
                })
                ,alignment: .leading
            )
    }
    
    private var title: some View {
        HStack(spacing: 40) {
            Text("Symbol")
            Spacer()
            Text("Value")
            Text("Percentage")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                
        }
        .padding()
        .font(.caption)
        .foregroundColor(.theme.secondary)
    }
}
