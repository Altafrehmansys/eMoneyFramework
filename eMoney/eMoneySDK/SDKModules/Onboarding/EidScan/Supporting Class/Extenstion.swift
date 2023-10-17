//
//  Extenstion.swift
//

import Foundation
import  UIKit

typealias alertOkayAction = ((UIAlertAction)-> Void)
extension UIViewController {
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
    func showNormalAlert(title: String,msg: String,OKAction : alertOkayAction?){
       
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .cancel, handler: OKAction)
            alertView.addAction(action)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    func showAlertSheet(title: String,msg: String,firstButtonTitle:String,secondButtonTitle:String, firstAction : @escaping alertOkayAction,secondAction:@escaping alertOkayAction){
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
            let first = UIAlertAction(title: firstButtonTitle, style: .default, handler: firstAction)
            let second = UIAlertAction(title: secondButtonTitle, style: .destructive, handler: secondAction)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertView.addAction(first)
            alertView.addAction(second)
            alertView.addAction(cancel)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    func showSingleAlert(title: String,msg: String,buttonTitle:String,firstAction : @escaping alertOkayAction){
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
            let first = UIAlertAction(title: buttonTitle, style: .default, handler: firstAction)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertView.addAction(first)
            alertView.addAction(cancel)
            self.present(alertView, animated: true, completion: nil)
        }
    }
}


//internal extension Dictionary {
//    
//    /// Convert Dictionary to JSON string
//    /// - Throws: exception if dictionary cannot be converted to JSON data or when data cannot be converted to UTF8 string
//    /// - Returns: JSON string
//    func toJson() throws -> String {
//        let data = try JSONSerialization.data(withJSONObject: self)
//        if let string = String(data: data, encoding: .utf8) {
//            return string
//        }
//        throw NSError(domain: "Dictionary", code: 1, userInfo: ["message": "Data cannot be converted to .utf8 string"])
//        return "error"
//    }
//}

internal extension UIImage{
    func convertImageToBase64String () -> String {
        let imageData:NSData = self.jpegData(compressionQuality: 0.50)! as NSData //UIImagePNGRepresentation(img)
        let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
        return imgString
    }
    
}

internal extension String{
    func convertBase64StringToImage() -> UIImage? {
        if let imageData = Data.init(base64Encoded: self, options: .init(rawValue: 0)){
            if let image = UIImage(data: imageData){
                return image
            }
        }
        return nil
    }
    func haveValue() -> String?{
        if self.count > 0{
            return self
        }
        return nil
    }
}


//internal extension UIView {
// 
//    @IBInspectable
//    /// Should shadow rasterize of view; also inspectable from Storyboard.
//    /// cache the rendered shadow so that it doesn't need to be redrawn
//     var shadowShouldRasterize: Bool {
//        get {
//            return layer.shouldRasterize
//        }
//        set {
//            layer.shouldRasterize = newValue
//        }
//    }
//    
//    @IBInspectable
//    /// Should shadow rasterize of view; also inspectable from Storyboard.
//    /// cache the rendered shadow so that it doesn't need to be redrawn
//     var shadowRasterizationScale: CGFloat {
//        get {
//            return layer.rasterizationScale
//        }
//        set {
//            layer.rasterizationScale = newValue
//        }
//    }
//    
//    @IBInspectable
//    /// Corner radius of view; also inspectable from Storyboard.
//     var maskToBounds: Bool {
//        get {
//            return layer.masksToBounds
//        }
//        set {
//            layer.masksToBounds = newValue
//        }
//    }
//}

