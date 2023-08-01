//
//  MainInfoViewController.swift
//  Jupeed
//
//  Created by Dal deng yi on 2020/9/22.
//  Copyright © 2020 Dal deng yi. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class MainInfoViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var secretIDText: UITextField!
    @IBOutlet weak var secretWordText: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var duplicateEmail: UILabel!
    
    private var textInput: MDCTextField!
    private var controller: MDCTextInputControllerOutlined!
    private let textColor = UIColor(named: "textColor")
    
    private var phoneInput: MDCTextField!
    private var phoneController: MDCTextInputControllerOutlined!
    private let phoneColor = UIColor(named: "textColor")
    
    private var birthInput: MDCTextField!
    private var birthController: MDCTextInputControllerOutlined!
    private let birthColor = UIColor(named: "textColor")
    
    private var placeholderText = "이메일"
    private var phoneholderText = "비밀번호(8~16자)"
    private var birthholderText = "비밀번호 확인"
    
    var flag = 0
    var value = 0
    
    struct GlobalVariable{
        static var myString = String()
        static var emailString = String()
        static var passwordString = String()

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
            (textInput.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 230)),
            (textInput.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)),
            (textInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)),
            (textInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)),
            ])
        textInput.addTarget(self, action: #selector(MainInfoViewController.emailChange(_:)), for: .editingChanged)
        textInput.addTarget(self, action: #selector(MainInfoViewController.emailVerify(_:)), for: .editingDidEnd)
        
        phoneInput = MDCTextField()
        phoneInput.tag = 1
        phoneInput.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(phoneInput)
        phoneInput.placeholder = phoneholderText
        phoneInput.textColor = phoneColor
        NSLayoutConstraint.activate([
            (phoneInput.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 320)),
            (phoneInput.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)),
            (phoneInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)),
            (phoneInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)),
            ])
        phoneInput.addTarget(self, action: #selector(MainInfoViewController.secretIDChange(_:)), for: .editingChanged)
        phoneInput.addTarget(self, action: #selector(MainInfoViewController.secretIDVerify(_:)), for: .editingDidEnd)
        
        birthInput = MDCTextField()
        birthInput.tag = 1
        birthInput.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(birthInput)
        birthInput.placeholder = birthholderText
        birthInput.textColor = birthColor
        NSLayoutConstraint.activate([
            (birthInput.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 410)),
            (birthInput.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)),
            (birthInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)),
            (birthInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)),
            ])
        birthInput.addTarget(self, action: #selector(MainInfoViewController.secretWordChange(_:)), for: .editingChanged)
    }
    private func setupController () {
        controller = MDCTextInputControllerOutlined(textInput: textInput)
        
        controller.activeColor = textColor
        controller.normalColor = textColor
        controller.textInput?.textColor = textColor
        controller.inlinePlaceholderColor = textColor
        controller.floatingPlaceholderActiveColor = textColor
        controller.floatingPlaceholderNormalColor = textColor
        
        phoneController = MDCTextInputControllerOutlined(textInput: phoneInput)
        
        phoneController.activeColor = phoneColor
        phoneController.normalColor = phoneColor
        phoneController.textInput?.textColor = phoneColor
        phoneController.inlinePlaceholderColor = phoneColor
        phoneController.floatingPlaceholderActiveColor = phoneColor
        phoneController.floatingPlaceholderNormalColor = phoneColor
        
        birthController = MDCTextInputControllerOutlined(textInput: birthInput)
        
        birthController.activeColor = birthColor
        birthController.normalColor = birthColor
        birthController.textInput?.textColor = birthColor
        birthController.inlinePlaceholderColor = birthColor
        birthController.floatingPlaceholderActiveColor = birthColor
        birthController.floatingPlaceholderNormalColor = birthColor
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputView()
        setupController()
        setupErrorMessage()
        setupDuplicateEmail()
        nextButton.isEnabled = false
        self.view.addSubview(nextButton)
        // Do any additional setup after loading the view.
    }
    func setField() {
        // Prepare URL
        let url = URL(string: "http://54.180.149.121/common/check_email_duplicated.php")
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "email=" + textInput.text!;
        
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                let currentConditions = parsedData["arguments"] as! [String:Any]
                let temp = currentConditions["duplicated"]
                self.flag = temp as! Int
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
        
    }
    func setupErrorMessage() {
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        errorMessage.text = "비밀번호를 확인해주세요."
        errorMessage.textColor = .red
        errorMessage.isHidden = true

    }
    func setupDuplicateEmail() {
        duplicateEmail.translatesAutoresizingMaskIntoConstraints = false
        duplicateEmail.text = "중복된 이메일입니다. 다른 이메일을 입력해주세요."
        duplicateEmail.textColor = .red
        duplicateEmail.isHidden = true
    }
    @objc func emailChange(_ textField: UITextField) {
        setField()

    }
    @objc func secretIDChange(_ textField: UITextField) {
        if(flag == 1 || value == 1 || textInput.text == "" || phoneInput.text == "" || birthInput.text == ""){
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
        if((phoneInput.text?.count)! < 8 || (phoneInput.text?.count)! > 16){
            errorMessage.isHidden = false
            phoneInput.layer.borderColor = UIColor.red.cgColor
            nextButton.isEnabled = false
            value = 1
        }
        else {
            MainInfoViewController.GlobalVariable.passwordString = phoneInput.text!
            nextButton.isEnabled = true
            errorMessage.isHidden = true
            value = 0
        }
    }
    @objc func secretWordChange(_ textField: UITextField) {
        if(flag == 1 || value == 1 || textInput.text == "" || phoneInput.text == "" || birthInput.text == ""){
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
    }
    @objc func emailVerify(_ textField: UITextField) {
        if(flag == 1 || (textField.text?.isEmpty)! == true || phoneInput.text == "" || birthInput.text == "") {
            nextButton.isEnabled = false
            if(flag == 1) {
                duplicateEmail.isHidden = false
            }
        }
        else{
            if(flag == 0 && (textField.text?.isEmpty)! != true) {
                duplicateEmail.isHidden = true
                MainInfoViewController.GlobalVariable.emailString = textInput.text!
            }
            if(flag == 0 && (textField.text?.isEmpty) == false && phoneInput.text != "" && birthInput.text != "") {
                nextButton.isEnabled = true
            }
        }
    }
    @objc func secretIDVerify(_ textField: UITextField) {
        
    }
    @IBAction func nextButtonClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CertificationScreen") as! CertificationViewController
        self.present(vc, animated: true, completion: nil)
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
