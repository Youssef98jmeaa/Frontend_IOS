//
//  UpdateProfileViewController.swift
//  YoussefMahrez
//
//  Created by Mac-Mini-2021 on 18/5/2022.
//

import UIKit

class UpdateProfileViewController: UIViewController {

    
   
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var NameTextFIeld: UITextField!
    // VAR
        var utilisateur: Utilisateur?
        var currentPhoto : UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializePage()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        initializePage()
       
    }
    
        func initializePage() {
                UserViewModel().recupererUtilisateur(_id: UserDefaults.standard.string(forKey: "_id")!) { [self] success, result in
                
                    self.utilisateur = result
                    NameTextFIeld.text = result?.name
                    EmailTextField.text = result?.email
                    as! String
                   
                    }
                }
            
      
      
    
    @IBAction func UpdtProfile(_ sender: Any) {
        print("Edited profile")
               
               if (NameTextFIeld.text!.isEmpty) {
                   self.present(Alert.makeAlert(titre: "Error", message: "Please type your Name"), animated: true)
                   return
               }
               
               if (EmailTextField.text!.isEmpty) {
                   self.present(Alert.makeAlert(titre: "Error", message: "Please type your Email"), animated: true)
                   return
                   
               }
        
        utilisateur?.name = NameTextFIeld.text
           utilisateur?.email = EmailTextField.text
        
        UserViewModel().updateProfile(utilisateur: utilisateur!,methode: .put, completed: { (success) in
                  print(success)
                  if success {
                  } else {
                      
                  }
              })
              
              self.dismiss(animated: true, completion: nil)
          }
        
    
    
    
}
