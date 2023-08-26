//
//  HomeViewModel.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import Foundation

class HomeViewModel{
    
    private let manager = NetworkManager.shared
    private let url = APIEndpoints.getProductList.url
    private var productList : [ProductListElementModel]?
    private var filteredProducts : [ProductListElementModel]?
    
    init(){}
    
    func getProductListing(completion: @escaping (Error?) -> Void) {
        manager.getRequest(url: self.url, method: .get, parameters: nil, headers: nil) { data, error in
            if let error = error {
                completion(error)
            } else if let data = data {
                do {
                    let jsonData = try JSONDecoder().decode([ProductListElementModel].self, from: data)
                    self.productList = jsonData
                    completion(nil)
                } catch {
                    completion(error)
                }
            }
        }
    }
    
    func getAllProductsCount()->Int{
        return productList?.count ?? 0
    }
    
    func getProductAtIndex(index:Int)->ProductListElementModel?{
        return productList?[index]
    }
    
    func getFilteredProducts(name: String) {
        guard !name.isEmpty else {
            return
        }
        filteredProducts = productList?.filter { product in
            product.productName.lowercased().contains(name.lowercased())
        }
    }
    
    func getFilteredProductsCount()->Int?{
        return filteredProducts?.count
    }
    
    func getFilteredProductAtIndex(index:Int)->ProductListElementModel?{
        return filteredProducts?[index]
    }
    
    func clearFilteredProducts(){
        filteredProducts = nil
    }
}
