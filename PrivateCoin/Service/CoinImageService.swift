//
//  CoinImageService.swift
//  PublicCoin
//
//  Created by Daichi Morihara on 2022/09/01.
//

import Foundation
import UIKit

class CoinImageService {
    
    func downloadCoinImage(urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            // add image to file system
            return image
        } catch  {
            return nil
        }
    }
}
