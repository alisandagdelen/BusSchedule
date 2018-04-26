//
//  WebService.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
import Alamofire

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


extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseObject<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

