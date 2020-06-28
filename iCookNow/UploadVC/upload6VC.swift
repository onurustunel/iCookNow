//
//  upload6VC.swift
//  iCookNow
//
//  Created by MEHMET ONUR ÜSTÜNEL on 17.06.2020.
//  Copyright © 2020 MEHMET ONUR ÜSTÜNEL. All rights reserved.
//  twitter.com/onur_ustunel
//

import UIKit
import Firebase

class upload6VC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var recipeTextView: UITextView!
    @IBOutlet weak var recipeImage: UIImageView!
    
    
    
    
    
    @IBOutlet weak var addPhotoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTextView.layer.borderWidth = 0.75
        
        recipeImage.isUserInteractionEnabled = true
        let imagePickerRecognizer = UITapGestureRecognizer(target: self, action: #selector(imagePick))
        recipeImage.addGestureRecognizer(imagePickerRecognizer)
        

      
        
        // Do any additional setup after loading the view.
    }
    
    @objc func imagePick(){
        
        
        // Galerimizden fotoğraf seçtik.
        
        // We chose photos from our gallery.
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        picker.delegate = self
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        recipeImage.image = info[.originalImage] as? UIImage
        addPhotoLabel.isHidden = true
        
        self.dismiss(animated: true, completion: nil)
        
    }

    
    @IBAction func backClicked(_ sender: Any) {
        performSegue(withIdentifier: "toUpload5VC", sender: nil)
        
    }
    
  
    @IBAction func saveClicked(_ sender: Any) {
        
        
       
        if recipeTextView.text != "" {
             uploadData()
            
        }
       
    }
    
    func uploadData() {
        
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child(clickedCategoryName)
        
        if let data = recipeImage.image?.jpegData(compressionQuality: 0.1) {
            
            let uuid = UUID().uuidString
          
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("Error")
                }              else {
                    
                    imageReference.downloadURL { (url, error) in
                        
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            
                            
                            //DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl!,
                                                 "UUID" : uuid,
                                                 "recipeName" : uploadName,
                                                 "difficulty" : uploadDifficulty,
                                                 "duration" : uploadMinute,
                                                 "category" : clickedCategoryName,
                                                 "ingredients" : ingredientsArray,
                                                 "shortInfo" : uploadShortInfo,
                                                 "fullRecipe" : self.recipeTextView.text!,
                            "date" : FieldValue.serverTimestamp() ] as [String : Any]
                            
                                                
                            
                            firestoreReference = firestoreDatabase.collection(clickedCategoryName).addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    
                                    print("Error!")
                                    
                                } else {
                                    
                                      self.recipeImage.image = UIImage(named: "uploadImage.png")
                                      self.recipeTextView.text = ""
                                      ingredientsArray = []
                                    
                               
                                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                                    
                                }
                                })
                            
                        }
                        
                    }
                    
                }
            }
            
            
        }
    }
    
    
 
    
}
