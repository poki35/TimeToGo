//
//  Alert.swift
//  TimeToGo
//
//  Created by Kirill Ponomarenko on 10.06.2022.
//

import UIKit
// MARK: - Extension's
extension UIViewController {
    
    func alertAddAddress(title: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default) { (action) in
            
            print("action")
            
            let tfText = alertController.textFields?.first
            
            guard let text = tfText?.text else { return }
            completionHandler(text)
            
        }
        
        alertController.addTextField { (tf) in tf.placeholder = placeholder
        }
        
        let alertCancel = UIAlertAction(title: "Отменить", style: .destructive) { (_) in
            
        }
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func alertError(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(alertOk)
        
        present(alertController, animated: true, completion: nil)
        
    }
}
