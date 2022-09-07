//
//  ImageFileManager.swift
//  PublicCoin
//
//  Created by Daichi Morihara on 2022/09/01.
//

import Foundation
import UIKit


class ImageFileManager {
    static let instance = ImageFileManager()
    private init() {}
    
    func saveImage(image: UIImage, folderName: String, imageName: String) {
        createFolderIfNeeded(folderName: folderName)
        
        guard
            let url = getURLForImage(folderName: folderName, imageName: imageName),
            let data = image.pngData() else { return }
        
        do {
            try data.write(to: url)
        } catch  {
            print("Failed to save image to file system \(error)")
        }
    }

    
    func getImage(folderName: String, imageName: String) -> UIImage? {
        guard
            let url = getURLForImage(folderName: folderName, imageName: imageName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch  {
                print("Failed to create directory \(error)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(folderName: String, imageName: String) -> URL? {
        guard let url = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return url.appendingPathComponent(imageName + ".png")
    }
}
