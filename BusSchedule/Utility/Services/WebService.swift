//
//  WebService.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

typealias GenericObjectClosure<T> = (_ object:T?, _ error: Error?)-> Void

class WebService{
    
    static let sharedInstance = WebService()
    fileprivate init() {}
    
    private func createRequest(method:Alamofire.HTTPMethod, path:String, params: [String : Any]?) -> URLRequest {
        let URL = Foundation.URL(string:ApiURL.baseURL + path)!
        
        var req = URLRequest(url:URL)
        req.httpMethod = method.rawValue
        req.addValue(ApiHeader.authHeaderValue, forHTTPHeaderField: ApiHeader.authHeaderKey)
        
        do {
            return try Alamofire.JSONEncoding().encode(req, with:params)
        }
        catch{
            return req
        }
    }
    
    private func callRequest(_ req:URLRequest) -> DataRequest {
        return Alamofire.request(req).validate()
    }
    
    // MARK: REST methods
    
    func getObject<T:BaseModel>( pathUrl: String, _ result:@escaping GenericObjectClosure<T>) {
        
        callRequest(createRequest(method: .get, path: pathUrl, params: nil)).responseObject { (response:DataResponse<T>) -> Void in
            if let object = response.result.value {
                result(object, nil)
            } else {
                result(nil, response.result.error)
            }
        }
    }
}
