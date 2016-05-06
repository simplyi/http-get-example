//
//  ViewController.swift
//  HTTP-GET-example
//
//  Created by Sergey Kargopolov on 2016-01-01.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendButtonTapped(sender: AnyObject) {
        let userNameValue = userNameTextField.text
        
        if isStringEmpty(userNameValue!) == true
        {
            return
        }
        
        // Send HTTP GET Request 
  
        
        let scriptUrl = "http://swiftdeveloperblog.com/my-http-get-example-script/"
        let urlWithParams = scriptUrl + "?userName=\(userNameValue!)"
        let myUrl = NSURL(string: urlWithParams);
        
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "GET"
        
        // Add Basic Authorization
        /*
        let username = "myUserName"
        let password = "myPassword"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
        request.setValue(base64LoginString, forHTTPHeaderField: "Authorization")
        */
        
        // Or add Token value
        //request.addValue("Token token=884288bae150b9f2f68d8dc3a932071d", forHTTPHeaderField: "Authorization")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
            
            // Convert server json response to NSDictionary
            do {
                if let convertedJsonIntoDict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    
                    // Print out dictionary
                    print(convertedJsonIntoDict)
                    
                    let firstNameValue = convertedJsonIntoDict["userName"] as? String
                    print(firstNameValue!)
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()

        
    }
    
    
    func isStringEmpty(var stringValue:String) -> Bool
    {
        var returnValue = false
    
        if stringValue.isEmpty  == true
        {
            returnValue = true
            return returnValue
        }
        
        stringValue = stringValue.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        if(stringValue.isEmpty == true)
        {
            returnValue = true
            return returnValue
 
        }
    
          return returnValue
        
    }

}

