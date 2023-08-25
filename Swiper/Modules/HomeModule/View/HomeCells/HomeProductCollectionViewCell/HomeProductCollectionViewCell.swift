//
//  HomeProductCollectionViewCell.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import UIKit
import SDWebImage

class HomeProductCollectionViewCell: UICollectionViewCell {

//    MARK: - IBOutlets
    @IBOutlet weak var internalView: UIView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
//    MARK: - Variables
    var productNameStr:String = StringConstants.emptyString
    var productTypeStr:String = StringConstants.emptyString
    var priceStr:String = StringConstants.emptyString
    var taxStr:String = StringConstants.emptyString
    var totalPriceStr:String = StringConstants.emptyString
    
//    MARK: - View Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
//    MARK: - UIFunction
    private func setupUI(){
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 10
        internalView.applyLiftedShadowEffectToView(cornerRadius: 10,opacity: 0.3)
    }
    
//    MARK: - Extra functions
    private func roundToTwoDecimals(number: Double) -> Double {
        return (number * 100).rounded() / 100
    }
    
    private func getTotalPrice(price: Double, tax: Double) -> Double {
        let taxAmount = price * (tax / 100)
        let total = price + taxAmount
        return roundToTwoDecimals(number: total)
    }
    
//    MARK: - Seting up cell
    func setupCell(product:ProductListElementModel){
        let price = roundToTwoDecimals(number: product.price)
        let totalPrice = getTotalPrice(price: product.price, tax: product.tax)
        
        productNameLabel.text = product.productName
        productTypeLabel.text = product.productType
        priceLabel.text = "\(StringConstants.rupeeSymbol) \(price)"
        taxLabel.text = "Tax: \(product.tax)%"
        totalPriceLabel.text = "\(StringConstants.rupeeSymbol) \(totalPrice)"
        
        productImageView.sd_setImage(with: URL(string: product.image),placeholderImage: UIImage(named: StringConstants.noImage),context: nil)
    }
}

// MARK: - End
