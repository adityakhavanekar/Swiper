//
//  UIFunctions.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import Foundation
import UIKit

class UIHelper{
    
    func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
    }
    
    func hideActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    func createActionSheet(title:String,actions:[UIAlertAction])->UIAlertController{
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        for action in actions {
            alert.addAction(action)
        }
        return alert
    }
    
    func createAlertActions(title:String, style:UIAlertAction.Style, completion: @escaping ()->()) -> UIAlertAction{
        let action = UIAlertAction(title: title, style: style){_ in
            completion()
        }
        return action
    }
    
    func createAlertPopUp(title:String,message:String)->UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return alert
    }
}
