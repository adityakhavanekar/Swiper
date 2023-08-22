//
//  HomeViewController.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    var homeViewModel:HomeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        callHomeApi()
    }
    
    private func setupUI(){
        navigationController?.navigationBar.isHidden = true
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        productListCollectionView.register(
            UINib(nibName: CollectionViewCells.homeProductCollectionViewCell.cell,
                  bundle: nil),
            forCellWithReuseIdentifier: CollectionViewCells.homeProductCollectionViewCell.cell)
    }
    
    private func callHomeApi(){
        homeViewModel.getProductListing { err in
            if err == nil {
                DispatchQueue.main.async {
                    self.productListCollectionView.reloadData()
                }
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
        let product = homeViewModel.getProduct(index: indexPath.row)
        if let imgUrl = product?.image{
            cell.productImageView.sd_setImage(with: URL(string: imgUrl))
        }
        cell.productNameLabel.text = product?.productName
        return cell
    }
}

extension HomeViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = productListCollectionView.frame.width
        let height = productListCollectionView.frame.height/1.75
        return CGSize(width: width/2 - 5, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
