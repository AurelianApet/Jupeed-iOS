//
//  StoreLocationViewController.swift
//  Jupeed
//
//  Created by Dal deng yi on 2020/9/25.
//  Copyright © 2020 Dal deng yi. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class StoreLocationViewController: UIViewController {

    @IBOutlet weak var plusButton: UIButton!
    private var textInput: MDCTextField!
    private var controller: MDCTextInputControllerOutlined!
    private let textColor = UIColor(named: "textColor")
    
    private var placeholderText = "배달 지역(예:역삼동,*강남구,*반포동)"
    
    private var errorEmailText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputView()
        setupController()
        
        errorEmailText = UILabel()
        self.view.addSubview(errorEmailText)
        errorEmailText.textColor = UIColor.red
        errorEmailText.text = "배달 지역은 행정단위(예:시,읍,동)여야 합니다."
        errorEmailText.font = errorEmailText.font.withSize(15)
        errorEmailText.isHidden = true
        errorEmailText.translatesAutoresizingMaskIntoConstraints = false
        errorEmailText.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 475).isActive = true
        errorEmailText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        errorEmailText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        errorEmailText.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        // Do any additional setup after loading the view.
    }
    private func setupInputView() {
        
        if let _ = self.view.viewWithTag(1){return}
        textInput = MDCTextField()
        textInput.tag = 1
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.isHidden = true
        self.view.addSubview(textInput)
        textInput.placeholder = placeholderText
        textInput.textColor = textColor
        
        NSLayoutConstraint.activate([
            (textInput.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 410)),
            (textInput.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)),
            (textInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)),
            (textInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)),
            ])
        textInput.addTarget(self, action: #selector(LogInViewController.textFieldDidChange(_:)), for: .editingChanged)
        
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
    }
    private func setupController () {
        controller = MDCTextInputControllerOutlined(textInput: textInput)
        
        controller.activeColor = textColor
        controller.normalColor = textColor
        controller.textInput?.textColor = textColor
        controller.inlinePlaceholderColor = textColor
        controller.floatingPlaceholderActiveColor = textColor
        controller.floatingPlaceholderNormalColor = textColor
    }
    @IBAction func plusButtonClick(_ sender: Any) {
        textInput.isHidden = !textInput.isHidden
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
