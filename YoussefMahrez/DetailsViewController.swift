//
//  DetailsViewController.swift
//  YoussefMahrez
//
//  Created by Apple Esprit on 5/5/2022.
//

import UIKit


class DetailsViewController: UIViewController {
    //var
    var id : String!
    var localisation : String!
    var descriptionn : String!
    var price : String!
    var contact : String!
    var imageText : String!
    
    //widget
    
    @IBOutlet var DetailsImageView: UIView!
    @IBOutlet weak var LocalisationLabelView: UILabel!
    @IBOutlet weak var DescrptionTextView: UITextView!
    @IBOutlet weak var PriceLabelView: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var ContactLabelView: UILabel!
    
    override func viewDidLoad() {
    
        
        self.LocalisationLabelView.text = (localisation)!
        self.DescrptionTextView.text = (descriptionn)!
        self.PriceLabelView.text = (price)!
        self.ContactLabelView.text = (contact)!
        print(localisation)
        self.image.loadFrom(URLAddress:HOST_URL+"/uploads/users/posts/"+self.imageText! )
        print(descriptionn)
        print(price)
        print(contact)
        super.viewDidLoad()
        //InitLot()
        // Do any additional setup after loading the view.
    }
    
    func InitLot(){
        LotViewModel().GetLotById(_id: id, completed: {
            (success,response) in
            if success {
                print("LLLLLLLLLLLLLLLLLL")
                self.LocalisationLabelView.text = (response?.localisation)!
                self.DescrptionTextView.text = (response?.description)!
                self.PriceLabelView.text = (response?.price)!
                self.ContactLabelView.text = (response?.contact)!
                print("PHPHPHPHPHPHPHPHPHPHPHPHPH")
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Somthing went wrong"),animated: true)
                
            }
        }
        )
    
    }
    
    
    
    @IBAction func saveLot(_ sender: Any) {
    }
    
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
