//
//  PortView.swift
//  PrivateCoin
//
//  Created by Daichi Morihara on 2022/09/04.
//

import SwiftUI

struct PortView: View {
    @StateObject var vm = CoinViewModel()
    
    var body: some View {
        VStack {
            Text("My holdings")
                .foregroundColor(.theme.base)
                .font(.headline)
                .fontWeight(.heavy)
                .frame(width: UIScreen.main.bounds.width)
                .overlay(
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus")
                            .padding(.trailing)
                            
                    })
                    ,alignment: .trailing
                )
            
            HStack {
                Text("Symbol")
                Spacer()
                Text("Value")
                Spacer()
                Text("Percentage")
                    
            }
            .padding()
            .font(.caption)
            .foregroundColor(.theme.secondary)
            
            List {
                ForEach(vm.portCoins) { coin in
                    Text(coin.name)
                }
            }
            .listStyle(PlainListStyle())
            
            Spacer()
        }
        
    }
}

struct PortView_Previews: PreviewProvider {
    static var previews: some View {
        PortView()
    }
}
