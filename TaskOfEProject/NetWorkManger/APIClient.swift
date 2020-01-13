////
//
//  NetWorkManger.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class RequestService {
    static var  alomafireObjectForMocking: NetWorkBusinessLogic? = MainRequest()
    static func sendHttpRequest<T: Decodable>(httpMethod: HTTPMethod,
                                              url: String, objectType: T.Type? = T.self,
                                              isRelativeUrl: Bool? = true,
                                              params: Parameters?=nil,
                                              isAuth: Bool? = true,
                                              customHeaders: [String: String]?=nil,
                                              body: Parameters?=nil,
                                              completion:@escaping  (T?, ErrorCode?) -> Void ) {
        let urlPath = URL(string: RequestUtilty.prepareQueryParameters(
            RequestUtilty.prepareUrl(isRelativeUrl: isRelativeUrl!, url: url).absoluteString,
            params: params as? [String: String])!)!
        let finalHeaders = RequestUtilty.prepareHeader(
            isAuth: isAuth!, customHeaders: customHeaders)
        RequestService.alomafireObjectForMocking!.sendHttpRequest(objectType: T.self,
                                                                  httpMethod: httpMethod, pathOfURL: urlPath,
                                                                  isRelativeUrl: isRelativeUrl, params: params,
                                                                  isAuth: isAuth, customHeaders: finalHeaders,
                                                                  body: body, completion: { (response, error) in
                                                                    completion(response, error)     })}}
