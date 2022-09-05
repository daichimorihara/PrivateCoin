//
//  Color.swift
//  PublicCoin
//
//  Created by Daichi Morihara on 2022/08/30.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    
}

struct ColorTheme {
    let base = Color("BaseColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondary = Color("SecondaryColor")
}
