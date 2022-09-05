//
//  AddPortVIew.swift
//  PrivateCoin
//
//  Created by Daichi Morihara on 2022/09/05.
//

import SwiftUI

struct AddPortVIew: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = CoinViewModel()
    @State private var selectedCoin: Coin?
    @State private var show = false
    @State private var amount: String = ""
    
    var body: some View {
        
        VStack {
            NavigationLink(isActive: $show) {
                
            } label: {
                EmptyView()
            }

            header
            
            SearchBarView(searchText: $vm.searchText)
            
            ZStack {
                if show {
                    if let selectedCoin = selectedCoin {
                        VStack {
                            CoinRow(coin: selectedCoin)

                            HStack {
                                Text("Current price of \(selectedCoin.symbol.uppercased())")
                                Spacer()
                                Text(selectedCoin.currentPrice.asCurrency())
                            }
                            Divider()
                            HStack {
                                Text("Amount holding")
                                Spacer()
                                TextField("Ex: 1.6", text: $amount)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                                    

                            }
                            Divider()
                            HStack {
                                Text("Current value:")
                                Spacer()
                                Text(getValue)
                            }
                        }
                    }
                } else {
                    List {
                        ForEach(vm.portAddCoins) { coin in
                            CoinRow(coin: coin)
                                .listRowInsets(.init(top: 10, leading: 5, bottom: 10, trailing: 5))
                                .onTapGesture {
                                    selectedCoin = coin
                                    show = true
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                }

            }


            Spacer()
        }
        

    }
    
//    func getcurrentValue() -> String {
//        if let selectedCoin = selectedCoin {
//            let price = selectedCoin.currentPrice
//            let amount = Double(amount) ?? 0.0
//            let value = price * amount
//            return value.asCurrency()
//        } else {
//            return "$0.00"
//        }
//    }
    var getValue: String {
        if let selectedCoin = selectedCoin {
            let price = selectedCoin.currentPrice
            let amount = Double(amount) ?? 0.0
            let value = price * amount
            return value.asCurrency()
        } else {
            return "$0.00"
        }
    }
}

struct AddPortVIew_Previews: PreviewProvider {
    static var previews: some View {
        AddPortVIew()
    }
}

extension AddPortVIew {
    private var header: some View {
        Text("Add")
            .font(.headline)
            .fontWeight(.heavy)
            .frame(width: UIScreen.main.bounds.width)
            .overlay(
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 0) {
                            Image(systemName: "chevron.left")
                            Text("My Portfolio")
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Save")
                            .fontWeight(.semibold)
                    }

                }
                    .foregroundColor(.theme.base)
                    .padding(.horizontal)
            )
    }
}
