//
//  ViewController.swift
//  YoussefMahrez
//
//  Created by iMac on 23/4/2022.
//

import UIKit

class ViewController: UIViewController {

    // VAR
        var utilisateur: Utilisateur?
    
    //widget
    
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwodTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwodTextField.isSecureTextEntry=true
        // Do any additional setup after loading the view.
    }
    // METHODS
        func goToLogin(email: String?) {
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
  
    
    // ACTIONS
    
    @IBAction func inscriptionButton(_ sender: Any) {
        
        if (nomTextField.text!.isEmpty) {
                    self.present(Alert.makeAlert(titre: "Warning", message: "Please type your firstname"), animated: true)
                    return
                }
        
        if (emailTextField.text!.isEmpty) {
                    self.present(Alert.makeAlert(titre: "Warning", message: "Please type your firstname"), animated: true)
                    return
                }
        else if (emailTextField.text?.contains("@") == false){
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your email correctly"), animated: true)
            return
                }
        
        if (passwodTextField.text!.isEmpty) {
                    self.present(Alert.makeAlert(titre: "Warning", message: "Please type your firstname"), animated: true)
                    return
                }
      
        utilisateur?.name = nomTextField.text
        utilisateur?.email = emailTextField.text
        utilisateur?.password = passwodTextField.text
    
        let user = Utilisateur(name:nomTextField.text , email:emailTextField.text, password:passwodTextField.text )

        UserViewModel().inscription(utilisateur: user , completed: { (success) in
                    
                 if success {
                        
                        let alert = UIAlertController(title: "Success", message: "Your account has been created.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                            self.goToLogin(email: self.utilisateur?.email)
                        }
                        alert.addAction(action)
                        self.present(alert, animated: true)
                    } else {
                        self.present(Alert.makeAlert(titre: "Error", message: "Account may already exist."), animated: true)
                    }
                    
                
                    
                })
            }
   
    }



