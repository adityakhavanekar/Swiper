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
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var internalView: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var isExpand:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        internalView.clipsToBounds = true
        cancelButton.clipsToBounds = true
        addButton.clipsToBounds = true
        
        addButton.layer.cornerRadius = 5
        cancelButton.layer.cornerRadius = 5
        internalView.layer.cornerRadius = 10
        
        internalView.applyLiftedShadowEffectToView(cornerRadius: 5)
        cancelButton.applyLiftedShadowEffectToView(cornerRadius: 5)
        addButton.applyLiftedShadowEffectToView(cornerRadius: 10)
        
        setTextFieldDelegates(textFields: [productNameTxtField,productTypeTxtField,priceTxtField,taxTxtField])
        addScrollingObeservers()
    }
    
    private func addScrollingObeservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardAppear(){
        print(scrollView.contentSize.height)
        if isExpand == false{
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.internalView.frame.height + 300)
            isExpand = true
        }
    }
    
    @objc func keyboardDisappear(){
        print(scrollView.contentSize.height)
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.internalView.frame.height + 50)
        isExpand = false
    }
    
    private func setTextFieldDelegates(textFields:[UITextField]){
        for txtField in textFields{
            txtField.delegate = self
        }
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
