//
//  PieChart.swift
//  PrivateCoin
//
//  Created by Daichi Morihara on 2022/09/08.
//

import SwiftUI

struct PieData: Identifiable {
    var id = UUID().uuidString
    var startAngle: Angle
    var endAngle: Angle
    var color: Color
    var percent: Double
    var text: String
}

struct PieChart: View {
    var pieData: PieData
    var midRadians: Double {
        return Double.pi / 2.0 - (pieData.startAngle + pieData.endAngle).radians / 2.0
    }

    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let width = min(geometry.size.width, geometry.size.height)
                    let height = width
                    let center = CGPoint(x: width / 2, y: height / 2)
                    
                    path.move(to: center)
                    
                    path.addArc(center: center,
                                radius: width / 2,
                                startAngle: Angle(degrees: -90) + pieData.startAngle,
                                endAngle: Angle(degrees: -90) + pieData.endAngle,
                                clockwise: false)
                }
                .fill(pieData.color)
                
                VStack {
                    Text(pieData.percent.asNumber())
                    Text(pieData.text)
                    
                }
                .font(.caption)
                .position(
                    x: geometry.size.width * 0.5 * CGFloat(1.0 + 0.78 * cos(self.midRadians)),
                    y: geometry.size.height * 0.5 * CGFloat(1.0 - 0.78 * sin(self.midRadians))
                )
                .foregroundColor(.white)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(pieData: PieData(startAngle: Angle(degrees: 0),
                                  endAngle: Angle(degrees: 160),
                                  color: .green,
                                  percent: 32,
                                  text: "BTC"))
    }
}
