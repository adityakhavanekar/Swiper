//
//  AddProductViewController.swift
//  Swiper
//
//  Created by Neosoft on 23/08/23.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var taxTxtField: UITextField!
    @IBOutlet weak var priceTxtField: UITextField!
    @IBOutlet weak var productTypeTxtField: UITextField!
    @IBOutlet weak var productNameTxtField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var internalView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var isExpand:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        internalView.layer.cornerRadius = 10
        internalView.applyLiftedShadowEffectToView(cornerRadius: 10)
        cancelButton.layer.cornerRadius = 10
        cancelButton.clipsToBounds = true
        cancelButton.applyLiftedShadowEffectToView(cornerRadius: 10)
        addButton.layer.cornerRadius = 10
        addButton.clipsToBounds = true
        addButton.applyLiftedShadowEffectToView(cornerRadius: 10)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        productNameTxtField.delegate = self
        productTypeTxtField.delegate = self
        priceTxtField.delegate = self
        taxTxtField.delegate = self
    }
    
    @objc func keyboardAppear(){
        if isExpand == false{
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 200)
            isExpand = true
        }
    }
    
    @objc func keyboardDisappear(){
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 200)
        isExpand = false
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AddProductViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
   }
}
