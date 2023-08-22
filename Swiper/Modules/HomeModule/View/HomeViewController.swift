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
        adProductButton.applyLiftedShadowEffectToView(cornerRadius: 10)
    }
    
    private func setupCollectionView(){
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        productListCollectionView.register(UINib(nibName: CollectionViewCells.homeProductCollectionViewCell.cell,bundle: nil),forCellWithReuseIdentifier: CollectionViewCells.homeProductCollectionViewCell.cell)
        productListCollectionView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 100, right: 0)
    }
    
    private func callHomeApi(){
        activityIndicator = uiHelper.showActivityIndicator(in: self.view)
        self.homeViewModel.getProductListing { err in
            if err == nil {
                DispatchQueue.main.async {
                    self.productListCollectionView.reloadData()
                    self.totalProductsCountLabel.text = "\(self.homeViewModel.getCount()) \(StringConstants.productsFound.constant)"
                    self.uiHelper.hideActivityIndicator(self.activityIndicator)
                }
            }else{
                print("Error Occured")
                self.uiHelper.hideActivityIndicator(self.activityIndicator)
            }
        }
    }
}

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = productListCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCells.homeProductCollectionViewCell.cell, for: indexPath) as? HomeProductCollectionViewCell else {return UICollectionViewCell()}
        if let product = homeViewModel.getProduct(index: indexPath.row){
            cell.setupCell(product: product)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AddProductViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
