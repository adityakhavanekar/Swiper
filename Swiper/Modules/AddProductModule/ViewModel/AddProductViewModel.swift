//
//  AddProductViewModel.swift
//  Swiper
//
//  Created by Neosoft on 24/08/23.
//

import Foundation

class AddProductViewModel{
    
    private let manager = NetworkManager.shared
    private let url = APIEndpoints.addProduct.url
    
    
    func addNewProduct(params:[String:String],file:FileData?,headers:[String:String]?,completion: @escaping (String,Bool)->()){
        manager.postMultiPartFormData(url:self.url,parameters:params, data: file, headers: headers) { responseData, responseError in
            if let data = responseData{
                do{
                    let jsonData = try JSONDecoder().decode(ProductAddedResponse.self, from: data)
                    completion(jsonData.message ?? "",true)
                }catch{
                    completion("Error Occured!",false)
                }
            }else if responseError != nil{
                completion("Error Occured!",false)
            }
        }
    }
}
