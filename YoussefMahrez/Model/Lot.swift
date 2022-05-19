//
//  Lot.swift
//  YoussefMahrez
//
//  Created by Apple Esprit on 26/4/2022.
//

import Foundation

struct Lot {
    internal init(_id: String? = nil, localisation: String? = nil, description: String? = nil, price: String? = nil, contact:  String? = nil , picture: String? = nil ) {
        self._id = _id
        self.localisation = localisation
        self.description = description
        self.price = price
        self.contact = contact
        self.picture = picture
        
    }
    var _id : String?
    var localisation : String?
    var description : String?
    var price  : String?
    var contact  : String?
    var picture : String?
}
