//
//  Double.swift
//  PublicCoin
//
//  Created by Daichi Morihara on 2022/09/01.
//

import Foundation
import FileProvider

extension Double {
    private var currentFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func asCurrency() -> String {
        let number = NSNumber(value: self)
        return currentFormatter.string(from: number) ?? "$0.00"
    }
    
    private var valueFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func asValue() -> String {
        let number = NSNumber(value: self)
        return valueFormatter.string(from: number) ?? "$0.00"
    }
    
    func asNumber() -> String {
        return String(format: "%.2f", self) + "%"
    }
}
