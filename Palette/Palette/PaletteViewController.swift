//
//  PaletteViewController.swift
//  Palette
//
//  Created by Владимир Рубис on 25.09.2022.
//

import UIKit

class PaletteViewController: UIViewController {
    
    @IBOutlet weak var paletteView: UIView!
        
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet var sliders: [UISlider]!
    @IBOutlet var textFields: [UITextField]!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupElements()
        setColor()
    }

    /// Отработка действия слайдеров
    @IBAction func changeRgbSlider(_ sender: Any) {
        setColor()
        setTextFields()
    }
    
    /// Настроивает элементы View
    func setupElements() {
        paletteView.layer.cornerRadius = paletteView.bounds.width / 2
    }

    /// Устанавливает цвет в paletteView
    private func setColor() {
        paletteView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    /// Настраивает TF
    private func setTextFields() {
        for index in 0..<sliders.count {
            textFields[index].text = string(from: sliders[index])
        }
    }
    
    /// Приводит значение слайдера к строке
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}


extension PaletteViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            switch textField {
            case textFields[0]:
                redSlider.setValue(currentValue, animated: true)
            case textFields[1]:
                greenSlider.setValue(currentValue, animated: true)
            default:
                blueSlider.setValue(currentValue, animated: true)
            }
            setColor()
            return
        }
    }
}



