//
//  Contact.swift
//  JeniusContact
//
//  Created by Arie May Wibowo on 16/04/21.
//

import UIKit

struct Contact: Decodable {
    var id: String
    var firstName: String
    var lastName: String
    var age: Int
    var photo: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case age = "age"
        case photo = "photo"
    }
}

struct DataContact: Decodable {
    let message: String
    let data: [Contact]
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}
