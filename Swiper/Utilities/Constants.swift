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

class StringConstants{
//    Add Product Params
    static var productName = "product_name"
    static var productType = "product_type"
    static var price = "price"
    static var tax = "tax"
    static var files = "files[]"
    
//    Alert Titles
    static var photoLibrary = "Photo Library"
    static var camera = "Camera"
    static var cancel = "Cancel"
    static var imageSourceOption = "Choose Image Source"
    
//    Text Statics
    static var productsFound = "Products found"
    static var rupeeSymbol = "₹"
    static var ok = "Ok"
    static var error = "Error"
    static var someThingWentWrong = "Something went wrong"
    static var errorOccured = "Error Occured"
    static var emptyString = ""
    static var jpgExtension = ".jpg"
    static var tryAgain = "Try again"
    
//    CollectionView Cells
    static var homeProductCollectionViewCell = "HomeProductCollectionViewCell"
    
//    Image Constants
    static var noImage = "noImage"
    
//    MimeTypes
    static var jpegImage = "image/jpeg"
}
