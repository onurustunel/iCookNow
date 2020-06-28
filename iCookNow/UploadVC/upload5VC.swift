//
//  upload5VC.swift
//  iCookNow
//
//  Created by MEHMET ONUR ÜSTÜNEL on 16.06.2020.
//  Copyright © 2020 MEHMET ONUR ÜSTÜNEL. All rights reserved.
//  twitter.com/onur_ustunel
//

import UIKit

var uploadShortInfo = ""
class upload5VC: UIViewController {
    
    @IBOutlet weak var shortTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

         shortTextView.layer.borderWidth = 0.75
        
    }
    
    @IBAction func backClicked(_ sender: Any) {
        performSegue(withIdentifier: "toUpload4VC", sender: nil)
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        
        
        if shortTextView.text != "" {
            
            uploadShortInfo = shortTextView.text!
            
            performSegue(withIdentifier: "toUpload6VC", sender: nil)
        }
       
        
    }
    

}
