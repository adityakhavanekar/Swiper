//
//  AddProductViewController.swift
//  Swiper
//
//  Created by Neosoft on 23/08/23.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var pickImageButton: UIButton!
    @IBOutlet weak var taxTxtField: UITextField!
    @IBOutlet weak var priceTxtField: UITextField!
    @IBOutlet weak var productTypeTxtField: UITextField!
    @IBOutlet weak var productNameTxtField: UITextField!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var internalView: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var uiHelper:UIHelper = UIHelper()
    
    var isExpand:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        internalView.clipsToBounds = true
        cancelButton.clipsToBounds = true
        addButton.clipsToBounds = true
        productImageView.clipsToBounds = true
        
        addButton.layer.cornerRadius = 5
        cancelButton.layer.cornerRadius = 5
        productImageView.layer.cornerRadius = 10
        internalView.layer.cornerRadius = 10
        pickImageButton.layer.cornerRadius = 10
        
        internalView.applyLiftedShadowEffectToView(cornerRadius: 10,opacity: 0.3)
        cancelButton.applyLiftedShadowEffectToView(cornerRadius: 5,opacity: 0.1)
        addButton.applyLiftedShadowEffectToView(cornerRadius: 5,opacity: 0.1)
        
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
    
    private func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true){
            self.uiHelper.hideActivityIndicator(self.activityIndicator)
        }
    }
    
    private func showImageSourceAlert() {
        self.activityIndicator = self.uiHelper.showActivityIndicator(in: self.view)
        let libAction = uiHelper.createAlertActions(title: "Photo Library", style: .default) {
            self.openImagePicker(sourceType: .photoLibrary)
        }
        let camAction = uiHelper.createAlertActions(title: "Camera", style: .default) {
            self.openImagePicker(sourceType: .camera)
        }
        let canAction = uiHelper.createAlertActions(title: "Cancel", style: .cancel) {
            self.uiHelper.hideActivityIndicator(self.activityIndicator)
        }
        let alert = uiHelper.createActionSheet(title: "Choose image source", actions: [libAction,camAction,canAction])
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func pickImageButtonClicked(_ sender: UIButton) {
        showImageSourceAlert()
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

extension AddProductViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
}
