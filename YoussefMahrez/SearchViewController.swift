//
//  SearchViewController.swift
//  YoussefMahrez
//
//  Created by Mac-Mini-2021 on 17/5/2022.
//

//
//  HomeController.swift
//  YoussefMahrez
//
//  Created by Apple Esprit on 26/4/2022.
//

import UIKit
import CloudKit

class SearchViewController: UIViewController , UITableViewDataSource , UITableViewDelegate,UISearchBarDelegate {
    
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
        imageView.loadFrom(URLAddress: HOST_URL+"/uploads/users/posts/"+lot[indexPath.row].picture!)
        
        
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
        if segue.identifier == "detailsSegueee"{
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
        self.performSegue(withIdentifier: "detailsSegueee", sender: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //  getAllLot()
        // Do any additional setup after loading the view.
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.lot.removeAll()
        self.lotTableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           // When there is no text, filteredData is the same as the original data
           // When user has entered text into the search box
           // Use the filter method to iterate over all items in the data array
           // For each item, return true if the item should be included and false if the
           // item should NOT be included
         
         //  tableView.reloadData()
        if(searchText==""){
            self.lot.removeAll()
            self.lotTableView.reloadData()

        }
        print(searchText)
        searchFunction(text: searchText)
       }

    /*override func viewDidLoad() {
        super.viewDidLoad()
        print(self.followed)*/

        // Do any additional setup after loading the view.
    
    func searchFunction(text :String) {
        LotViewModel().Searchlot(text: text, completed: {
            (success,reponse) in
            self.lot.removeAll()
            if success {
                
                for singleLot in reponse!   {
                
                    self.lot.append(singleLot)

                }
                self.lotTableView.reloadData()

                //self.users=reponse!
                //self.usersTableView.reloadData()
                print("amine")
     
                 } else {
                     self.present(Alert.makeAlert(titre: "Error", message: "Something went wrong"), animated: true)
                 }
        })
    }

}




/*extension UIImageView {
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
 */
