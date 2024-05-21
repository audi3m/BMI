//
//  ViewController.swift
//  BMI
//
//  Created by J Oh on 5/21/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var heightWarningLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weightWarningLabel: UILabel!
    
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var randomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabels()
        setTextFields()
        setButtons()
        
    }

    @IBAction func resultButtonTapped(_ sender: UIButton) {
        resultButtonClicked()
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        randomButtonClicked()
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setLabels() {
        titleLabel.text = "BMI Calculator"
        titleLabel.font = titleLabel.font.withSize(30)
        
        detailLabel.numberOfLines = 0
        detailLabel.text = "당신의 BMI 지수를\n알려드릴게요."
        
        setLabel(label1: heightLabel, label2: heightWarningLabel, text: "키가 어떻게 되시나요?")
        setLabel(label1: weightLabel, label2: weightWarningLabel, text: "몸무게는 어떻게 되시나요?")
    }
    
    func setTextFields() {
        setTextField(heightTextField)
        setTextField(weightTextField)
    }
    
    func setButtons() {
        setButton(calculateButton, title: "결과 확인", size: 25, color: .purple)
        setButton(randomButton, title: "랜덤 BMI 확인", size: 20, color: .orange)
    }
    
    func setLabel(label1: UILabel, label2: UILabel, text: String) {
        label1.text = text
        label1.font = weightLabel.font.withSize(15)
        
        label2.text = " "
        label2.textColor = .red
        label2.font = weightWarningLabel.font.withSize(15)
    }
    
    func setTextField(_ textField: UITextField) {
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.font = .systemFont(ofSize: 25)
    }
    
    func setButton(_ button: UIButton, title: String, size: CGFloat, color: UIColor) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: size)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = color
    }
    
    func calculateBMI(height: Double, weight: Double) -> Double {
        let result = weight / (height/100 * height/100)
        return round(result*100)/100
    }
    
    func bmiRange(bmi: Double) -> String {
        switch bmi {
        case ..<18.5:
            return "저체중"
        case 18.5..<23:
            return "정상"
        case 23..<25:
            return "과체중"
        case 25...:
            return "비만"
        default:
            return "오류"
        }
    }
    
    func resultButtonClicked() {
        let height = heightTextField.text ?? "180"
        let weight = weightTextField.text ?? "80"
        
        var heightOK = true
        var weightOK = true
        
        if let height = Double(height), let weight = Double(weight) {
            heightWarningLabel.text = " "
            weightWarningLabel.text = " "
            
            if height < 100 || height > 230 {
                heightWarningLabel.text = "키가 너무 작거나 큽니다"
                heightOK = false
            }
            
            if weight < 30 || weight > 200 {
                weightWarningLabel.text = "몸무게가 너무 작거나 큽니다"
                weightOK = false
            }
            
            let bmi = calculateBMI(height: height, weight: weight)
            let bmiRange = bmiRange(bmi: bmi)
            let alert = UIAlertController(title: "BMI 결과",
                                          message: "키: \(height)cm\n몸무게:\(weight)kg\nBMI 수치: \(bmi)\n\(bmiRange)",
                                          preferredStyle: .alert)
            
            let confirm = UIAlertAction(title: "확인", style: .default)
            alert.addAction(confirm)
            
            if heightOK && weightOK {
                present(alert, animated: true)
            }
            
        } else {
            if Double(height) == nil {
                heightWarningLabel.text = "정확한 숫자를 입력하세요"
            }
            
            if Double(weight) == nil {
                weightWarningLabel.text = "정확한 숫자를 입력하세요"
            }
        }
    }
    
    func randomButtonClicked() {
        let height = round(Double.random(in: 100...230)*100)/100
        let weight = round(Double.random(in: 30...200)*100)/100
        
        let bmi = calculateBMI(height: height, weight: weight)
        let bmiRange = bmiRange(bmi: bmi)
        let alert = UIAlertController(title: "BMI 결과", 
                                      message: "키: \(height)cm\n몸무게: \(weight)kg\nBMI 수치: \(bmi)\n\(bmiRange) 입니다.",
                                      preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(confirm)
        
        present(alert, animated: true)
        
    }
    
}

