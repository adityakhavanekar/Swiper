//
//  NetworkManager.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import Foundation
import Alamofire

struct FileData{
    let data:Data
    let parameter:String
    let fileName:String
    let mimeType:String
}

class NetworkManager {
    let session = URLSession.shared
    static let shared = NetworkManager()
    private init() {}
    
    func getRequest(url:URL,method:HTTPMethod,parameters:[String:Any]?,headers:[String:Any]?,completion: @escaping (Data?,Error?)->()){
        var httpHeaders: HTTPHeaders?
        if let headersDict = headers as? [String: String] {
            httpHeaders = HTTPHeaders(headersDict)
        }
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: httpHeaders).response{ res in
            switch res.result{
            case .success(let data):
                completion(data,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
    func postMultiPartFormData(url: URL, parameters: [String: String], data: FileData?, headers: [String: String]?, completion: @escaping (Data?, Error?) -> ()) {
        let boundary = UUID().uuidString
        var headersWithBoundary: HTTPHeaders = ["Content-Type": "multipart/form-data; boundary=\(boundary)"]
        if let headers = headers {
            for (key, value) in headers {
                headersWithBoundary[key] = value
            }
        }
        AF.upload(multipartFormData: { multipartFormData in
            for param in parameters {
                multipartFormData.append(param.value.data(using: .utf8)!, withName: param.key)
            }
            if let data = data {
                multipartFormData.append(data.data, withName: data.parameter, fileName: data.fileName, mimeType: data.mimeType)
            }
        }, to: url, usingThreshold: 100, method: .post, headers: headersWithBoundary).response { res in
            switch res.result {
            case .success(_):
                completion(res.data,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
}
