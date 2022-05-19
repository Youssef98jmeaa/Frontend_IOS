//
//  LotViewModel.swift
//  YoussefMahrez
//
//  Created by Apple Esprit on 26/4/2022.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

public class LotViewModel: ObservableObject{
    
    static let sharedInstance = LotViewModel()
    
    func makeItem(jsonItem: JSON) -> Lot {
            
            return Lot(
                _id: jsonItem["_id"].stringValue,
                localisation: jsonItem["localisation"].stringValue,
                description: jsonItem["description"].stringValue,
                price: jsonItem["price"].stringValue,
                contact: jsonItem["contact"].stringValue,
                picture: jsonItem["picture"].stringValue
            )
        }
    
    
    func recupererAllLot(  completed: @escaping (Bool, [Lot]?) -> Void ) {
            AF.request(HOST_URL + "/users/lot/show/all",
                       method: .get)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        let jsonData = JSON(response.data!)
                        print(jsonData)
                        var lot : [Lot]? = []
                        for singleJsonItem in jsonData["posts"] {
                            lot!.append(self.makeItem(jsonItem: singleJsonItem.1))
                        }
                        completed(true, lot)
                    case let .failure(error):
                        debugPrint(error)
                        completed(false,nil)
                    }
                }
        }
    
    
    func GetLotById(_id: String,completed: @escaping (Bool, Lot?) -> Void) {
        print("----------------------------")
        print(_id)
        print("----------------------------")
        AF.request(HOST_URL + "/users/lot/show/one/"+_id, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let lot = self.makeItem(jsonItem: jsonData)
                    completed(true, lot)

                case let .failure(error):
                    debugPrint(error)
                    completed(false,nil)
                }
            }
    }
    
    
    func ajouterLot(lot: Lot, videoUrl: UIImage, completed: @escaping (Bool,Lot?) -> Void ) {
        
        AF.upload(multipartFormData: { multipartFormData in
            
            do {
                
                multipartFormData.append(videoUrl.jpegData(compressionQuality: 0.5)!, withName: "picture" , fileName: "image.jpeg", mimeType: "image/jpeg")
                //  here you can see data bytes of selected video, this data object is upload to server by multipartFormData upload
            } catch  {
            }
        },to: Constant.host + "users/lot/postuler",
                  method: .post)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Success")
                    let jsonData = JSON(response.data!)
                    let lot = self.makeItem(jsonItem: jsonData["po"])
                    completed(true, lot)
                case let .failure(error):
                    completed(false, nil)
                    print(error)
                }
            }
    }
    
    
    func modifierLot(_id:String, description: String , localisation:String, price:String ,contact:String,  completed: @escaping (Bool,Any?) -> Void ) {
        AF.request(Constant.host + "users/lot/updt",
                   method: .post,
                   parameters: [
                    "_id":_id,
                    "description": description,
                    "localisation": localisation,
                    "price":price,
                    "contact":contact
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let lot = self.makeItem(jsonItem: jsonData["posts"])
                    
                    
                    print("************************hhhhhh****************")
                    print(_id)
                    UserDefaults.standard.string(forKey: "_id")

                    completed(true,lot)
                case let .failure(error):
                    debugPrint(error)
                    completed(false,nil)
                }
            }
    }
    
  
    
    func Searchlot(text:String,completed: @escaping (Bool,[Lot]?) -> Void){
            AF.request(HOST_URL + "/users/lot/search/",
                method: .post,parameters: ["localisation":text],encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData {
                    response in
                    switch response.result{
                    case .success :
                        
                        let jsonData = JSON(response.data!)

                                         
                                         var users : [Lot]? = []
                                         for singleJsonItem in jsonData["lots"] {
                                           // print(self.makeItem(jsonItem: singleJsonItem.1).localisation)
                                             users!.append(self.makeItem(jsonItem: singleJsonItem.1))
                                             print(self.makeItem(jsonItem: singleJsonItem.1))
                                         }
                                                                  completed(true,users)
                        
                    case let .failure(error) :
                       debugPrint(error)
                       completed(false, nil)
                  
                    }
                }
                
            
        }
    
    func supprimerLot(_id: String?, completed: @escaping (Bool) -> Void ) {
          AF.request(HOST_URL + "users/lot/delete",
                     method: .delete,
                     parameters: [
                      "_id": _id!
                     ])
              .validate(statusCode: 200..<300)
              .validate(contentType: ["application/json"])
              .responseData { response in
                  switch response.result {
                  case .success:
                      completed(true)
                  case let .failure(error):
                      debugPrint(error)
                      completed(false)
                  }
              }
      }
    
  
   /* func updateLot(lot:Lot , methode: HTTPMethod, completed: @escaping (Bool) -> Void) {
         AF.request(Constant.host + "users/lot/updt",
                     method: .put,
                    parameters: [
                    "_id" : lot._id! ,
                     "localisation": lot.localisation!,
                     "description": lot.description!,
                     "price": lot.price!,
                     "contact": lot.contact!
                    ])
             .response { response in
                 print(response)
             }
     }*/
    
    
    

}
