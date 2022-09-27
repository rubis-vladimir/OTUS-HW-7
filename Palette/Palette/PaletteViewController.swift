//
//  PaletteViewController.swift
//  Palette
//
//  Created by Владимир Рубис on 25.09.2022.
//

import UIKit

class PaletteViewController: UIViewController {
    
    // MARK: IB Outlets
    @IBOutlet weak var paletteView: UIView!
        
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet var sliders: [UISlider]!
    @IBOutlet var textFields: [UITextField]!
    
    // MARK: Public Properties
    var delegate: ColorViewControllerDelegate!
    var viewColor: UIColor!
    
    //MARK: Override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
        setColor()
        setSliders()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        paletteView.layer.cornerRadius = paletteView.bounds.width / 2
    }
    
    //MARK: IBAction
    /// Отработка действия слайдеров
    @IBAction func changeRgbSlider(_ sender: Any) {
        setColor()
        setTextFields()
    }
    
    /// Устанавливает цвет на первом экране и скрывает этот
    @IBAction func doneButtonTapped() {
        delegate?.setColor(paletteView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    //MARK: Private func
    /// Настроивает элементы View
    private func setupElements() {
        paletteView.backgroundColor = viewColor
        paletteView.layer.borderWidth = 2
        paletteView.layer.borderColor = UIColor.black.cgColor
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
    
    /// Настраивает значения слайдеров
    private func setSliders() {
        let ciColor = CIColor(color: viewColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    /// Приводит значение слайдера к строке
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

//MARK: - UITextFieldDelegate
extension PaletteViewController: UITextFieldDelegate {
    
    /// Для скрытия клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    /// Для изменения значения слайдеров после ввода значения
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
        showAlert(title: "Wrong format!",
                  message: "Please enter correct value")
    }
}



