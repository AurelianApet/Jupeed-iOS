//
//  LogInViewController.swift
//  Jupeed
//
//  Created by Dal deng yi on 2020/9/23.
//  Copyright © 2020 Dal deng yi. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class LogInViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var LoadingButton: UIActivityIndicatorView!
    
    private var textInput: MDCTextField!
    private var controller: MDCTextInputControllerOutlined!
    private let textColor = UIColor(named: "textColor")
    
    private var passwordInput: MDCTextField!
    private var passwordController: MDCTextInputControllerOutlined!
    private let passwordColor = UIColor(named: "textColor")
    
    private var placeholderText = "이메일"
    private var passwordText = "비밀번호"
    
    private var errorEmailText: UILabel!
    private var errorPasswordText: UILabel!
    
    var possible = 1
    var possibletemp = 1
    var resultString = 0
    
    struct GlobalVariable {
        static var usrBirthString = ""
        static var usrEmailString = ""
        static var usrEulaVersion = Int()
        static var usrGenderString = ""
        static var usrInfluencerID = ""
        static var usrNameString = ""
        static var usrPasswordString = ""
        static var usrPhoneString = ""
        static var usrPrivacyVersion = Int()
        static var usrTypeString = ""
        static var usrIDString = ""
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
            (textInput.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 180)),
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
            (passwordInput.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 270)),
            (passwordInput.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)),
            (passwordInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)),
            (passwordInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)),
            ])
        passwordInput.addTarget(self, action: #selector(LogInViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if(textField == textInput) {
            let textFieldCharacterCount = textField.text?.count ?? 0
            if(textFieldCharacterCount > 0) {
                possibletemp = 0
            }
            else {
                possibletemp = 1
            }
        }
        if(textField == passwordInput) {
            let textFieldCharacterCount = textField.text?.count ?? 0
            if(textFieldCharacterCount < 8 || textFieldCharacterCount > 16) {
                print(textFieldCharacterCount)
                passwordController.textInput?.textColor = UIColor.red
                passwordController.activeColor = UIColor.red
                passwordController.normalColor = UIColor.red
                passwordController.inlinePlaceholderColor = UIColor.red
                passwordController.floatingPlaceholderActiveColor = UIColor.red
                passwordController.floatingPlaceholderNormalColor = UIColor.red
                errorPasswordText.isHidden = false
                possible = 1
            }
            else {
                passwordController.textInput?.textColor = passwordColor
                passwordController.activeColor = passwordColor
                passwordController.normalColor = passwordColor
                passwordController.inlinePlaceholderColor = passwordColor
                passwordController.floatingPlaceholderActiveColor = passwordColor
                passwordController.floatingPlaceholderNormalColor = passwordColor
                errorPasswordText.isHidden = true
                possible = 0
            }
        }
        if(possible == 0 && possibletemp == 0) {
            nextButton.isEnabled = true
        }
        else {
            nextButton.isEnabled = false
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
    
    override func viewDidLayoutSubviews() {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputView()
        setupController()
        nextButton.isEnabled = false
        LoadingButton.isHidden = true
        self.view.addSubview(nextButton)
        self.view.addSubview(LoadingButton)
        
        errorEmailText = UILabel()
        self.view.addSubview(errorEmailText)
        errorEmailText.textColor = UIColor.red
        errorEmailText.text = "이메일을 확인해주세요."
        errorEmailText.font = errorEmailText.font.withSize(15)
        errorEmailText.isHidden = true
        errorEmailText.translatesAutoresizingMaskIntoConstraints = false
        errorEmailText.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 245).isActive = true
        errorEmailText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        errorEmailText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        errorEmailText.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        
        errorPasswordText = UILabel()
        errorPasswordText.textColor = UIColor.red
        errorPasswordText.text = "비밀번호를 확인해주세요.비밀번호는 8~16자리입니다."
        errorPasswordText.font = errorPasswordText.font.withSize(15)
        self.view.addSubview(errorPasswordText)
        errorPasswordText.isHidden = true
        errorPasswordText.translatesAutoresizingMaskIntoConstraints = false
        errorPasswordText.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 335).isActive = true
        errorPasswordText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        errorPasswordText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        errorPasswordText.heightAnchor.constraint(equalToConstant: 21).isActive = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
        let url = URL(string: "http://54.180.149.121/common/sign_in.php")
        guard let requestUrl = url else { fatalError() };
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let postString = "email=" + textInput.text! + "&password=" + passwordInput.text!;
        request.httpBody = postString.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                print(parsedData)
                let tempData = parsedData["arguments"] as! [String:Any]
                print(tempData)
                self.resultString = tempData["result"] as! Int
                if(self.resultString == 1) {
                    let currentConditions = tempData["user_content"] as! [String:Any]
                    print(currentConditions)
                    LogInViewController.GlobalVariable.usrBirthString = currentConditions["birth"] as! String
                    LogInViewController.GlobalVariable.usrEmailString = currentConditions["email"] as! String
                    LogInViewController.GlobalVariable.usrEulaVersion = currentConditions["eulaVersion"] as! Int
                    LogInViewController.GlobalVariable.usrGenderString = currentConditions["gender"] as! String
                    LogInViewController.GlobalVariable.usrInfluencerID = currentConditions["influencerId"] as! String
                    LogInViewController.GlobalVariable.usrNameString = currentConditions["name"] as! String
                    LogInViewController.GlobalVariable.usrPasswordString = currentConditions["password"] as! String
                    LogInViewController.GlobalVariable.usrPhoneString = currentConditions["phone"] as! String
                    LogInViewController.GlobalVariable.usrPrivacyVersion = currentConditions["privacyVersion"] as! Int
                    LogInViewController.GlobalVariable.usrTypeString = currentConditions["type"] as! String
                    LogInViewController.GlobalVariable.usrIDString = currentConditions["userId"] as! String
                }
                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    @IBAction func nextButtonUp(_ sender: Any) {
        LoadingButton.isHidden = false
        LoadingButton.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            sleep(2)
            self.LoadingButton.stopAnimating()
            self.LoadingButton.isHidden = true
            if(self.resultString == 0) {
                self.errorEmailText.isHidden = false
                self.errorPasswordText.isHidden = false
            }
            if(self.resultString == 1) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "AddressSearchScreen") as! AddressSearchViewController
                self.present(vc, animated: true, completion: nil)
                self.resultString = 0
            }
        }
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
