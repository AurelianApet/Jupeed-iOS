//
//  RuleAgreeViewController.swift
//  Jupeed
//
//  Created by Dal deng yi on 2020/9/23.
//  Copyright © 2020 Dal deng yi. All rights reserved.
//

import UIKit
import WebKit

class RuleAgreeViewController: UIViewController {

    
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var btnCheck1: UIButton!
    @IBOutlet weak var btnCheck2: UIButton!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var btnVerifyt: UIButton!
    @IBOutlet weak var btnVerifyr: UIButton!
    @IBOutlet weak var btnAgree: UIButton!
    
    private var webViewtemp: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCheck.setImage(UIImage(named:"checkmarkempty"), for: .normal)
        btnCheck.setImage(UIImage(named:"checkmark"), for: .selected)
        btnCheck1.setImage(UIImage(named:"checkmarkempty"), for: .normal)
        btnCheck1.setImage(UIImage(named:"checkmark"), for: .selected)
        btnCheck2.setImage(UIImage(named:"checkmarkempty"), for: .normal)
        btnCheck2.setImage(UIImage(named:"checkmark"), for: .selected)
        btnAgree.setImage(UIImage(named:"checkmarkempty"), for: .normal)
        btnAgree.setImage(UIImage(named:"checkmark"), for: .selected)
        
        btnVerify.layer.cornerRadius = 5
        btnVerify.layer.borderWidth = 2
        btnVerify.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        btnVerifyt.layer.cornerRadius = 5
        btnVerifyt.layer.borderWidth = 2
        btnVerifyt.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        btnVerifyr.layer.cornerRadius = 5
        btnVerifyr.layer.borderWidth = 2
        btnVerifyr.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func checkMarkTapped(_ sender: Any) {
        self.btnCheck.isSelected = !self.btnCheck.isSelected
        self.btnCheck.transform = .identity
    }
    @IBAction func checkMarkeTapped(_ sender: Any) {
        self.btnCheck1.isSelected = !self.btnCheck1.isSelected
        self.btnCheck1.transform = .identity
    }
    @IBAction func checkMarkrTapped(_ sender: Any) {
        self.btnCheck2.isSelected = !self.btnCheck2.isSelected
        self.btnCheck2.transform = .identity
    }
    @IBAction func checkMarkATapped(_ sender: Any) {
        self.btnAgree.isSelected = !self.btnAgree.isSelected
        self.btnCheck2.transform = .identity
        
        self.btnCheck.isSelected = self.btnAgree.isSelected
        self.btnCheck.transform = .identity
        self.btnCheck1.isSelected = self.btnAgree.isSelected
        self.btnCheck1.transform = .identity
        self.btnCheck2.isSelected = self.btnAgree.isSelected
        self.btnCheck2.transform = .identity
    }
    @IBAction func nextButtonClick(_ sender: Any) {
        let emailValue = MainInfoViewController.GlobalVariable.emailString
        let passwordValue = MainInfoViewController.GlobalVariable.passwordString
        let nameValue = CertificationViewController.GlobalVariable.nameString
        let phoneValue = CertificationViewController.GlobalVariable.phoneString
        let birthValue = CertificationViewController.GlobalVariable.birthString
        let typeValue = UserTypeViewController.GlobalVariable.typeInt
        let genderValue = UserTypeViewController.GlobalVariable.genderInt
        var influencerValue = UserTypeViewController.GlobalVariable.influencerString
        print(emailValue, passwordValue, nameValue, phoneValue, birthValue, typeValue, genderValue)

        let url = URL(string: "http://54.180.149.121/common/sign_up.php")
        guard let requestUrl = url else { fatalError() };
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        if(influencerValue.isEmpty == true) {
            influencerValue = "d6b06b23-03d1-49b0-97cf-f4a2a493c88a"
        }
        var postString = "email="+emailValue
        postString = postString + "&password=" + passwordValue
        postString = postString + "&name=" + nameValue
        postString = postString + "&gender=" + String(genderValue)
        postString = postString + "&phone=" + phoneValue
        postString = postString + "&birth=" + birthValue
        postString = postString + "&type=" + String(typeValue)
        postString = postString + "&influencer_id=" + influencerValue
        print(postString)
        request.httpBody = postString.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                print(parsedData)
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    @IBAction func btnVerifyClick(_ sender: Any) {
        let url = URL(string: "http://54.180.149.121/policy/sign_up_eula.html")
        let request = URLRequest(url: url!)
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        webViewtemp =  WKWebView(frame: CGRect(x: 0, y: 100, width: screenWidth, height: screenHeight))
        webViewtemp.load(request)
        self.view.addSubview(webViewtemp)
    }
    @IBAction func btnVerifyrClick(_ sender: Any) {
        let url = URL(string: "http://54.180.149.121/policy/sign_up_privacy.html")
        let request = URLRequest(url: url!)
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        webViewtemp =  WKWebView(frame: CGRect(x: 0, y: 100, width: screenWidth, height: screenHeight))
        webViewtemp.load(request)
        self.view.addSubview(webViewtemp)
    }
    @IBAction func btnVerifytClick(_ sender: Any) {
        let url = URL(string: "http://54.180.149.121/policy/sign_up_location.html")
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
