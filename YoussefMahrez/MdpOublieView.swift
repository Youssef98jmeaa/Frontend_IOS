//
//  MdpOublieView.swift
//  E-Pharm
//
//  Created by Mac2021 on 15/4/2022.
//

import UIKit

class MdpOublieView: UIViewController {
    
    //VAR
    struct MotDePasseOublieData {
        var email: String?
        var code: String?
    }
    var data : MotDePasseOublieData?
    let spinner = SpinnerViewController()
    
    // WIDGET
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ConfirmationView
        destination.data = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func startSpinner() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    func stopSpinner() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
    
    //Action
    
    
    @IBAction func suivant(_ sender: Any) {
        if (emailTextField.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your email"), animated: true)
            return


    }
        startSpinner()
        
        data = MotDePasseOublieData(email: emailTextField.text, code: String(Int.random(in: 10000..<99999)))
        
        UserViewModel().motDePasseOublie(email: (data?.email)!, codeDeReinit: (data?.code)! ) { success in
            self.stopSpinner()
            if success {
                self.performSegue(withIdentifier: "Confirm", sender: self.data)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Email does not exist"), animated: true)
            }
        }
    


}
}
