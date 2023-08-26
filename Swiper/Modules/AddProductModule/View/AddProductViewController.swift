//
//  AddProductViewController.swift
//  Swiper
//
//  Created by Neosoft on 23/08/23.
//

import UIKit
import Alamofire

class AddProductViewController: UIViewController {
    
//    MARK: - IBOutlets
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
    
//    MARK: - Variables
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var uiHelper:UIHelper = UIHelper()
    var addProductViewModel = AddProductViewModel()
    
    var isExpand:Bool = false
    var selectedImage:UIImage?
    
//    MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
//    MARK: - UIFunction
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
        setTapGesture()
    }
    
//    MARK: - Scrolling Observers
    private func addScrollingObeservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardAppear(){
        print(scrollView.contentSize.height)
        if isExpand == false{
            scrollView.contentSize = CGSize(width: view.frame.width, height: internalView.frame.height + 300)
            isExpand = true
        }
    }
    
    @objc func keyboardDisappear(){
        print(scrollView.contentSize.height)
        scrollView.contentSize = CGSize(width: view.frame.width, height: internalView.frame.height + 50)
        isExpand = false
    }
    
    private func setTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
//    MARK: - Setting Text Field delegates
    private func setTextFieldDelegates(textFields:[UITextField]){
        for txtField in textFields{
            txtField.delegate = self
        }
    }
    
//    MARK: - Setting up ImagePickerView
    private func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true){
            self.uiHelper.hideActivityIndicator(self.activityIndicator)
        }
    }
    
    private func showImageSourceAlert() {
        activityIndicator = uiHelper.showActivityIndicator(in: view)
        let libAction = uiHelper.createAlertActions(title: StringConstants.photoLibrary, style: .default) {
            self.openImagePicker(sourceType: .photoLibrary)
        }
        let camAction = uiHelper.createAlertActions(title: StringConstants.camera, style: .default) {
            self.openImagePicker(sourceType: .camera)
        }
        let canAction = uiHelper.createAlertActions(title: StringConstants.cancel, style: .cancel) {
            self.uiHelper.hideActivityIndicator(self.activityIndicator)
        }
        let alert = uiHelper.createActionSheet(title: StringConstants.imageSourceOption, actions: [libAction,camAction,canAction])
        present(alert, animated: true, completion: nil)
    }
    
    func areAllTextFieldsFilled(textFields: [UITextField]) -> Bool {
        for textField in textFields {
            guard let text = textField.text, !text.isEmpty else {
                return false
            }
        }
        return true
    }
//    MARK: - API Call
    private func callApiToAddProduct(){
        activityIndicator = uiHelper.showActivityIndicator(in: view)
        var file:FileData?
        guard let params = [
            StringConstants.productName:productNameTxtField.text,
            StringConstants.productType:productTypeTxtField.text,
            StringConstants.price:priceTxtField.text,
            StringConstants.tax:taxTxtField.text
        ] as? [String:String] else {return}
        
        if let imageData = selectedImage?.jpegData(compressionQuality: 8.0){
            file = FileData(
                data: imageData,
                parameter: StringConstants.files,
                fileName: "\(productNameTxtField.text ?? StringConstants.emptyString)\(StringConstants.jpgExtension)",
                mimeType: StringConstants.jpegImage
            )
        }
        addProductViewModel.addNewProduct(params: params, file: file, headers: nil) { msg,bool in
            self.gotDataFromApi(msg: msg, bool: bool)
        }
    }
    
    private func gotDataFromApi(msg:String,bool:Bool){
        uiHelper.hideActivityIndicator(activityIndicator)
        var alert = UIAlertController()
        switch bool{
        case true:
            alert = uiHelper.createAlertPopUp(title: msg, message: StringConstants.emptyString)
        case false:
            alert = uiHelper.createAlertPopUp(title: msg, message: StringConstants.someThingWentWrong)
        }
        let action = uiHelper.createAlertActions(title: StringConstants.ok, style: .default) {
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
//    MARK: - IBActions
    @IBAction func pickImageButtonClicked(_ sender: UIButton) {
        showImageSourceAlert()
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func adButtonClicked(_ sender: UIButton) {
        let filled = areAllTextFieldsFilled(textFields: [productNameTxtField,productTypeTxtField,priceTxtField,taxTxtField])
        if filled{
            callApiToAddProduct()
        }else{
            let alert = uiHelper.createAlertPopUp(title: StringConstants.error, message: StringConstants.requiredFields)
            let okAction = uiHelper.createAlertActions(title: StringConstants.ok, style: .default) {}
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
}

// MARK: - TextField Delegate methods
extension AddProductViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
   }
}

// MARK: - UIImage Picker View Methods
extension AddProductViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        productImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true)
    }
}

// MARK: - End
