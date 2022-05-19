//
//  AddLotController.swift
//  YoussefMahrez
//
//  Created by iMac on 16/5/2022.
//

import UIKit

class AddLotController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

   //var
    
    @IBOutlet weak var pictureImg: UIImageView!
   
    @IBOutlet weak var ContactTextField: UITextField!
    @IBOutlet weak var PriceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var LocalisationTextField: UITextField!
@IBOutlet weak var imageView: UIView!
    
    //var
    var videoUrl : UIImage?
    var lot = Lot()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pictureImg.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnTakePhoto(_ sender: Any) {
        showPhotoAlert()
    }
    
    
    func makeAlert(titre: String?, message: String?) {
        let alert = UIAlertController(title: titre, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    @IBAction func takePhoto1(_ sender: Any) {
        showPhotoAlert()

    }
    
    @IBAction func addLot(_ sender: Any) {
        if (descriptionTextField.text == "") {
            makeAlert(titre: "Warning", message: "Please type your Description")
            return
        }
        if (LocalisationTextField.text == "") {
            makeAlert(titre: "Warning", message: "Please type your Location")
            return
        }
        if (PriceTextField.text == "") {
            makeAlert(titre: "Warning", message: "Please type your Price")
            return
        }
        if (ContactTextField.text == "") {
            makeAlert(titre: "Warning", message: "Please type your Num")
            return
        }
        if (videoUrl == nil){
            self.present(Alert.makeAlert(titre: "Warning", message: "Choose a picture"), animated: true)
            return
        }
    
        
        let lot = Lot(
            localisation:LocalisationTextField.text,
            description: descriptionTextField.text,
            price:PriceTextField.text,
            contact: ContactTextField.text
        )
        
        LotViewModel().ajouterLot(lot:lot,  videoUrl: videoUrl! , completed: { [self] (success,response) in
            if success {
                print(response)
                    let lotId = response!._id;
                    let alert = UIAlertController(title: "Success", message: "Your lot has been added.", preferredStyle: .alert)
                LotViewModel().modifierLot (
                    _id : lotId!,
                    description: descriptionTextField.text!,
                    localisation:LocalisationTextField.text!,
                    price:PriceTextField.text!,
                    contact: ContactTextField.text!,
                    completed: { [self] (success,response) in
                        if success {
                            self.present(Alert.makeAlert(titre: "Succes", message: "Your lot has been added."),animated: true)
                        } else {
                            self.present(Alert.makeServerErrorAlert(),animated: true)
                        }
                        
                    })        
                    }else {
                        self.present(Alert.makeAlert(titre: "Error", message: "Error."), animated: true)
                     }

                        
                        
       })

    }
              
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
    //func
    func showPhotoAlert(){
        let alert = UIAlertController(title: "Take Photo From:", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {action in
            self.getPhoto(type: .camera)

        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {action in
            self.getPhoto(type: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true , completion: nil )
    }
    
    
    func getPhoto( type : UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = type
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard  let image = info[.editedImage] as? UIImage else {
            print("image not found")
            return
        }
        pictureImg.image = image
        self.videoUrl=image
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
            
            func prompt(title: String, message: String) {
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
            }
    
}
