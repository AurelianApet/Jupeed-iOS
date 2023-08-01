//
//  AddressSearchViewController.swift
//  Jupeed
//
//  Created by Dal deng yi on 2020/9/24.
//  Copyright © 2020 Dal deng yi. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class AddressSearchViewController: UIViewController {

    @IBOutlet weak var checkAddress: UIButton!
    @IBOutlet weak var locationSearch: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    private var textRoad: MDCTextField!
    private var controller: MDCTextInputControllerOutlined!
    private let textColor = UIColor(named: "textColor")
    
    private var textBuilding: MDCTextField!
    private var buildingController: MDCTextInputControllerOutlined!
    private let buildingColor = UIColor(named: "textColor")
    
    private var placeholderText = "도로명 (예:강남대로)"
    private var buildingText = "건물번호 (예:396)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputView()
        setupController()
        self.view.addSubview(locationSearch)
        self.view.addSubview(searchButton)
  
        checkAddress.setImage(UIImage(named: "checkmarkempty"), for: .normal)
        checkAddress.setImage(UIImage(named: "checkmark"), for: .selected)
        // Do any additional setup after loading the view.
    }
    
    private func setupInputView() {
        
        if let _ = self.view.viewWithTag(1){return}
        textRoad = MDCTextField()
        textRoad.tag = 1
        textRoad.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textRoad)
        textRoad.placeholder = placeholderText
        textRoad.textColor = textColor
        
        NSLayoutConstraint.activate([
            (textRoad.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 180)),
            (textRoad.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)),
            (textRoad.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)),
            (textRoad.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)),
            ])
        
        textBuilding = MDCTextField()
        textBuilding.tag = 1
        textBuilding.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textBuilding)
        textBuilding.placeholder = buildingText
        textBuilding.textColor = buildingColor
        NSLayoutConstraint.activate([
            (textBuilding.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 270)),
            (textBuilding.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)),
            (textBuilding.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)),
            (textBuilding.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)),
            ])
    }
    private func setupController () {
        controller = MDCTextInputControllerOutlined(textInput: textRoad)
        
        controller.activeColor = textColor
        controller.normalColor = textColor
        controller.textInput?.textColor = textColor
        controller.inlinePlaceholderColor = textColor
        controller.floatingPlaceholderActiveColor = textColor
        controller.floatingPlaceholderNormalColor = textColor
        
        buildingController = MDCTextInputControllerOutlined(textInput: textBuilding)
        
        buildingController.activeColor = buildingColor
        buildingController.normalColor = buildingColor
        buildingController.textInput?.textColor = buildingColor
        buildingController.inlinePlaceholderColor = buildingColor
        buildingController.floatingPlaceholderActiveColor = buildingColor
        buildingController.floatingPlaceholderNormalColor = buildingColor
    }
    @IBAction func checkButtonTap(_ sender: Any) {
        self.checkAddress.isSelected = !self.checkAddress.isSelected
        self.checkAddress.transform = .identity
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
