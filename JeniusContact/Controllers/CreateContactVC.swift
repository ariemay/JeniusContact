//
//  CreateContactVC.swift
//  JeniusContact
//
//  Created by Arie May Wibowo on 16/04/21.
//

import UIKit

class CreateContactVC: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var photoUrl: UITextField!
    
    var apiCall = ApiServices()
    
    var delegate:MainProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
    }
    
    func dismissKeyboard() {
           let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:     self, action:    #selector(CreateContactVC.dismissKeyboardTouchOutside))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
        }
        
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
    
    @IBAction func createContact(_ sender: Any) {
        apiCall.addContact(firstName: self.firstName.text!, lastName: self.lastName.text!, age: Int(self.age.text ?? "0")!, photo: self.photoUrl.text!, completion: { [self]result in if result {
                            print("success")
            delegate?.refreshTV()
            self.dismiss(animated: true, completion: nil)
        }})
    }
    
    

}
