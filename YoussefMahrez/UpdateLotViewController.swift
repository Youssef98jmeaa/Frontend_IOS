//
//  UpdateLotViewController.swift
//  YoussefMahrez
//
//  Created by Mac-Mini-2021 on 19/5/2022.
//

i/*mport UIKit

class UpdateLotViewController: UIViewController {

   
    @IBOutlet weak var localisationTextField: UITextField!
    @IBOutlet weak var ContactTextField: UITextField!
    @IBOutlet weak var PriceTextField: UITextField!
    @IBOutlet weak var DescriptionTextField: UITextField!
    
    //var
    var lot : Lot?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func initializePage() {
        LotViewModel.updateLot(T##self: LotViewModel##LotViewModel)
        self.lot = result
        localisationTextField.text = result?.localisation
        ContactTextField.text = result?.contact
        DescriptionTextField.text = result?.description
        PriceTextField.text = result?.price
        as! String
               
                }
            }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func updateLot(_ sender: Any) {
        if (localisationTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your Name"), animated: true)
            return
        }
        
        if (ContactTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your Name"), animated: true)
            return
        }
        
        if (PriceTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your Name"), animated: true)
            return
        }
        
        if (DescriptionTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your Name"), animated: true)
            return
        }
        
        lot?.localisation=localisationTextField.text
        lot?.description=DescriptionTextField.text
        lot?.price=PriceTextField.text
        lot?.contact=ContactTextField.text
        
        
    }
}*/
