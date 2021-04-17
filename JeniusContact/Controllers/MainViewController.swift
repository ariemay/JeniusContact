//
//  ViewController.swift
//  JeniusContact
//
//  Created by Arie May Wibowo on 16/04/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var apiCall = ApiServices()
    var data = [Contact]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        apiCall.getContacts(completion: {
            data in
            self.data = data
        })
    }
    
    func deleteConfirmation(id: String) -> Void {
        let alert = UIAlertController(title: "Do you want to delete this contact?", message: "Think twice.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactTV", for: indexPath) as? ContactCell
        cell?.firstNameLbl.text = data[indexPath.row].firstName
        cell?.lastNameLbl.text = data[indexPath.row].lastName
        cell?.ageLbl.text = String(data[indexPath.row].age)
        print(data[indexPath.row].photo)
        if let url = URL( string:data[indexPath.row].photo)
        {
            DispatchQueue.global().async {
              if let image = try? Data( contentsOf:url)
              {
                DispatchQueue.main.async {
                  cell?.imageContact.image = UIImage( data:image)
                }
              }
           }
        }

        return cell!
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive,
                                        title: "Favourite") { [self] (action, view, completionHandler) in
            deleteConfirmation(id: data[indexPath.row].id)
            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }

    
}
