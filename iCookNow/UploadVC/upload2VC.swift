//
//  upload2VC.swift
//  iCookNow
//
//  Created by MEHMET ONUR ÜSTÜNEL on 16.06.2020.
//  Copyright © 2020 MEHMET ONUR ÜSTÜNEL. All rights reserved.
//  twitter.com/onur_ustunel
//

import UIKit

var uploadDifficulty = ""

class upload2VC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var difficultyPicker: UIPickerView!
    let difficulty = ["Easy","Medium","Expert"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return difficulty[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return difficulty.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(difficulty[row])
        uploadDifficulty = difficulty[row]
        
        
    }
    
    
    
    @IBAction func backClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toUploadVC", sender: nil)
        
    }
    
    
    @IBAction func nextClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toUpload3VC", sender: nil)
        
    }
    

  

}
