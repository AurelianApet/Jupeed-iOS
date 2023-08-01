//
//  StoreAddViewController.swift
//  Jupeed
//
//  Created by Dal deng yi on 2020/9/25.
//  Copyright © 2020 Dal deng yi. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class StoreAddViewController: UIViewController {

    
    @IBOutlet weak var nextButton: UIButton!
    
    private var textInput: MDCTextField!
    private var controller: MDCTextInputControllerOutlined!
    private let textColor = UIColor(named: "textColor")
    
    private var passwordInput: MDCTextField!
    private var passwordController: MDCTextInputControllerOutlined!
    private let passwordColor = UIColor(named: "textColor")
    
    private var placeholderText = "매장 이름을 확인해주세요."
    private var passwordText = "전화번호 (하이픈 제외 11자이내)"
    
    private var errorEmailText: UILabel!
    private var errorPasswordText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInputView()
        setupController()
        
        errorEmailText = UILabel()
        self.view.addSubview(errorEmailText)
        errorEmailText.textColor = UIColor.red
        errorEmailText.text = "매장 이름 (20자 이내)"
        errorEmailText.font = errorEmailText.font.withSize(15)
        errorEmailText.isHidden = true
        errorEmailText.translatesAutoresizingMaskIntoConstraints = false
        errorEmailText.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 355).isActive = true
        errorEmailText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        errorEmailText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        errorEmailText.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        
        errorPasswordText = UILabel()
        errorPasswordText.textColor = UIColor.red
        errorPasswordText.text = "전화번호를 확인해주세요."
        errorPasswordText.font = errorPasswordText.font.withSize(15)
        self.view.addSubview(errorPasswordText)
        errorPasswordText.isHidden = true
        errorPasswordText.translatesAutoresizingMaskIntoConstraints = false
        errorPasswordText.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 495).isActive = true
        errorPasswordText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        errorPasswordText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        errorPasswordText.heightAnchor.constraint(equalToConstant: 21).isActive = true
        // Do any additional setup after loading the view.
        
        self.view.addSubview(nextButton)
    }
    private func setupInputView() {
        
        if let _ = self.view.viewWithTag(1){return}
        textInput = MDCTextField()
        textInput.tag = 1
        textInput.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textInput)
        textInput.placeholder = placeholderText
        textInput.textColor = textColor
        
        NSLayoutConstraint.activate([
            (textInput.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 290)),
            (textInput.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)),
            (textInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)),
            (textInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)),
            ])
        textInput.addTarget(self, action: #selector(LogInViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        passwordInput = MDCTextField()
        passwordInput.tag = 1
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordInput)
        passwordInput.placeholder = passwordText
        passwordInput.textColor = passwordColor
        NSLayoutConstraint.activate([
            (passwordInput.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 430)),
            (passwordInput.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)),
            (passwordInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)),
            (passwordInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)),
            ])
        passwordInput.addTarget(self, action: #selector(LogInViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if(textField == textInput) {
            let textFieldCharacterCount = textField.text?.count ?? 0
            if(textFieldCharacterCount > 20) {
                print(textFieldCharacterCount)
                controller.textInput?.textColor = UIColor.red
                controller.activeColor = UIColor.red
                controller.normalColor = UIColor.red
                controller.inlinePlaceholderColor = UIColor.red
                controller.floatingPlaceholderActiveColor = UIColor.red
                controller.floatingPlaceholderNormalColor = UIColor.red
                errorEmailText.isHidden = false
            }
            else {
                controller.textInput?.textColor = textColor
                controller.activeColor = textColor
                controller.normalColor = textColor
                controller.inlinePlaceholderColor = textColor
                controller.floatingPlaceholderActiveColor = textColor
                controller.floatingPlaceholderNormalColor = textColor
                errorEmailText.isHidden = true
            }
        }
        if(textField == passwordInput) {
            let textFieldCharacterCount = textField.text?.count ?? 0
            if(textFieldCharacterCount > 11) {
                print(textFieldCharacterCount)
                passwordController.textInput?.textColor = UIColor.red
                passwordController.activeColor = UIColor.red
                passwordController.normalColor = UIColor.red
                passwordController.inlinePlaceholderColor = UIColor.red
                passwordController.floatingPlaceholderActiveColor = UIColor.red
                passwordController.floatingPlaceholderNormalColor = UIColor.red
                errorPasswordText.isHidden = false
            }
            else {
                passwordController.textInput?.textColor = passwordColor
                passwordController.activeColor = passwordColor
                passwordController.normalColor = passwordColor
                passwordController.inlinePlaceholderColor = passwordColor
                passwordController.floatingPlaceholderActiveColor = passwordColor
                passwordController.floatingPlaceholderNormalColor = passwordColor
                errorPasswordText.isHidden = true
            }
        }
    }
    private func setupController () {
        controller = MDCTextInputControllerOutlined(textInput: textInput)
        
        controller.activeColor = textColor
        controller.normalColor = textColor
        controller.textInput?.textColor = textColor
        controller.inlinePlaceholderColor = textColor
        controller.floatingPlaceholderActiveColor = textColor
        controller.floatingPlaceholderNormalColor = textColor
        
        passwordController = MDCTextInputControllerOutlined(textInput: passwordInput)
        
        passwordController.activeColor = passwordColor
        passwordController.normalColor = passwordColor
        passwordController.textInput?.textColor = passwordColor
        passwordController.inlinePlaceholderColor = passwordColor
        passwordController.floatingPlaceholderActiveColor = passwordColor
        passwordController.floatingPlaceholderNormalColor = passwordColor
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
