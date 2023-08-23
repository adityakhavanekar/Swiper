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
    
    var url: URL {
        guard let url = URL(string: baseUrl) else {
            preconditionFailure("The url used in \(APIEndpoints.self) is not valid")
        }
        return url.appendingPathComponent(self.rawValue)
    }
}

enum CollectionViewCells:String{
    
    case homeProductCollectionViewCell = "HomeProductCollectionViewCell"
    
    var cell: String {
        return self.rawValue
    }
}

enum ImageConstants:String{
    case noImage = "noImage"
    
    var image:String{
        return self.rawValue
    }
}

enum StringConstants:String{
    case productsFound = "Products found"
    case rupeeSymbol = "₹"
    
    var constant:String {
        return self.rawValue
    }
}

enum AlertTitles:String{
    case photoLibrary = "Photo Library"
    case camera = "Camera"
    case cancel = "Cancel"
    case imageSourceOption = "Choose Image Source"
    
    var title:String {
        return self.rawValue
    }
}
