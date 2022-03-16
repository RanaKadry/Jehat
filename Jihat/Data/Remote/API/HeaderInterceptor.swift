//
//  HeaderInterceptor.swift
//  MandoBee
//
//  Created by Peter Bassem on 22/06/2021.
//

import Foundation
import Alamofire

final class HeaderInterceptor {
    
    static func defaultHeaderInterceptor(fromURLRequest urlRequest: inout URLRequest) {
        urlRequest.setValue(KNetworkConstants.ContentType.json.rawValue, forHTTPHeaderField: KNetworkConstants.HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(KNetworkConstants.ContentType.json.rawValue, forHTTPHeaderField: KNetworkConstants.HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(LocalizationHelper.getCurrentLanguage(), forHTTPHeaderField: KNetworkConstants.HTTPHeaderField.acceptLanguage.rawValue)
    }
    
    static func defaultHeaderInterceptor() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Accept-Language": LocalizationHelper.getCurrentLanguage()
        ]
        return headers
    }
    
    static func multipartHeaderInterceptor() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
//            "Content-Type": "application/json",
            "Connection" : "application/x-www-form-urlencoded",
            "Accept": "application/json",
            "Accept-Encoding": "gzip, deflate, br",
            "Accept-Language": LocalizationHelper.getCurrentLanguage()
        ]
        return headers
    }
}
