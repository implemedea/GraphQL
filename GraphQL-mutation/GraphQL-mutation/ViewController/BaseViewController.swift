//
//  BaseViewController.swift
//  GraphQL-mutation
//
//  Created by Implemedea on 17/02/22.
//

import UIKit

class BaseViewController: UIViewController {
    var activityView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] action in
            switch action.style{
            case .default:
                okAction()
                
            case .cancel:
                cancelAction()
                
            case .destructive:
                print("destructive")
            @unknown default:
                print("error")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
    func okAction() {
        
    }
    
    func cancelAction() {
        
    }
}
