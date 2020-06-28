//
//  recipeVC.swift
//  iCookNow
//
//  Created by MEHMET ONUR ÜSTÜNEL on 16.06.2020.
//  Copyright © 2020 MEHMET ONUR ÜSTÜNEL. All rights reserved.
//  twitter.com/onur_ustunel
//

import UIKit
import TTGTagCollectionView

class recipeVC: UIViewController, TTGTextTagCollectionViewDelegate {
    
    var ingredientsArray = [String]()
    
    let collectionView = TTGTextTagCollectionView()
    
    var chosenName = ""
    var chosenuuid = ""
    var chosenDifficulty = ""
    var chosenMinute = ""
    var chosenCategory = ""
    var chosenShortInfo = ""
    var chosenLongInfo = ""
    var chosenRecipe = [String]()
    var chosenRecipeImageUrl = ""
    var chosenDocumentId = ""
    
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeShortInfo: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeDifficulty: UILabel!
    @IBOutlet weak var recipeLongInfo: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.getSwipeAction(_:)))
        self.view.addGestureRecognizer(swipeGesture)

        ingredientsArray = chosenRecipe

        
        collectionView.alignment = .center
        collectionView.delegate = self
        
        
        
        view.addSubview(collectionView) 
        
                let config = TTGTextTagConfig()
                config.backgroundColor = UIColor(red: 15/255, green: 55/255, blue: 91/255, alpha: 1)
                config.borderColor = UIColor.darkGray
                config.borderWidth = 1
                collectionView.reload()
        
        collectionView.addTags(ingredientsArray,
                                       with: config)
        
        
        recipeName.text = chosenName
        recipeShortInfo.text = chosenShortInfo
        recipeTime.text = chosenMinute + " min"
        recipeDifficulty.text = chosenDifficulty
        recipeLongInfo.text = chosenLongInfo
        recipeImage.sd_setImage(with: URL(string: chosenRecipeImageUrl))
        
        
      
    }
    
    @objc func getSwipeAction( _ recognizer : UISwipeGestureRecognizer){
        
        if recognizer.direction == .right{
            performSegue(withIdentifier: "fromRecipeToFeed", sender: nil)
            
        } 
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 750, width: view.frame.size.width - 5 , height: 125)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromRecipeToFeed" {
            
           clickedCategoryName = chosenCategory
            
            
        }
    }
    


}
