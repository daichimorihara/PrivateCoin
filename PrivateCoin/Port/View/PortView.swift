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
        
//        VStack {
//            header
//            PieView(vm: vm)
//                .frame(width: UIScreen.main.bounds.width * 0.8,
//                       height: UIScreen.main.bounds.width * 0.8)
//            title
//            List {
//                ForEach(vm.portCoins) { coin in
//                    PortRow(coin: coin, allocation: coin.currentValue / vm.totalValue * 100)
//                }
//            }
//            .listStyle(PlainListStyle())
//
//            Spacer()
//
//        }
        VStack {
            header
            ScrollView {
                PieView(vm: vm)
                    .frame(width: UIScreen.main.bounds.width * 0.8,
                           height: UIScreen.main.bounds.width * 0.8)
                title
                
                ForEach(vm.portCoins) { coin in
                    PortRow(coin: coin, allocation: coin.currentValue / vm.totalValue * 100)
                        .padding(5)
                    Divider()
                }
                
            }
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
            .padding(.vertical)
            .overlay(
                HStack {
                    Button {
                        showEdit.toggle()
                    } label: {
                        Text("Edit")
                    }
                    .padding(.horizontal)
                    Spacer()
                    Button {
                        showEdit.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding(.horizontal)
                }
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
