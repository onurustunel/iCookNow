//
//  categoriesVC.swift
//  iCookNow
//
//  Created by MEHMET ONUR ÜSTÜNEL on 16.06.2020.
//  Copyright © 2020 MEHMET ONUR ÜSTÜNEL. All rights reserved.
//  twitter.com/onur_ustunel
//

import UIKit
import Firebase
import SDWebImage

class categoriesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var categoriesLabel: UILabel!
   
    // ARRAYS
    
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
    
    
    // for Segues
    
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
        super.viewDidLoad()
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesLabel.text = clickedCategoryName
        getDataFromFirestore()
     

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoriesCell = categoriesTableView.dequeueReusableCell(withIdentifier: "categoriesTVC", for: indexPath) as! categoriesTVC
        categoriesCell.categoriesName.text = recipeNameArray[indexPath.row]
        categoriesCell.categoriesDetail.text = shortInfoArray[indexPath.row]
        categoriesCell.timeLabel.text = minuteArray[indexPath.row] + " min"
        categoriesCell.difficultyLabel.text = difficultyArray[indexPath.row]
   
        categoriesCell.categoriesImage.sd_setImage(with: URL(string: self.recipeImageUrlArray[indexPath.row]))
        return categoriesCell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

        performSegue(withIdentifier: "toRecipeDetailVC", sender: nil)
        
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecipeDetailVC" {
            
           
            
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350.0
        
    }
    
    
    func getDataFromFirestore() {
        
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection(clickedCategoryName).order(by: "date", descending: true).addSnapshotListener
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
                        
                        self.categoriesTableView.reloadData()
                        
                    }
                    
                    
                }
        }
    }
    

}
