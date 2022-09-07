//
//  CoinImageViewModel.swift
//  PublicCoin
//
//  Created by Daichi Morihara on 2022/09/01.
//

import Foundation
import UIKit

@MainActor
class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?
    
    let service = CoinImageService()
    let manager = ImageFileManager.instance
    let folderName = "coin"
    let imageName: String
    init(coin: Coin) {
        self.imageName = coin.id
        Task {
            await self.fetchCoinImage(urlString: coin.image)
        }
    }
    
    
    func fetchCoinImage(urlString: String) async {
        if let savedImage = manager.getImage(folderName: folderName, imageName: imageName) {
            self.image = savedImage
            print("Fetch")
        } else {
            if let downloaded = await service.downloadCoinImage(urlString: urlString) {
                manager.saveImage(image: downloaded, folderName: folderName, imageName: imageName)
                self.image = downloaded
                print("Download")
            }
        }
    }
}
