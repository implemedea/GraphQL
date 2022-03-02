//
//  AddUserViewController.swift
//  GraphQL-mutation
//
//  Created by Implemedea on 17/02/22.
//

import UIKit
import Apollo

protocol ProtocolRefreshPage: AnyObject {
    func refreshUserList()
}

class AddUserViewController: BaseViewController {
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    
    weak var delegate: ProtocolRefreshPage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func okAction() {
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func addUser(_ sender: Any) {
        guard let firstName = firstNameTxtField.text, !firstName.isEmpty, let lastName = lastNameTxtField.text, !lastName.isEmpty, let email = emailTxtField.text, !email.isEmpty else {
            showAlert(message: "Please fill all fields")
            return
        }
        addUser(firstName: firstName, lastName: lastName, email: email)
    }

    func addUser(firstName: String, lastName: String, email: String) {
        showActivityIndicator()
        Network.shared.apollo.perform(mutation: AddUserMutation(emailid: email, firstname: firstName, lastname: lastName)) { (result) in
            
            self.hideActivityIndicator()
            switch result {
            case .success(let graphQLResult):
                if graphQLResult.data != nil {
                    print(graphQLResult.data?.insertUsersOne?.lastname ?? "")
                    DispatchQueue.main.async {
                        self.delegate?.refreshUserList()
                        self.showAlert(message: "User added successfully")
                    }
                }
            case .failure(let error):
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
}
