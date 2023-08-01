//
//  ViewController.swift
//  Jupeed
//
//  Created by Dal deng yi on 2020/9/17.
//  Copyright © 2020 Dal deng yi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var MainInfo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func LoginButton(_ sender: Any) {
       
        // Prepare URL
        let url = URL(string: "http://54.180.149.121/util/check_server_connection.php")
        guard let requestUrl = url else { fatalError() }

        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"

        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "input=1";
        
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);

        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
            let responseData = String(data: data!, encoding: String.Encoding.utf8)
            print(responseData)
        }
        task.resume()
    }
}

