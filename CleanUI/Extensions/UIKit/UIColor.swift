//
//  UIColor.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

public extension UIColor {
    
    
    /// Creates an UIImage from the given color
    /// - Parameters:
    ///   - width: The width of the output UIImage
    ///   - height: The height of the output UIImage
    /// - Returns: An UIImage colored in the given color
    func imageWithColor(width: Int, height: Int) -> UIImage {
        let size = CGSize(width: width, height: height)
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    var rgbComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r,g,b,a)
        }
        return (0,0,0,0)
    }
    
    var hsbComponents:(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha:CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha){
            return (hue,saturation,brightness,alpha)
        }
        return (0,0,0,0)
    }
    
    var htmlRGBColor:String {
        return String(format: "#%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255))
    }
    
    var htmlRGBaColor:String {
        return String(format: "#%02x%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255),Int(rgbComponents.alpha * 255) )
    }
    
    static var accent: UIColor {
        ColorProvider.uiColor("Accent")
    }
    
    static var accent2: UIColor {
        ColorProvider.uiColor("Accent2")
    }
    
    static var accent3: UIColor {
        ColorProvider.uiColor("Accent3")
    }
    
    static var accent4: UIColor {
        ColorProvider.uiColor("Accent4")
    }
    
    static var defaultText: UIColor {
        ColorProvider.uiColor("DefaultText")
    }
    
    static var grayText: UIColor {
        ColorProvider.uiColor("GrayText")
    }
    
    static var link: UIColor {
        ColorProvider.uiColor("Link")
    }
    
    static var defaultRed: UIColor {
        ColorProvider.uiColor("DefaultRed")
    }
    
    static var background: UIColor {
        ColorProvider.uiColor("Background")
    }
    
    static var primaryColor: UIColor {
        ColorProvider.uiColor("Primary")
    }
    
    static var accentStaticDark: UIColor {
        ColorProvider.uiColor("AccentStaticDark")
    }
    
    static var defaultBorder: UIColor {
        ColorProvider.uiColor("DefaultBorder")
    }
}