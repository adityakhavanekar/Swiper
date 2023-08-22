//
//  ProductListModel.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import Foundation

struct ProductListElementModel: Codable {
    let image: String
    let price: Double
    let productName, productType: String
    let tax: Double

    enum CodingKeys: String, CodingKey {
        case image, price
        case productName = "product_name"
        case productType = "product_type"
        case tax
    }
}
