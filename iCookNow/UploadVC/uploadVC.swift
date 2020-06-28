//
//  uploadVC.swift
//  iCookNow
//
//  Created by MEHMET ONUR ÜSTÜNEL on 16.06.2020.
//  Copyright © 2020 MEHMET ONUR ÜSTÜNEL. All rights reserved.
//  twitter.com/onur_ustunel
//

import UIKit
var uploadName = ""

class uploadVC: UIViewController {
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var nextButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    

    @IBAction func backClicked(_ sender: Any) {
    
    }
  
    
    @IBAction func nextClicked(_ sender: Any) {
        
        // perform segue
        if nameText.text != "" {
            uploadName = nameText.text!
            
            performSegue(withIdentifier: "toUpload2VC", sender: nil)
        }
        
            
        }
        
    
    
}
