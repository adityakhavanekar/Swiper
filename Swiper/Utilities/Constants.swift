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
