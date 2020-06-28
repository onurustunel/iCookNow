//
//  ViewController.swift
//  iCookNow
//
//  Created by MEHMET ONUR ÜSTÜNEL on 7.06.2020.
//  Copyright © 2020 MEHMET ONUR ÜSTÜNEL. All rights reserved.
//  twitter.com/onur_ustunel
//

import UIKit
import Firebase
import SDWebImage

var clickedCategoryName = ""

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var discoverCV: UICollectionView!
    @IBOutlet weak var categoriesCV: UICollectionView!
    @IBOutlet weak var recipeCV: UICollectionView!
    var categoriesArray = ["Pizza","Salad","Steak","Vegan"]
    /* -------------------------------------------------------------- */
    
    var recipeNameArray = [String]()
    var uuidArray = [String]()
    var difficultyArray = [String]()
    var minuteArray = [String]()
    var categoryArray = [String]()
    var shortInfoArray = [String]()
    var longInfoArray = [String]()
    var recipeArray = [[String]()]
    var recipeImageUrlArray = [String]()
    var documentIdArray = [String]()
    
    //---------------------------------------
    
     var recipeNameArraySecond = [String]()
     var shortInfoArraySecond = [String]()
     var recipeImageUrlArraySecond = [String]()
     var minuteArraySecond = [String]()
     var categoryArraySecond = [String]()
    var longInfoArraySecond = [String]()
    var recipeArraySecond = [[String]()]
    var documentIdArraySecond = [String]()
    var uuidArraySecond = [String]()
    var difficultyArraySecond = [String]()
    
    //---------------------------------------
    
    var recipeNameTextLast = ""
    var shortInfoTextLast = ""
    var recipeImageUrlTextLast = ""
    var minuteTextLast = ""
    var categoryTextLast = ""
    var longInfoTextLast = ""
    var recipeArrayLast = [String]()
    var documentIdTextLast = ""
    var uuidTextLast = ""
    var difficultyTextLast = ""
    
    
    //---------------------------------------
    
    var selectedName = ""
    var selecteduuid = ""
    var selectedDifficulty = ""
    var selectedMinute = ""
    var selectedCategory = ""
    var selectedShortInfo = ""
    var selectedLongInfo = ""
    var selectedRecipe = [String]()
    var selectedRecipeImageUrl = ""
    var selectedDocumentId = ""
    
    
    
    override func viewDidLoad() {
        discoverCV.dataSource = self
        discoverCV.delegate = self
        categoriesCV.dataSource = self
        categoriesCV.delegate = self
        recipeCV.delegate = self
        recipeCV.dataSource = self

        
        self.view.addSubview(discoverCV)
        self.view.addSubview(categoriesCV)
        self.view.addSubview(recipeCV)
        getDataFromFirestore()
        getDataForRecipe()
       
        super.viewDidLoad()
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == categoriesCV) {
            return 4
        }
        else if (collectionView == recipeCV) {
            return 1      }
        return recipeNameArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if (collectionView == discoverCV) {
           
                let discover1Cell = discoverCV.dequeueReusableCell(withReuseIdentifier: "discoverCVC1", for: indexPath) as! discover1CVC
                  discover1Cell.discover1Label.text = recipeNameArray[indexPath.row]
                  discover1Cell.discover1image.sd_setImage(with: URL(string: self.recipeImageUrlArray[indexPath.row]))
                return discover1Cell
            
        }
        
        else if (collectionView == categoriesCV)  {
                
                // CATEGORIES
                
                if indexPath.row == 0   {
                    
                    let categories1Cell = categoriesCV.dequeueReusableCell(withReuseIdentifier: "categoriesCVC1", for: indexPath) as! categories1CVC
                    categories1Cell.categories1Label.text  = "Pizza"
                    categories1Cell.categories1image.image = UIImage(named: "File1.jpg")
                    
                    return categories1Cell
                }
                    
                    
                else if indexPath.row == 1   {
                    
                    let categories2Cell = categoriesCV.dequeueReusableCell(withReuseIdentifier: "categoriesCVC2", for: indexPath) as! categories2CVC
                    categories2Cell.categories2Label.text  = "Salad"
                    categories2Cell.categories2image.image = UIImage(named: "File2.jpg")
                    
                    return categories2Cell
                }
                    
                else if indexPath.row == 2   {
                    
                    let categories3Cell = categoriesCV.dequeueReusableCell(withReuseIdentifier: "categoriesCVC3", for: indexPath) as! categories3CVC
                    categories3Cell.categories3Label.text  = "Steak"
                    categories3Cell.categories3image.image = UIImage(named: "File3.jpg")
                    
                    return categories3Cell
                }
                    
                else    {
                    
                    let categories4Cell = categoriesCV.dequeueReusableCell(withReuseIdentifier: "categoriesCVC4", for: indexPath) as! categories4CVC
                    categories4Cell.categories4Label.text  = "Vegan"
                    categories4Cell.categories4image.image = UIImage(named: "File4.jpg")
                    
                    return categories4Cell
                }
                
            }
            
        else {
            
            // RECIPE OF DAY
            
            
            let recipeofdayCell = recipeCV.dequeueReusableCell(withReuseIdentifier: "recipeCV1", for: indexPath) as! recipeOfDayCVC
            recipeofdayCell.recipeOfDayName.text  = "\(recipeNameTextLast)"
            recipeofdayCell.recipeOfDayDetail.text = shortInfoTextLast
            recipeofdayCell.recipeOfDayImage.sd_setImage(with: URL(string: self.recipeImageUrlTextLast))
            return recipeofdayCell
       
        }
     
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == categoriesCV) {
            clickedCategoryName = categoriesArray[indexPath.row]
            performSegue(withIdentifier: "toCategoriesVC", sender: nil)
            
        } else if (collectionView == discoverCV) {
            
            selectedName = recipeNameArray[indexPath.row]
            selecteduuid = uuidArray[indexPath.row]
            selectedDifficulty = difficultyArray[indexPath.row]
            selectedMinute = minuteArray[indexPath.row]
            selectedCategory = categoryArray[indexPath.row]
            selectedShortInfo = shortInfoArray[indexPath.row]
            selectedLongInfo = longInfoArray[indexPath.row]
            selectedRecipe = recipeArray[indexPath.row]
            selectedRecipeImageUrl = recipeImageUrlArray[indexPath.row]
            selectedDocumentId = documentIdArray[indexPath.row]
            performSegue(withIdentifier: "toRecipeVC", sender: nil)
           
            
        } else {
            
            selectedName = recipeNameTextLast
            selecteduuid = uuidTextLast
            selectedDifficulty = difficultyTextLast
            selectedMinute = minuteTextLast
            selectedCategory = categoryTextLast
            selectedShortInfo = shortInfoTextLast
            selectedLongInfo = longInfoTextLast
            selectedRecipe = recipeArrayLast
            selectedRecipeImageUrl = recipeImageUrlTextLast
            selectedDocumentId = documentIdTextLast
            
            performSegue(withIdentifier: "toRecipeVC", sender: nil)
       
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecipeVC" {
            
            
            
            let destinationVC = segue.destination as! recipeVC
            
            destinationVC.chosenName = selectedName
            destinationVC.chosenuuid = selecteduuid
            destinationVC.chosenDifficulty = selectedDifficulty
            destinationVC.chosenMinute = selectedMinute
            destinationVC.chosenCategory = selectedCategory
            destinationVC.chosenShortInfo = selectedShortInfo
            destinationVC.chosenLongInfo = selectedLongInfo
            destinationVC.chosenRecipe = selectedRecipe
            destinationVC.chosenRecipeImageUrl = selectedRecipeImageUrl
            destinationVC.chosenDocumentId = selectedDocumentId
         
        }
    }
    
    func getDataFromFirestore() {
     //   let randomNumber = Int(arc4random_uniform(UInt32(4)))
        let randomNumber = Int.random(in: 0 ..< 4)
      
        let fireStoreDatabase = Firestore.firestore()
       
        fireStoreDatabase.collection(categoriesArray[randomNumber]).order(by: "date", descending: true).addSnapshotListener
            { (snapshot, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    if snapshot?.isEmpty != true && snapshot != nil {
                        
                        
                        self.recipeNameArray.removeAll(keepingCapacity: false)
                        self.uuidArray.removeAll(keepingCapacity: false)
                        self.difficultyArray.removeAll(keepingCapacity: false)
                        self.minuteArray.removeAll(keepingCapacity: false)
                        self.documentIdArray.removeAll(keepingCapacity: false)
                        self.categoryArray.removeAll(keepingCapacity: false)
                        self.shortInfoArray.removeAll(keepingCapacity: false)
                        self.longInfoArray.removeAll(keepingCapacity: false)
                        self.recipeArray.removeAll(keepingCapacity: false)
                        self.recipeImageUrlArray.removeAll(keepingCapacity: false)
                        
                        
                        
                        for document in snapshot!.documents {
                            let documentID = document.documentID
                            self.documentIdArray.append(documentID)
                            print(self.documentIdArray)
                            
                            
                            if let recipeName = document.get("recipeName") as? String {
                                self.recipeNameArray.append(recipeName)
                            }
                            
                            if let uuid = document.get("UUID") as? String {
                                self.uuidArray.append(uuid)
                            }

                            if let difficulty = document.get("difficulty") as? String {
                                self.difficultyArray.append(difficulty)
                            }

                            if let duration = document.get("duration") as? String {
                                self.minuteArray.append(duration)
                            }

                            if let category = document.get("category") as? String {
                                self.categoryArray.append(category)
                            }
                            if let ingredients = document.get("ingredients") as? [String] {

                                self.recipeArray.append(ingredients)

                            }
                            if let shortInfo = document.get("shortInfo") as? String {
                                self.shortInfoArray.append(shortInfo)
                            }

                            if let fullRecipe = document.get("fullRecipe") as? String {
                                self.longInfoArray.append(fullRecipe)
                            }
                            
                            if let imageUrl = document.get("imageUrl") as? String {
                                self.recipeImageUrlArray.append(imageUrl)
                            }
                            
                        }
                        
                        self.discoverCV.reloadData()
                        
                        
                    }
                    
                    
                }
        }
    }
   
  
    func getDataForRecipe() {
       
       
        let randomNumber = Int.random(in: 0 ..< 4)
        
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection(categoriesArray[randomNumber]).order(by: "date", descending: true).addSnapshotListener
            { (snapshot, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    if snapshot?.isEmpty != true && snapshot != nil {
                        
                        
                        self.recipeNameArraySecond.removeAll(keepingCapacity: false)
                        self.uuidArraySecond.removeAll(keepingCapacity: false)
                        self.difficultyArraySecond.removeAll(keepingCapacity: false)
                        self.minuteArraySecond.removeAll(keepingCapacity: false)
                        self.documentIdArraySecond.removeAll(keepingCapacity: false)
                        self.categoryArraySecond.removeAll(keepingCapacity: false)
                        self.longInfoArraySecond.removeAll(keepingCapacity: false)
                        self.shortInfoArraySecond.removeAll(keepingCapacity: false)
                        self.recipeArraySecond.removeAll(keepingCapacity: false)
                        self.recipeImageUrlArraySecond.removeAll(keepingCapacity: false)
                        
                        
                        
                        for document in snapshot!.documents {
                            let documentID = document.documentID
                            self.documentIdArraySecond.append(documentID)
                            print(self.documentIdArray)
                            
                            
                            if let recipeName = document.get("recipeName") as? String {
                                self.recipeNameArraySecond.append(recipeName)
                            }
                            
                            if let uuid = document.get("UUID") as? String {
                                self.uuidArraySecond.append(uuid)
                            }

                            if let difficulty = document.get("difficulty") as? String {
                                self.difficultyArraySecond.append(difficulty)
                            }

                            if let duration = document.get("duration") as? String {
                                self.minuteArraySecond.append(duration)
                            }

                            if let category = document.get("category") as? String {
                                self.categoryArraySecond.append(category)
                            }
                            if let ingredients = document.get("ingredients") as? [String] {

                                self.recipeArraySecond.append(ingredients)

                            }
                            if let shortInfo = document.get("shortInfo") as? String {
                                self.shortInfoArraySecond.append(shortInfo)
                            }
                            
                            if let fullRecipe = document.get("fullRecipe") as? String {
                                self.longInfoArraySecond.append(fullRecipe)
                            }

                            if let imageUrl = document.get("imageUrl") as? String {
                                self.recipeImageUrlArraySecond.append(imageUrl)
                            }
                            
                        }
                        let randomNumberSecond = Int.random(in: 0 ..< self.shortInfoArraySecond.count)
                        
                        self.recipeNameTextLast = self.recipeNameArraySecond[randomNumberSecond]
                        self.shortInfoTextLast = self.shortInfoArraySecond[randomNumberSecond]
                        self.recipeImageUrlTextLast = self.recipeImageUrlArraySecond[randomNumberSecond]
                        //
                        self.documentIdTextLast = self.documentIdArraySecond[randomNumberSecond]
                        self.uuidTextLast = self.uuidArraySecond[randomNumberSecond]
                        self.difficultyTextLast = self.difficultyArraySecond[randomNumberSecond]
                        //
                        self.minuteTextLast = self.minuteArraySecond[randomNumberSecond]
                        self.categoryTextLast = self.categoryArraySecond[randomNumberSecond]
                        self.recipeArrayLast = self.recipeArraySecond[randomNumberSecond]
                        self.longInfoTextLast = self.longInfoArraySecond[randomNumberSecond]
                        self.recipeCV.reloadData()
                        
                        
                    }
                   
                }
        }
    }
   
        
}
    

