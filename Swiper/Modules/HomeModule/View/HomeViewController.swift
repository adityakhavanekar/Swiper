//
//  HomeViewController.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    
//    MARK: - IBOutlets
    @IBOutlet weak var adProductButton: UIButton!
    @IBOutlet weak var totalProductsCountLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
//    MARK: - Variables
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var uiHelper:UIHelper = UIHelper()
    var homeViewModel:HomeViewModel = HomeViewModel()

//    MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        callHomeApi()
    }
    
//    MARK: - setting UI
    private func setupUI(){
        navigationController?.navigationBar.isHidden = true
        searchBar.searchTextField.textColor = .black
        adProductButton.layer.cornerRadius = 10
        adProductButton.applyLiftedShadowEffectToView(cornerRadius: 10, opacity: 0.3)
        setTapGesture()
    }
    
    private func setupCollectionView(){
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        productListCollectionView.register(UINib(nibName: StringConstants.homeProductCollectionViewCell,bundle: nil),forCellWithReuseIdentifier: StringConstants.homeProductCollectionViewCell)
        productListCollectionView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 100, right: 0)
    }
    
    private func setTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
//    MARK: - API Call
    private func callHomeApi(){
        activityIndicator = uiHelper.showActivityIndicator(in: self.view)
        self.homeViewModel.getProductListing { err in
            if err == nil {
                DispatchQueue.main.async {
                    self.gotDataSuccessfully()
                }
            }else{
                DispatchQueue.main.async {
                    self.errorGettingData()
                }
            }
        }
    }
    
    private func gotDataSuccessfully(){
        self.adProductButton.isEnabled = true
        self.productListCollectionView.reloadData()
        self.totalProductsCountLabel.text = "\(self.productListCollectionView.numberOfItems(inSection: 0)) \(StringConstants.productsFound)"
        self.uiHelper.hideActivityIndicator(self.activityIndicator)
    }
    private func errorGettingData(){
        print(StringConstants.errorOccured)
        self.adProductButton.isEnabled = false
        self.uiHelper.hideActivityIndicator(self.activityIndicator)
        let okAction = self.uiHelper.createAlertActions(title: StringConstants.ok, style: .default){}
        let reloadAction = self.uiHelper.createAlertActions(title: StringConstants.tryAgain, style: .default) {
            self.callHomeApi()
        }
        let alert = self.uiHelper.createAlertPopUp(title: StringConstants.error, message: StringConstants.someThingWentWrong)
        alert.addAction(okAction)
        alert.addAction(reloadAction)
        self.present(alert, animated: true)
    }
    
//    MARK: - IBActions
    @IBAction func addProductButtonClicked(_ sender: UIButton) {
        let vc = AddProductViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - CollectionView Methods
extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.getFilteredProductsCount() ?? homeViewModel.getAllProductsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = productListCollectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.homeProductCollectionViewCell, for: indexPath) as? HomeProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let product = homeViewModel.filteredProducts?[indexPath.row] ?? homeViewModel.getProduct(index: indexPath.row) {
            cell.setupCell(product: product)
        }
        
        return cell
    }
}

extension HomeViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = productListCollectionView.frame.width
        let height = productListCollectionView.frame.height/1.8
        return CGSize(width: width/2 - 5, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

//MARK: - Search Functionality
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            homeViewModel.filteredProducts = nil
        } else {
            homeViewModel.getFilteredProducts(name: searchText)
        }
        productListCollectionView.reloadData()
        totalProductsCountLabel.text = "\(productListCollectionView.numberOfItems(inSection: 0)) \(StringConstants.productsFound)"
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - End
