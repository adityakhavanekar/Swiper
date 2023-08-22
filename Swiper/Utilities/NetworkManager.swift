//
//  NetworkManager.swift
//  Swiper
//
//  Created by Neosoft on 22/08/23.
//

import Foundation

class NetworkManager {
    let session = URLSession.shared
    static let shared = NetworkManager()
    private init() {}
    
    func getRequest(url: URL,
                    params: [String: Any]? = nil,
                    headers: [String: String]? = nil,
                    completion: @escaping (Data?, Error?) -> Void) {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = params?.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }

        if let url = components?.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let session = URLSession.shared

            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, nil)
                    return
                }

                if response.statusCode == 200 {
                    completion(data, nil)
                } else {
                    let statusError = NSError(domain: "HTTP", code: response.statusCode, userInfo: nil)
                    completion(nil, statusError)
                }
            }
            task.resume()
        }
    }
}
