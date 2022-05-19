//
//  ProfileViewController.swift
//  YoussefMahrez
//
//  Created by Apple Esprit on 10/5/2022.
//

import UIKit

class ProfileViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    // VAR
        var utilisateur: Utilisateur?
        var currentPhoto : UIImage?
    
    //Widget
    @IBOutlet weak var EmailTextField: UILabel!

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        initializePage()
        super.viewDidLoad()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
                                profileImage.addGestureRecognizer(tapGR)
                                profileImage.isUserInteractionEnabled = true

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initializePage()
    }
    
 
    
    @IBAction func updateProfilee(_ sender: Any) {
        self.performSegue(withIdentifier: "updtProfileSegue", sender: nil)
    }
    
    func initializePage() {
            UserViewModel().recupererUtilisateur(_id: UserDefaults.standard.string(forKey: "_id")!) { [self] success, result in
               // self.utilisateur = result
                if success {
                Name.text = result?.name
                EmailTextField.text = result?.email
                    let url : URL = URL(string: Constant.host+(result?.picture)!)!

                    self.profileImage.loadImge(WithUrl: url)

//                ImageLoader.shared.loadImage(identifier: (utilisateur?.pictureId) as! String, url: Constant.host + (utilisateur?.pictureId)!) { imageResp in
//
//                   profileImage.image = imageResp
                //}
                } else {
                    
                }
            }
        }
    @objc func imageTapped(sender: UITapGestureRecognizer) {
                        if sender.state == .ended {
                            showActionSheet()                    }
                }
    
    func gallery()
        {
            let myPickerControllerGallery = UIImagePickerController()
            myPickerControllerGallery.delegate = self
            myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
            myPickerControllerGallery.allowsEditing = true
            self.present(myPickerControllerGallery, animated: true, completion: nil)
            
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let selectedImage = info[.originalImage] as? UIImage else {
                return
            }
            UserDefaults.standard.string(forKey: "_id")
        
            currentPhoto = selectedImage
            
            UserViewModel().ChangeProfilePic(id: (UserDefaults.standard.string(forKey: "_id")!), uiImage: selectedImage,completed: { [self] success in
                if success {
                    profileImage.image = selectedImage
                    self.present(Alert.makeAlert(titre: "Succes", message: "Photo modifié avec succés"),animated: true)
                } else {
                    self.present(Alert.makeServerErrorAlert(),animated: true)
                }
            })
            
            self.dismiss(animated: true, completion: nil)
        }
        
        func showActionSheet(){
            
            let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
            actionSheetController.view.tintColor = UIColor.black
            let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
                print("Cancel")
            }
            actionSheetController.addAction(cancelActionButton)
            
            
            let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
            { action -> Void in
                self.gallery()
            }
            
            actionSheetController.addAction(deleteActionButton)
            self.present(actionSheetController, animated: true, completion: nil)
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

//extension UIImageView {
//    func loadImge(WithUrl url:URL) {
//        DispatchQueue.global().async {[weak self] in
//            if let imageData = try? Data(contentsOf: url){
//                if let image = UIImage(data: imageData){
//                    DispatchQueue.main.async {
//                        self?.image = image
//
//                    }
//                }
//            }
//
//        }
//
//
//}
//}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

