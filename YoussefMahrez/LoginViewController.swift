//
//  LoginViewController.swift
//  YoussefMahrez
//
//  Created by iMac on 24/4/2022.
//

import UIKit

class LoginViewController: UIViewController {

    // VAR
        let utilisateurViewModel = UserViewModel()
    
    var email: String?
    // WIDGET
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry=true 
    
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func Login(_ sender: Any) {
  
        if(EmailTextField.text!.isEmpty || passwordTextField.text!.isEmpty){
                   self.present(Alert.makeAlert(titre: "Warning", message: "Please type your credentials"), animated: true)
                   return
               }
        print(EmailTextField.text!)
        print(passwordTextField.text! )
        utilisateurViewModel.login(email: EmailTextField.text!, password: passwordTextField.text!,completed: { (success, reponse) in
            
            if success {
                let user = reponse as! Utilisateur
                
                print (user)
                self.performSegue(withIdentifier: "connectSegue", sender: nil)

            } else {
                self.present(Alert.makeAlert(titre: "Warning", message: "Email or password incorrect"), animated: true)
            }
     
                                  
    
        })
    }
}
