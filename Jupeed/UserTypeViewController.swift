//
//  UserTypeViewController.swift
//  Jupeed
//
//  Created by Dal deng yi on 2020/9/22.
//  Copyright © 2020 Dal deng yi. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class UserTypeViewController: UIViewController {

    @IBOutlet weak var userTypeSegment: UISegmentedControl!
    @IBOutlet weak var genderTypeSegment: UISegmentedControl!
    @IBOutlet weak var nextButton: UIButton!
    
    private var textInput: MDCTextField!
    private var controller: MDCTextInputControllerOutlined!
    private let textColor = UIColor(named: "textColor")
    private var placeholderText = "인플루언서 ID"
    
    struct GlobalVariable {
        static var typeInt = 0
        static var genderInt = 0
        static var influencerString = ""
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
            (textInput.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 480)),
            (textInput.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)),
            (textInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)),
            (textInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)),
            ])
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputView()
        setupController()
        self.view.addSubview(nextButton)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
        UserTypeViewController.GlobalVariable.typeInt = userTypeSegment.selectedSegmentIndex
        UserTypeViewController.GlobalVariable.genderInt = genderTypeSegment.selectedSegmentIndex
        UserTypeViewController.GlobalVariable.influencerString = "d6b06b23-03d1-49b0-97cf-f4a2a493c88a"
//        let emailValue = MainInfoViewController.GlobalVariable.emailString
//        let passwordValue = MainInfoViewController.GlobalVariable.passwordString
//        let nameValue = CertificationViewController.GlobalVariable.nameString
//        let phoneValue = CertificationViewController.GlobalVariable.phoneString
//        let birthValue = CertificationViewController.GlobalVariable.birthString
//        let typeValue = userTypeSegment.selectedSegmentIndex
//        let genderValue = genderTypeSegment.selectedSegmentIndex
//        var influencerValue = influencerID.text
//        print(emailValue, passwordValue, nameValue, phoneValue, birthValue, typeValue, genderValue)
//
//        let url = URL(string: "http://54.180.149.121/common/sign_up.php")
//        guard let requestUrl = url else { fatalError() };
//        var request = URLRequest(url: requestUrl)
//        request.httpMethod = "POST"
//        if(influencerValue?.isEmpty == true) {
//            influencerValue = "d6b06b23-03d1-49b0-97cf-f4a2a493c88a"
//        }
//        var postString = "email="+emailValue
//        postString = postString + "&password=" + passwordValue
//        postString = postString + "&name=" + nameValue
//        postString = postString + "&gender=" + String(genderValue)
//        postString = postString + "&phone=" + phoneValue
//        postString = postString + "&birth=" + birthValue
//        postString = postString + "&type=" + String(typeValue)
//        postString = postString + "&influencer_id=" + influencerValue!
//        print(postString)
//        request.httpBody = postString.data(using: String.Encoding.utf8);
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Error took place \(error)")
//                return
//            }
//            do {
//                let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
//                print(parsedData)
//            } catch let error as NSError {
//                print(error)
//            }
//        }
//        task.resume()
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
