//
//  Constants.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import Foundation

enum APIEndpoints: String {
    private var baseUrl:String { return "https://app.getswipe.in/api/public"}

    case getProductList = "/get"
    case addProduct = "/add"
    
    var url: URL {
        guard let url = URL(string: baseUrl) else {
            preconditionFailure("The url used in \(APIEndpoints.self) is not valid")
        }
        return url.appendingPathComponent(self.rawValue)
    }
}

class AddProductParamsConstants{
    static var productName = "product_name"
    static var productType = "product_type"
    static var price = "price"
    static var tax = "tax"
    static var files = "files[]"
}

class AlertTitlesConstants{
    static var photoLibrary = "Photo Library"
    static var camera = "Camera"
    static var cancel = "Cancel"
    static var imageSourceOption = "Choose Image Source"
}

class StringConstants{
    static var productsFound = "Products found"
    static var rupeeSymbol = "₹"
}

class CollectionViewCellConstants{
    static var homeProductCollectionViewCell = "HomeProductCollectionViewCell"
}

class ImageConstants{
    static var noImage = "noImage"
}

class MimeTypeConstants{
    static var jpegImage = "image/jpeg"
}
