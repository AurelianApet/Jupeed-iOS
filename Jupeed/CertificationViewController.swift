//
//  CertificationViewController.swift
//  Jupeed
//
//  Created by Dal deng yi on 2020/9/22.
//  Copyright © 2020 Dal deng yi. All rights reserved.
//

import UIKit
import WebKit
import MaterialComponents.MaterialTextFields

class CertificationViewController: UIViewController {

  
    @IBOutlet weak var phoneErrorLabel: UILabel!
    @IBOutlet weak var birthErrorLabel: UILabel!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var SegmentType: UISegmentedControl!
    @IBOutlet weak var nextButton: UIButton!
    
    private var textInput: MDCTextField!
    private var controller: MDCTextInputControllerOutlined!
    private let textColor = UIColor(named: "textColor")
    
    private var phoneInput: MDCTextField!
    private var phoneController: MDCTextInputControllerOutlined!
    private let phoneColor = UIColor(named: "textColor")
    
    private var birthInput: MDCTextField!
    private var birthController: MDCTextInputControllerOutlined!
    private let birthColor = UIColor(named: "textColor")
    
    private var placeholderText = "이름"
    private var phoneholderText = "전화번호(하이픈제외 10~11자리)"
    private var birthholderText = "생년월일(하이픈제외 8자리)"
    
    private var webViewtemp: WKWebView!
    
    var flag = 0
    var date = ""
    var nextpossible = 0
    struct GlobalVariable {
        static var nameString = String()
        static var phoneString = String()
        static var birthString = String()
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
        textInput.addTarget(self, action: #selector(CertificationViewController.nameChanged(_:)), for: .editingChanged)
        
        
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
        phoneInput.addTarget(self, action: #selector(CertificationViewController.phoneChanged(_:)), for: .editingChanged)
        phoneInput.addTarget(self, action: #selector(CertificationViewController.phoneEditEnd(_:)), for: .editingDidEnd)
        
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
        birthInput.addTarget(self, action: #selector(CertificationViewController.birthChanged(_:)), for: .editingChanged)
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
        setupErrorPhone()
        setupErrorBirthday()
        setupErrorName()
        self.view.addSubview(SegmentType)
        self.view.addSubview(nextButton)
        // Do any additional setup after loading the view.
    }
    func setupErrorName() {
        nameErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        nameErrorLabel.text = "이름을 확인해주세요."
        nameErrorLabel.textColor = .red
        nameErrorLabel.isHidden = true
    }
    func setupErrorPhone() {
        phoneErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneErrorLabel.text = "전화번호를 확인해주세요."
        phoneErrorLabel.textColor = .red
        phoneErrorLabel.isHidden = true
        
    }
    func setupErrorBirthday() {
        birthErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        birthErrorLabel.text = "생년월일을 확인해주세요."
        birthErrorLabel.textColor = .red
        birthErrorLabel.isHidden = true
    }
    @objc func phoneEditEnd(_ textField: UITextField) {
        if(flag == 1) {
            phoneErrorLabel.text = "중복된 전화번호입니다. 가입한 적이 없으시다면 고객센터로 문의주세요."
            phoneErrorLabel.isHidden = false
            nextpossible = 1
        }
        else {
            nextpossible = 0
            CertificationViewController.GlobalVariable.phoneString = textField.text!
        }
    }
    @objc func nameChanged(_ textField: UITextField) {
        if(textField.text?.isEmpty == false && (textField.text?.count)! > 10) {
            nameErrorLabel.isHidden = false
            nextpossible = 1
        }
        else {
            nextpossible = 0
            CertificationViewController.GlobalVariable.nameString = textField.text!
        }
    }
    @objc func phoneChanged(_ textField: UITextField) {
        if((textField.text?.isEmpty) == false && ((textField.text?.count)! < 11 || (textField.text?.count)! > 10)) {
            phoneErrorLabel.text = "전화번호를 확인해주세요."
            phoneErrorLabel.isHidden = false
            nextpossible = 1
        }
        if((textField.text?.count)! >= 10 && (textField.text?.count)! <= 11) {
            nextpossible = 0
            phoneErrorLabel.isHidden = true
            
            let url = URL(string: "http://54.180.149.121/common/check_phone_duplicated.php")
            guard let requestUrl = url else { fatalError() };
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
            let postString = "phone=" + textField.text!;
            request.httpBody = postString.data(using: String.Encoding.utf8);
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    print(parsedData)
                    let currentConditions = parsedData["arguments"] as! [String:Any]
                    print(currentConditions)
                    let temp = currentConditions["duplicated"]
                    print(temp)
                    self.flag = temp as! Int
                } catch let error as NSError {
                    print(error)
                }
            }
            task.resume()
        }
    }
    @objc func birthChanged(_ textField: UITextField) {
        if(textField.text?.isEmpty == false && ((textField.text?.count)! < 10 || (textField.text?.count)! > 10)) {
            birthErrorLabel.text = "생년월일을 확인해주세요."
            birthErrorLabel.isHidden = false
            nextpossible = 1
        }
        if((textField.text?.count)! == 10) {
            nextpossible = 0
            CertificationViewController.GlobalVariable.birthString = textField.text!
            
            birthErrorLabel.isHidden = true
            let url = URL(string: "http://54.180.149.121/common/get_server_date.php")
            guard let requestUrl = url else { fatalError() };
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    print(parsedData)
                    let currentConditions = parsedData["arguments"] as! [String:Any]
                    print(currentConditions)
                    let temp = currentConditions["date"]
                    self.date = temp as! String
                } catch let error as NSError {
                    print(error)
                }
            }
            task.resume()
        }
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
        var temp = 0
        if(textInput.text?.isEmpty == true) {
            nameErrorLabel.isHidden = false
            temp = 1
        }
        if(phoneInput.text?.isEmpty == true) {
            phoneErrorLabel.isHidden = false
            temp = 1
        }
        if(birthInput.text?.isEmpty == true) {
            birthErrorLabel.isHidden = false
            temp = 1
        }
        if(date != "") {
            nextpossible = 0
            let index = date.index(of: "-") ?? date.endIndex
            let beginning = date[..<index]
            var serverYear = Int(beginning)
            let temp = birthInput.text
            let start = temp!.index((temp?.startIndex)!, offsetBy: 0)
            let end = temp!.index((temp?.startIndex)!, offsetBy: 4)
            let range = start..<end
            var clientYear = Int(temp![range])
            if(serverYear! - clientYear! < 20) {
                birthErrorLabel.text = "미성년자는 가입할수 없습니다."
                birthErrorLabel.isHidden = false
                nextpossible = 1
            }
            else {
                nextpossible = 0
            }
        }
        else {
            nextpossible = 1
        }
        
        if(temp == 1 || nextpossible == 1) {
            return
        }
        let url = URL(string: "http://54.180.149.121/common/verification.php")
        let request = URLRequest(url: url!)
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        webViewtemp =  WKWebView(frame: CGRect(x: 0, y: 100, width: screenWidth, height: screenHeight))
        webViewtemp.load(request)
        self.view.addSubview(webViewtemp)
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
