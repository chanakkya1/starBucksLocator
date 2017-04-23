//
//  RequestResponseManager.swift
//  starbucksLocator
//
//  Created by chanakkya mati on 4/22/17.
//  Copyright © 2017 chanakkya mati. All rights reserved.
//

import Foundation
import CoreLocation

struct Location{
    var latitude:String
    var longitude:String
}

class RequestResponseManager {
   let presentLocation :Location
   private let baseRequestURLString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    
   init(location:Location) {
        self.presentLocation = location
    }
    
    
    
    lazy var requestURL :URL? = {
        let additionalparameters = "rankby=distance&type=cafe&name=starbucks&key=AIzaSyCs86seckaA-aTbqge-lQafYqV3dg5R0G8"
        let locationParameter = "location=\(self.presentLocation.latitude),\(self.presentLocation.longitude)"
        let parameters = locationParameter+"&"+additionalparameters
        return URL(string: self.baseRequestURLString.appending(parameters))
    }()
    
    func parseResponse(response:Dictionary<String, Any>)->[CLLocationCoordinate2D]?{
        guard response["status"] as! String == "OK" else{
            return nil
        }
        guard let results:Array<Dictionary> = response["results"] as? Array<Dictionary<String,Any>> else{
            return nil
        }
        
      let locations =  results.map{ dict -> CLLocationCoordinate2D? in
           guard let geometry = dict["geometry"] as? Dictionary<String,Any>,
            let location = geometry["location"] as? Dictionary<String,Double>,
            let latitude = location["lat"],
            let longitude = location["lng"] else {
                return nil
            }
            return CLLocationCoordinate2DMake(latitude,longitude)
        }
        
        
        return locations.flatMap{$0}
        
    }
   
}
