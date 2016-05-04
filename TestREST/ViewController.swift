//
//  ViewController.swift
//  TestREST
//
//  Created by Siwawes Wongcharoen on 5/4/2559 BE.
//  Copyright © 2559 puuga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        callREST()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func callREST() -> Void {
        let url = NSURL(string: "http://128.199.133.166/roomlink/location.php")
        
        let configuration = NSURLSessionConfiguration .defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = url
        request.HTTPMethod = "GET"
        request.timeoutInterval = 30
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let dataTask = session.dataTaskWithRequest(request) {
            (let data: NSData?, let response: NSURLResponse?, let error: NSError?) -> Void in
            
            // 1: Check HTTP Response for successful GET request
            guard let httpResponse = response as? NSHTTPURLResponse, receivedData = data
                else {
                    print("error: not a valid http response")
                    return
            }
            
            switch (httpResponse.statusCode) {
            case 200:
                let response = NSString (data: receivedData, encoding: NSUTF8StringEncoding)
                print("\(response)")
                print("---")
                
                do {
                    let getResponse = try NSJSONSerialization.JSONObjectWithData(receivedData, options: .AllowFragments)
                    
                    print("\(getResponse)")
                } catch {
                    print("error serializing JSON: \(error)")
                }
                
                break
            case 400:
                print("response \(httpResponse.statusCode)")

                break
            default:
                print("response \(httpResponse.statusCode)")
            }
        }
        dataTask.resume()
        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
//            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
//        }
//        
//        task.resume()
    }

}

