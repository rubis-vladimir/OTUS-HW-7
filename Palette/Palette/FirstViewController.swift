//
//  FirstViewController.swift
//  Palette
//
//  Created by Владимир Рубис on 27.09.2022.
//

import UIKit

/// Протокол управления цветом
protocol ColorViewControllerDelegate {
    /// Настроить цвет экрана
    ///  - Parameter color: цвет
    func setColor(_ color: UIColor)
}

class FirstViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let paletteVC = segue.destination as! PaletteViewController
        paletteVC.delegate = self
        paletteVC.viewColor = view.backgroundColor
    }
    
}

// MARK: - ColorViewControllerDelegate
extension FirstViewController: ColorViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
