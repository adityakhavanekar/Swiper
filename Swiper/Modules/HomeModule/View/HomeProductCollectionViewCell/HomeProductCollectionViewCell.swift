//
//  HomeProductCollectionViewCell.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import UIKit
import SDWebImage

class HomeProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var internalView: UIView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    var productNameStr:String = ""
    var productTypeStr:String = ""
    var priceStr:String = ""
    var taxStr:String = ""
    var totalPriceStr:String = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI(){
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 10
        internalView.applyLiftedShadowEffectToView(cornerRadius: 10)
    }
    
    private func roundToTwoDecimals(number: Double) -> Double {
        return (number * 100).rounded() / 100
    }
    
    private func getTotalPrice(price:Double,tax:Double)->Double{
        let total = price+tax
        return roundToTwoDecimals(number: total)
    }
    
    func setupCell(product:ProductListElementModel){
        let price = roundToTwoDecimals(number: product.price)
        let totalPrice = getTotalPrice(price: product.price, tax: product.tax)
        
        productNameLabel.text = product.productName
        productTypeLabel.text = product.productType
        priceLabel.text = "₹\(price)"
        taxLabel.text = "₹ \(product.tax)"
        totalPriceLabel.text = "₹ \(totalPrice)"
        
        productImageView.sd_setImage(with: URL(string: product.image), placeholderImage: UIImage(named: ImageConstants.noImage.image), context: nil)
    }
}
