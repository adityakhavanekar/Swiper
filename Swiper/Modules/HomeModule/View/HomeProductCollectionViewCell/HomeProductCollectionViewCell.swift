//
//  HomeProductCollectionViewCell.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import UIKit

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
}
