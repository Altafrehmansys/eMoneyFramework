//
//  UIImageExtension.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 21/03/2023.
//

import Foundation
import UIKit
import Kingfisher


extension UIImage {
    private func flippedImage() -> UIImage?{
        if let _cgImag = self.cgImage {
            let flippedimg = UIImage(cgImage: _cgImag, scale:self.scale , orientation: UIImage.Orientation.upMirrored)
            return flippedimg
        }
        return nil
    }
    
    ///  Flip image If language is RTL
    public func flipIfNeeded() -> UIImage? {
        if LocaleManager.isRTLLanguage() {
            return self.flippedImage()
        }
        return self
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.main.async {
            self.kf.setImage(with: url)
        }
    }
}
