//
//  upload3VC.swift
//  iCookNow
//
//  Created by MEHMET ONUR ÜSTÜNEL on 16.06.2020.
//  Copyright © 2020 MEHMET ONUR ÜSTÜNEL. All rights reserved.
//  twitter.com/onur_ustunel
//

import UIKit

var uploadMinute = ""
class upload3VC: UIViewController {
    
  
  
    @IBOutlet weak var minuteText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toUpload2VC", sender: nil)
        
    }
    
    @IBAction func nextClicked(_ sender: Any) {
      
        if minuteText.text != "" {
            
            uploadMinute = minuteText.text!
            
            performSegue(withIdentifier: "toUpload4VC", sender: nil)
            
        }
        
        
    }
    

}
