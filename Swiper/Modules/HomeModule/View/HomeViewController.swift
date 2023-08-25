//
//  HomeViewController.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var adProductButton: UIButton!
    @IBOutlet weak var totalProductsCountLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var uiHelper:UIHelper = UIHelper()
    var homeViewModel:HomeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        callHomeApi()
    }
    
    private func setupUI(){
        navigationController?.navigationBar.isHidden = true
        searchBar.searchTextField.textColor = .black
        adProductButton.layer.cornerRadius = 10
        adProductButton.applyLiftedShadowEffectToView(cornerRadius: 10, opacity: 0.3)
    }
    
    private func setupCollectionView(){
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        productListCollectionView.register(UINib(nibName: CollectionViewCellConstants.homeProductCollectionViewCell,bundle: nil),forCellWithReuseIdentifier: CollectionViewCellConstants.homeProductCollectionViewCell)
        productListCollectionView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 100, right: 0)
    }
    
    private func callHomeApi(){
        activityIndicator = uiHelper.showActivityIndicator(in: self.view)
        self.homeViewModel.getProductListing { err in
            if err == nil {
                DispatchQueue.main.async {
                    self.productListCollectionView.reloadData()
                    self.totalProductsCountLabel.text = "\(self.homeViewModel.getCount()) \(StringConstants.productsFound)"
                    self.uiHelper.hideActivityIndicator(self.activityIndicator)
                }
            }else{
                print("Error Occured")
                self.uiHelper.hideActivityIndicator(self.activityIndicator)
            }
        }
    }
    
    @IBAction func addProductButtonClicked(_ sender: UIButton) {
        let vc = AddProductViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - CollectionView Methods
extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.getFilteredProductsCount() ?? homeViewModel.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = productListCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellConstants.homeProductCollectionViewCell, for: indexPath) as? HomeProductCollectionViewCell else {
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
