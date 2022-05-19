//
//  UserViewModel.swift
//  YoussefMahrez
//
//  Created by iMac on 23/4/2022.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

public class UserViewModel: ObservableObject{
    
    static let sharedInstance = UserViewModel()

    func inscription(utilisateur: Utilisateur, completed: @escaping (Bool) -> Void) {
            AF.request(HOST_URL + "/users/register",
                       method: .post,
                       parameters: [
                      
                        "email": utilisateur.email!,
                        "password": utilisateur.password!,
                        "name": utilisateur.name!,
                 
                       ])
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        print("Validation Successful")
                        print(utilisateur.email!)
                        completed(true)
                    case let .failure(error):
                        print(error)
                        completed(false)
                    }
                }
        }
    
    func login(email: String, password: String, completed: @escaping (Bool, Any?) -> Void) {
        AF.request(Constant.host + "users/login",
                       method: .post,
                       parameters: ["email": email, "password": password])
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                   


                    switch response.result {
                    case .success:
                        let jsonData = JSON(response.data!)
                        let utilisateur = self.makeItem(jsonItem: jsonData["use"])
                        let message = self.makeItemMessage(jsonItem: jsonData["message"])
//                        UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
                        UserDefaults.standard.setValue(utilisateur._id, forKey: "_id")
                        print("heyyyy")
                        print(utilisateur)

                        completed(true, utilisateur)
                    case let .failure(error):
                        debugPrint(error)
                        completed(false, nil)
                        
                    }
                        
                        //                        if message.message != "" {
//                            completed(true, message.message)
//                        }else{
//                            completed(true, utilisateur)
//                        }
//
//                    case let .failure(error):
//                        debugPrint(error)
//                        print("jjjjjjj")
//                        completed(false, nil)
//                    }
                }
        }
    
    func makeItem(jsonItem: JSON) -> Utilisateur {
            
//            var BParray : [String] = []
//            for singleJsonItem in jsonItem["blockedPosts"]   {
//                BParray.append(singleJsonItem.1.stringValue)
//            }
//
//            var BUarray : [String] = []
//            for singleJsonItem in  jsonItem["blockedUsers"]  {
//                BUarray.append(singleJsonItem.1.stringValue)
//            }
            
            return Utilisateur(
                _id: jsonItem["_id"].stringValue,
                name: jsonItem["name"].stringValue,
                email: jsonItem["email"].stringValue,
                password: jsonItem["password"].stringValue,
                picture: jsonItem["picture"].stringValue
            )
        }
    
    func makeItemMessage(jsonItem: JSON) -> Message {
            
            var BParray : [String] = []
            for singleJsonItem in jsonItem["blockedPosts"]   {
                BParray.append(singleJsonItem.1.stringValue)
            }
            
            var BUarray : [String] = []
            for singleJsonItem in  jsonItem["blockedUsers"]  {
                BUarray.append(singleJsonItem.1.stringValue)
            }
            
            return Message(
                message: jsonItem["message"].stringValue
            )
        }
    
//
//    func recupererUtilisateur(id: String, completed: @escaping (Bool, Utilisateur?) -> Void ) {
//            print("Looking for user --------------------")
//            AF.request(HOST_URL + "users/getUser",
//                       method: .post,
//                       parameters: ["id": id],
//                       encoding: JSONEncoding.default)
//                .validate(statusCode: 200..<300)
//                .validate(contentType: ["application/json"])
//                .response { response in
//                    switch response.result {
//                    case .success:
//                        let jsonData = JSON(response.data!)
//                        let utilisateur = self.makeItem(jsonItem: jsonData["utilisateur"])
//                        print("Found utilisateur --------------------")
//                        print(utilisateur)
//                        print("-------------------------------")
//                        completed(true, utilisateur)
//                    case let .failure(error):
//                        debugPrint(error)
//                        completed(false, nil)
//                    }
//                }
//        }
    
    
    func recupererUtilisateur(_id: String, completed: @escaping (Bool, Utilisateur?) -> Void ) {
                print("Looking for user --------------------")
        AF.request(Constant.host + "users/show",
                   method: .post,
                   parameters: ["_id": _id],
                   encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                print(response)
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    print(jsonData)
                    let user = self.makeItem(jsonItem: jsonData["response"])
                    print("Found utilisateur --------------------")
                    print(user)
                    print("-------------------------------")
                    print(user._id)

                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    print("-------5555----55")
                    completed(false, nil)
                }
            }
    }
    
    
    
    //=========================================
    func ChangeProfilePic(id: String, uiImage: UIImage, completed: @escaping (Bool) -> Void){
                    AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "pictureId" , fileName: "image.jpeg", mimeType: "image/jpeg")
       
                    },to: Constant.host + "users/changeprofile/pic/"+id,
                      method: .post)
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success:
                        print("Success")
                        completed(true)
                    case let .failure(error):
                        completed(false)
                        print(error)
                    }
                }
        }
    //=========================================
    
    
    
//    func changerPhotoDeProfil(_id: String, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
//
//        AF.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
//
//            for (key, value) in
//                    [
//                        "_id": _id,
//                    ]
//            {
//                multipartFormData.append((value.data(using: .utf8))!, withName: key)
//            }
//
//        },to: Constant.host + "users/update/picture/"+UserDefaults.standard.string(forKey: "_id")!,
//                  method: .put)
//            .validate(statusCode: 200..<600)
//            .validate(contentType: ["application/json"])
//            .responseData { response in
//                switch response.result {
//                case .success:
//                    print("Success")
//                    completed(true)
//                case let .failure(error):
//                    completed(false)
//                    print(error)
//                }
//            }
//    }
    func motDePasseOublie(email: String, codeDeReinit: String, completed: @escaping (Bool) -> Void) {
        AF.request(Constant.host + "users/mdp/oublier/",
                   method: .post,
                   parameters: ["email": email, "codeDeReinit": codeDeReinit])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func changerMotDePasse(email: String, nouveauMotDePasse: String, completed: @escaping (Bool) -> Void) {
        AF.request(Constant.host + "users/change/mdp/",
                   method: .post,
                   parameters: ["email": email,"nouveauMotDePasse": nouveauMotDePasse])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func updateProfile(utilisateur: Utilisateur, methode: HTTPMethod, completed: @escaping (Bool) -> Void) {
         print(utilisateur)
         AF.request( Constant.host + "users/update/",
                     method: .put,
                    parameters: [
                     "_id" : utilisateur._id!,
                     //"pseudo": utilisateur.pseudo!,
                     "email": utilisateur.email!,
                     //"mdp": utilisateur.mdp!,
                     "name": utilisateur.name!,
                     //"score": utilisateur.score!,
                     //"bio": utilisateur.bio!
                    ])
             .response { response in
                 print(response)
             }
     }
    
    
    }
    
    
    




