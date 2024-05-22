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
    
    @IBOutlet var nicknameField: UITextField!
    
    @IBOutlet var bmiImage: UIImageView!
    
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var heightWarningLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weightWarningLabel: UILabel!
    
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var calculateButton: UIButton!
    
    @IBOutlet var randomButton: UIButton!
    
    @IBOutlet var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        setNicknameField()
        setTextFields()
        setButtons()
        bmiImage.image = .bmi
        bmiImage.contentMode = .scaleAspectFill
        
        fetchHeightAndWeight()
        
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    @IBAction func randomTapped(_ sender: UIButton) {
        randomButtonClicked()
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        resultButtonClicked()
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setNicknameField() {
        nicknameField.placeholder = "닉네임을 입력하세요"
        nicknameField.backgroundColor = .systemGray6
        nicknameField.layer.cornerRadius = 5
        nicknameField.layer.borderWidth = 1
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
        setTextField(heightTextField, placeholder: "cm")
        setTextField(weightTextField, placeholder: "kg")
    }
    
    func setButtons() {
        setButton(calculateButton, title: "결과 확인", size: 25, color: .purple)
        
        randomButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomButton.setTitleColor(.red, for: .normal)
        randomButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        randomButton.titleLabel?.textAlignment = .right
        
        resetButton.setTitle("Reset", for: .normal)
    }
    
    func setLabel(label1: UILabel, label2: UILabel, text: String) {
        label1.text = text
        label1.font = weightLabel.font.withSize(15)
        
        label2.text = " "
        label2.textColor = .red
        label2.font = weightWarningLabel.font.withSize(13)
    }
    
    func setTextField(_ textField: UITextField, placeholder: String) {
        textField.textAlignment = .center
        textField.placeholder = placeholder
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
        let nickname = nicknameField.text ?? "UNKNOWN"
        
        if checkValues(height: height, weight: weight) {
            
            let bmi = calculateBMI(height: Double(height)!, weight: Double(weight)!)
            let bmiRange = bmiRange(bmi: bmi)
            let alert = UIAlertController(title: "BMI 결과",
                                          message: "키: \(height)cm\n몸무게:\(weight)kg\nBMI 수치: \(bmi)\n\(bmiRange)",
                                          preferredStyle: .alert)
            
            let confirm = UIAlertAction(title: "확인", style: .default)
            alert.addAction(confirm)
            present(alert, animated: true)
            
            saveValues(nickname: nickname, height: height, weight: weight)
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
    
    func checkValues(height: String, weight: String) -> Bool {
        var valid = true
        if Double(height) == nil {
            heightWarningLabel.text = "정확한 숫자를 입력하세요"
            valid = false
        } else {
            heightWarningLabel.text = " "
        }
        
        if Double(weight) == nil {
            weightWarningLabel.text = "정확한 숫자를 입력하세요"
            valid = false
        } else {
            weightWarningLabel.text = " "
        }
        
        if let height = Double(height) {
            if height < 100 || height > 230 {
                heightWarningLabel.text = "키를 확인하세요"
                valid = false
            } else {
                heightWarningLabel.text = " "
            }
        }
        
        if let weight = Double(weight) {
            if weight < 30 || weight > 200 {
                weightWarningLabel.text = "몸무게를 확인하세요"
                valid = false
            } else {
                weightWarningLabel.text = " "
            }
        }
        
        return valid
    }
    
    func saveValues(nickname: String, height: String, weight: String) {
        UserDefaults.standard.set(nickname, forKey: "nickname")
        UserDefaults.standard.set(height, forKey: "height")
        UserDefaults.standard.set(weight, forKey: "weight")
    }
    
    func fetchHeightAndWeight() {
        let nickname = UserDefaults.standard.string(forKey: "nickname")
        let height = UserDefaults.standard.string(forKey: "height")
        let weight = UserDefaults.standard.string(forKey: "weight")
        nicknameField.text = nickname
        heightTextField.text = height
        weightTextField.text = weight
    }
    
    @objc func resetButtonTapped() {
        UserDefaults.standard.set("", forKey: "nickname")
        UserDefaults.standard.set("", forKey: "height")
        UserDefaults.standard.set("", forKey: "weight")
        
        nicknameField.text = ""
        heightTextField.text = ""
        weightTextField.text = ""
    }
}

