//
//  ApiServices.swift
//  JeniusContact
//
//  Created by Arie May Wibowo on 16/04/21.
//

import Alamofire


class ApiServices {
    
    
    fileprivate var baseUrlHttp = "https://"
    var BaseUrl = Bundle.main.infoDictionary?["API_BASEURL"] as! String
    var Endpoint = Bundle.main.infoDictionary?["ENDPOINT"] as! String
    
    
    func getContacts(completion: @escaping ([Contact]) -> Void) {
        AF.request(baseUrlHttp  + BaseUrl + Endpoint, method: .get).validate().response() {
            (responseData) in
            print(type(of:responseData.data))
            switch responseData.result {
            case .success:
                if let value = responseData.data {
                    do {
                        let contacts: DataContact = try JSONDecoder().decode(DataContact.self, from: value)
                        completion(contacts.data)
                    } catch {
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteContact(id: String, completion: @escaping (Bool) -> Void) {
        AF.request(baseUrlHttp + BaseUrl + Endpoint + "/\(id)", method: .delete).validate().response() {
            response in
            switch response.result {
            case .success:
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
    
    func addContact(firstName: String, lastName: String, age: Int, photo: String, completion: @escaping (Bool) -> Void) {
        let newContact: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "age": age,
            "photo": photo
        ]
        print(newContact)
        AF.request(baseUrlHttp + BaseUrl + Endpoint, method: .post, parameters: newContact, encoding: JSONEncoding.default).response() {
            response in
            print("got respons \(String(describing: response.data))")
            switch response.result {
            case .success:
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
}
