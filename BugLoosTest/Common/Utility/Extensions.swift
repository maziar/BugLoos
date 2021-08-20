//
//  Extensions.swift
//  Edgecom
//
//  Created by Pelk on 11/6/1399 AP.
//

import Foundation
import UIKit

let screenBounds = UIScreen.main.bounds
let screenSize   = screenBounds.size
let screenWidth  = screenSize.width
let screenHeight = screenSize.height
let navigationHeight: CGFloat = 44.0
let statubarHeight: CGFloat = 20.0
let navigationHeaderAndStatusbarHeight: CGFloat = navigationHeight + statubarHeight

extension NSObject {
    @objc static
    var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UITableViewCell {
    @objc
    static func reuseIdentifier() -> String {
        return self.nameOfClass
    }
}

extension UICollectionViewCell {
    @objc
    static func reuseIdentifier() -> String {
        return self.nameOfClass
    }
}

extension Array {
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

extension UIImage {
    
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
 
    func imageResize(sizeChange: CGSize) -> UIImage?{

        let hasAlpha = true
        let scale: CGFloat = 0.0

        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)

        self.draw(in:(CGRect(origin: CGPoint.zero, size: sizeChange)))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return scaledImage
    }
}

extension VLCMediaPlayer {
    func toggle() {
        if self.isPlaying {
            self.pause()
        } else {
            self.play()
        }
    }
    
    func toggleButton() -> String {
        return self.isPlaying ? "play.fill" : "pause.fill"
    }
    
    func toggleCircleButton() -> String {
        return self.isPlaying ? "play.circle.fill" : "pause.circle"
    }
    
    func checkButton() -> String {
        return self.isPlaying ? "pause.fill" : "play.fill"
    }
}
