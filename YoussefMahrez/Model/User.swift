//
//  User.swift
//  YoussefMahrez
//
//  Created by iMac on 23/4/2022.
//

import Foundation

struct Utilisateur {
    internal init(_id: String? = nil, name: String? = nil, email: String? = nil, password: String? = nil, picture: String? = nil ) {
        self._id = _id
        self.name = name
        self.email = email
        self.password = password
        self.picture = picture
        
    }
    var _id : String?
    var name : String?
    var email : String?
    var password  : String?
    var picture : String?
}
