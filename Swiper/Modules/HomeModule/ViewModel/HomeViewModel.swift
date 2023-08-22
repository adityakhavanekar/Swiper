//
//  HomeViewModel.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import Foundation

class HomeViewModel{
    
    let manager = NetworkManager.shared
    let url = APIEndpoints.getProductList.url
    var productList : [ProductListElementModel]?
    
    init(){}
    
    func getProductListing(completion:@escaping (Error?)->()){
        manager.getRequest(url: url) { resultData, resultError in
            if let data = resultData{
                do{
                    let jsonData = try JSONDecoder().decode([ProductListElementModel].self, from: data)
                    self.productList = jsonData
                    completion(nil)
                }catch{
                    print("Error")
                    completion(resultError)
                }
            }
        }
    }
    
    func getCount()->Int{
        return productList?.count ?? 0
    }
    
    func getProduct(index:Int)->ProductListElementModel?{
        return productList?[index]
    }
}
