//
//  SearchBarView.swift
//  PublicCoin
//
//  Created by Daichi Morihara on 2022/08/31.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @FocusState var name: Bool
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.vertical)
                .onTapGesture {
                    name = true
                }
            
            TextField("Search by name or symbol...", text: $searchText)
                .padding(.vertical)
                .disableAutocorrection(true)
                .focused($name)
                
            
            
        }
        .overlay(
            Image(systemName: "xmark.circle.fill")
                .padding()
                .foregroundColor(.theme.base)
                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                .onTapGesture {
                    searchText = ""
                    name = false
                }
            
            ,alignment: .trailing
        
        )
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.theme.base.opacity(0.05))
        )
        .padding()
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
