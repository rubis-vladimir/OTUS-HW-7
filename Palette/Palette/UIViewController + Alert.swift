//
//  UIViewController + Alert.swift
//  Palette
//
//  Created by Владимир Рубис on 27.09.2022.
//

import UIKit

extension UIViewController {
    /// Показывает Alert
    ///  - Parameters:
    ///   - title: название
    ///   - message: сообщение
    func showAlert(title: String,
                   message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                               style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
