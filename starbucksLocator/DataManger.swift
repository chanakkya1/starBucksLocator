//
//  DataManger.swift
//  starbucksLocator
//
//  Created by chanakkya mati on 4/22/17.
//  Copyright © 2017 chanakkya mati. All rights reserved.
//

import Foundation
import CoreLocation

enum Status{
    case success
    case failure(FailureStatus)
}

enum FailureStatus:Error{
    case NetworkError
    case NoResponse
    case InvalidResponse
}

class DataManager {
    
    var location:Location!{
        didSet{
            self.requestResponseManager = RequestResponseManager(location: location)
        }
    }
    
    private var requestResponseManager:RequestResponseManager!
    
    
    func fetchStarbucks(completionHandler:@escaping (Status,[CLLocationCoordinate2D]?)->Void){
      let session =  URLSession(configuration: URLSessionConfiguration.ephemeral)
        session .dataTask(with: requestResponseManager.requestURL!) { (data, urlResponse, error) in
            guard error == nil else {
                DispatchQueue.main.async(execute: {
                    completionHandler(.failure(.NetworkError),nil)
                })
            
             return
            }
            guard let data = data else {
               DispatchQueue.main.async(execute: {
                     completionHandler(.failure(.NoResponse),nil)
                })
             return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,Any>
            guard let locations = self.requestResponseManager.parseResponse(response: json) else{
                DispatchQueue.main.async(execute: {
                    completionHandler(.failure(.InvalidResponse),nil)
                })
              return
            }
            
            DispatchQueue.main.async(execute: {
                completionHandler(.success,locations)
            })
            
        }.resume()
    }
}
