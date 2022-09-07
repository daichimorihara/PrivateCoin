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
    @State private var check = false
    @FocusState var name: Bool
    @FocusState var num: Bool
    
    var body: some View {
        
        ScrollView {
            VStack {
                header
                SearchBarView(searchText: $vm.searchText, name: _name)
                coinCol
                if let selectedCoin = selectedCoin {
                    input(selectedCoin: selectedCoin)
                }
                Spacer()
            }
        }
        .onAppear(perform: {
            name = true
        })
        .onChange(of: vm.searchText) { newValue in
            selectedCoin = nil
            amount = ""
        }
}

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
        Text("Edit")
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
                    
                    HStack {
                        Image(systemName: "checkmark")
                            .opacity(check ? 1 : 0)

                        Button {
                            saveButtonPressed()
                        } label: {
                            Text("Save")
                                .fontWeight(.semibold)
                        }
                        .opacity(selectedCoin != nil &&
                                 selectedCoin?.holding != Double(amount) ? 1.0 : 0.0
                        )
                    }
                }
                    .foregroundColor(.theme.base)
                    .padding(.horizontal)
            )
    }
    
    private func input(selectedCoin: Coin) -> some View {
        VStack {
            HStack {
                Text("Current price of \(selectedCoin.symbol.uppercased())")
                Spacer()
                Text(selectedCoin.currentPrice.asCurrency())
            }
            .padding()
            
            Divider()
            
            HStack {
                Text("Amount holding")
                Spacer()
                TextField("Ex: 1.6", text: $amount)
                    .focused($num)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            .padding()
            
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getValue)
            }
            .padding()
        }
        .font(.headline)
    }
    
    private var coinCol: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(vm.searchText.isEmpty ? vm.portCoins : vm.filteredCoins) { coin in
                    PortCoinCol(coin: coin)
                        .frame(width: 75)
                        .padding(5)
                        .onTapGesture {
                            // coinTaped
                            coinTaped(coin: coin)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ?
                                        Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading, 5)
        }
    }
    
    private func saveButtonPressed() {
        if amount == "" {
            amount = "0"
        }
        guard let coin = selectedCoin,
              let amount = Double(amount) else {
            return
        }
        
        
        vm.updatePort(coin: coin, amount: amount)
        check = true
        vm.searchText = ""
        selectedCoin = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            check = false
        }
        
    }
    
    private func coinTaped(coin: Coin) {
        selectedCoin = coin
        name = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            num = true
        }
        
        if
            let portCoin = vm.portCoins.first(where: {$0.id == coin.id}),
            let aaa = portCoin.holding {
            amount = "\(aaa)"
        } else {
            amount = ""
        }
        
    }
}
