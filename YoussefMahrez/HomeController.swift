//
//  HomeController.swift
//  YoussefMahrez
//
//  Created by Apple Esprit on 26/4/2022.
//

import UIKit
import CloudKit
import CoreData

class HomeController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    //VAR
    var lot : [Lot] = []
    var id :String=""
    var localisationH : String=""
    var descriptionH : String=""
    var priceH : String=""
    var contactH: String=""
    var image :String = ""
    //WIDGET
    @IBOutlet weak var lotTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lot.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        var imageView = cell?.viewWithTag(1) as! UIImageView
        let lab = cell?.viewWithTag(2) as! UILabel
        let label = cell?.viewWithTag(3) as! UILabel
        lab.text = lot[indexPath.row].localisation
        label.text = lot[indexPath.row].price
        //imageView.loadImge(URLAddress: HOST_URL+"/uploads/users/posts/"+lot[indexPath.row].picture!)!
        let url : URL = URL(string: HOST_URL+"/uploads/users/posts//"+lot[indexPath.row].picture!)!
        imageView.loadImge(WithUrl: url)
        
        
        
        return cell!
    }
    
    
    func getAllLot(){
        
        LotViewModel().recupererAllLot(completed: {
            (success,response) in
            
            if success {                
                self.lot = []
                print(response?.count)
                for singleUser in response!   {
                    self.lot.append(singleUser)
                    print(singleUser)
                }
                self.lotTableView.reloadData()
        
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Something went wrong"), animated: true)
            }
   })
            
            }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //guard let detail = segue.destination as? DetailsViewController else { return }
        //detail.id = self.id
        //print("bbbbbbbbbbbbbbbbbb")
        print("**************details **************")
        print(self.localisationH)
        print(self.descriptionH)
        print(self.priceH)
        print(self.contactH)
        print("****************************")
        if segue.identifier == "detailsSegue"{
            let destination = segue.destination as! DetailsViewController
            destination.id = self.id
            destination.localisation = self.localisationH
            destination.descriptionn = self.descriptionH
            destination.imageText = self.image
            destination.price = self.priceH
            destination.contact = self.contactH
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("aaaaaaaaaaaaaaaaaaaaa")
        self.id = lot[indexPath.row]._id!
        self.localisationH = lot[indexPath.row].localisation!
        self.descriptionH = lot[indexPath.row].description!
        self.priceH = lot[indexPath.row].price!
        self.image = lot[indexPath.row].picture!
        self.contactH = lot[indexPath.row].contact!
        self.performSegue(withIdentifier: "detailsSegue", sender: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getAllLot()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        lotTableView.reloadData()
        getAllLot()
       
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


extension UIImageView {
    func loadImge(WithUrl url:URL) {
        DispatchQueue.global().async {[weak self] in
            if let imageData = try? Data(contentsOf: url){
                if let image = UIImage(data: imageData){
                    DispatchQueue.main.async {
                        self?.image = image
                        
                    }
                }
            }
            
        }
        
   
}
}



