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
        print("Calculate")
        resultButtonClicked()
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        print("Random")
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
        
        heightLabel.text = "키가 어떻게 되시나요?"
        heightLabel.font = heightLabel.font.withSize(15)
        heightWarningLabel.text = " "
        heightWarningLabel.textColor = .red
        heightWarningLabel.font = heightWarningLabel.font.withSize(15)
        
        weightLabel.text = "몸무게는 어떻게 되시나요?"
        weightLabel.font = weightLabel.font.withSize(15)
        weightWarningLabel.text = " "
        weightWarningLabel.textColor = .red
        weightWarningLabel.font = weightWarningLabel.font.withSize(15)
        
    }
    
    func setTextFields() {
        heightTextField.textAlignment = .center
        heightTextField.keyboardType = .decimalPad
        heightTextField.layer.cornerRadius = 10
        heightTextField.layer.borderWidth = 1
        heightTextField.font = .systemFont(ofSize: 25)
        
        weightTextField.textAlignment = .center
        weightTextField.keyboardType = .decimalPad
        weightTextField.layer.cornerRadius = 10
        weightTextField.layer.borderWidth = 1
        weightTextField.font = .systemFont(ofSize: 25)
    }
    
    func setButtons() {
        calculateButton.setTitle("결과 확인", for: .normal)
        calculateButton.titleLabel?.font = .boldSystemFont(ofSize: 25)
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.layer.cornerRadius = 10
        calculateButton.backgroundColor = .purple
        
        randomButton.setTitle("랜덤 BMI 확인", for: .normal)
        randomButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        randomButton.setTitleColor(.white, for: .normal)
        randomButton.layer.cornerRadius = 10
        randomButton.backgroundColor = .orange
        
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

