//
//  upload4VC.swift
//  iCookNow
//
//  Created by MEHMET ONUR ÜSTÜNEL on 16.06.2020.
//  Copyright © 2020 MEHMET ONUR ÜSTÜNEL. All rights reserved.
//  twitter.com/onur_ustunel
//

import UIKit
import TTGTagCollectionView

 var ingredientsArray = [String]()
class upload4VC: UIViewController, TTGTextTagCollectionViewDelegate {

    let collectionView = TTGTextTagCollectionView()
    
    

    @IBOutlet weak var ingredientsText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      collectionView.alignment = .center
      collectionView.delegate = self

        view.addSubview(collectionView)
        

    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 150, width: view.frame.size.width, height: 200)
        
    }
   
    @IBAction func addClicked(_ sender: Any) {
        
        ingredientsArray.append(ingredientsText.text!)
       
        collectionView.removeAllTags()
        collectionView.reload()
        
       
        let config = TTGTextTagConfig()
        config.backgroundColor = UIColor(red: 15/255, green: 55/255, blue: 91/255, alpha: 1)
        config.borderColor = UIColor.darkGray
        config.borderWidth = 1
        collectionView.reload()
        
        collectionView.addTags(ingredientsArray,
                               with: config)
        
        print(ingredientsArray)
        ingredientsText.text =  ""
       
    }
    
    @IBAction func backClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toUpload3VC", sender: nil)
        
    }
    @IBAction func nextClicked(_ sender: Any) {
        
        if ingredientsArray.count > 0 {
             performSegue(withIdentifier: "toUpload5VC", sender: nil)
            
        }
        
       
    }
    
    
    
    
}
