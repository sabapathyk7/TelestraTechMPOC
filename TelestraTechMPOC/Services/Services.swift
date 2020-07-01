//
//  Services.swift
//  TelestraTechMPOC
//
//  Created by kanagasabapathy on 29/06/20.
//  Copyright © 2020 kanagasabapathy. All rights reserved.
//

import Foundation


final class Services {
    
    //
    // MARK: - Constants
    //
    let urlSession = URLSession(configuration: .default)
    
    //
    // MARK: - Variables and properties
    //
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    
    private let baseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    static public let shared: Services = Services()
    
    typealias FactResults = (FactData?) -> Void
    
    //
    // MARK: Get Fact Results from the given API.
    //
    func getFactResults( completionHandler: @escaping FactResults) {
        
        
        let urlString = baseURL
        guard let url = URL(string: urlString) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        //        dataTask?.cancel()
        dataTask = urlSession.dataTask(with: urlRequest.url!) { [weak self] data, response, error in
            var receivedFactData: FactData?
            
            defer {
                self?.dataTask = nil
                completionHandler(receivedFactData)
            }
            
            //
            // Differentiate the responses and errors.
            //
            if let error = error {
                
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                return
                
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
                guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                    return
                }
                do {
                    
                    let decoder = JSONDecoder()
                    //
                    // Decoder to decode the data into json format. Look at the model class to get more info.
                    //
                    let model = try decoder.decode(FactData.self, from: modifiedDataInUTF8Format)
                    receivedFactData = model
                    
                } catch {
                    print("Errors: \(error)")
                }
            }
            
        }
        dataTask?.resume()
        
    }
    
    //
    // MARK: Obtaining the image path from the json feed. Will be used in the ViewModel class
    //
    func obtainImageDataWithPath(imagePath: String, completionHandler: @escaping (Data?) -> Void) {
        let url: URL! = URL(string: imagePath)
        let task = urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            completionHandler(data)
        }
        task.resume()
    }
    
    func cancelFetchFeeds() {
        if dataTask != nil {
            dataTask?.cancel()
        }
        dataTask = nil
    }
}
