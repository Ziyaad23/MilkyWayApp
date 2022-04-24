//
//  LoadImageFromUrl.swift
//  MilkyWay
//
//  Created by user220267 on 4/23/22.
//

import Foundation
import UIKit

//Extension to load image from URL
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
