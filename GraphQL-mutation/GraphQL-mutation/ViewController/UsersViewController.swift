//
//  ViewController.swift
//  GraphQL-mutation
//
//  Created by Implemedea on 15/02/22.
//

import UIKit
import Apollo

class UsersViewController: BaseViewController {
    
    @IBOutlet weak var usersTableview: UITableView!
    var users: [GetUserListQuery.Data.User] = []
    @IBOutlet weak var addUserBarButton: UIBarButtonItem!
    let refreshControl = UIRefreshControl()
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        usersTableview.addSubview(refreshControl)
        
        getuser()
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        getuser()
    }
    
    @IBAction func navigateToAddUser(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let addUserViewController : AddUserViewController = storyboard.instantiateViewController(withIdentifier: "AddUserViewController") as? AddUserViewController {
            addUserViewController.delegate = self
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(addUserViewController, animated: true)
            }
        }
    }
    
}

extension UsersViewController: ProtocolRefreshPage {
    func getuser() {
        showActivityIndicator()
        let query = GetUserListQuery()
        Network.shared.apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheCompletely) { result in
            self.hideActivityIndicator()
            self.refreshControl.endRefreshing()
            switch result {
            case .success(let graphQLResult):
                if let data = graphQLResult.data {
                    print(data)
                    self.users = data.users
                    self.usersTableview.reloadData()
                } else if let errors = graphQLResult.errors {
                    // GraphQL errors
                    print(errors)
                  }
            case .failure(let error):
                // Network or response format errors
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func refreshUserList() {
        getuser()
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath)
        guard let cell = cell as? UserTableViewCell else {
            return UITableViewCell()
        }
        cell.firstName.text = String(indexPath.row + 1) + ". " + users[indexPath.row].firstname
        cell.emailId.text = users[indexPath.row].emailid

        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.setNeedsLayout()
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
