//
//  RequestComponent.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
struct Constants {
    struct  Server{
           
           #if DEVELOPMENT
           static let baseURL = "https:"
           #elseif TESTING
           static let baseURL = "https:"
           #elseif STAGING
           static let baseURL = "https:"
           #else
           static let baseURL = "https:"
           #endif
           static let hostUrl = "https:"
           
           struct Services {
               static let  getUsersURL =  hostUrl + ""
           }
       }
}
enum HTTPHeaderField: String {
    case authentication = "Auth-Token"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case language = "Language"
    case locale = "Locale"
    case IP = "IP"
    case device = "Device"
    case OS = "OS"
    case OSVersion = "OS-Version"
}
enum ContentType: String {
    case json = "application/json"
}
public enum Lang: String {
    case AR
    case EN
    case FR
}
class IPPublic {
    class  func getIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    // swiftlint:disable superfluous_disable_command
                    if let name: String = String(cString: (interface?.ifa_name)!), name == "en0" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!),
                                    &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
}


extension Dictionary {
    /// Merge and return a new dictionary
    func merge(with: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        var copy = self
        for (key, value) in with {
            // If a key is already present it will be overritten
            copy[key] = value
        }
        return copy
    }
    /// Merge in-place
    mutating func append(with: Dictionary<Key, Value>) {
        for (key, value) in with {
            // If a key is already present it will be overritten
            self[key] = value
        }
    }
}

class RequestUtilty {
    
  class func prepareHeader(isAuth: Bool, customHeaders: [String: String]?) -> HTTPHeaders {
           var headerMergedDic: [String: String]?
           let basicHeaders = [
               HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue,
               HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue,
               HTTPHeaderField.language.rawValue: Lang.EN.rawValue,
               HTTPHeaderField.locale.rawValue: Locale.current.identifier,
               HTTPHeaderField.IP.rawValue: IPPublic.getIPAddress() ?? "",
               HTTPHeaderField.device.rawValue: UIDevice.current.name,
               HTTPHeaderField.OS.rawValue: "iOS",
               HTTPHeaderField.OSVersion.rawValue: UIDevice.current.systemVersion
           ]
           if  let header =  customHeaders {
               headerMergedDic =  basicHeaders.merge(with: header)
           } else {
               headerMergedDic = basicHeaders
           }
           var  headers = HTTPHeaders.init(headerMergedDic!)
           
           if isAuth {
               headers[HTTPHeaderField.authentication.rawValue] = ContentType.json.rawValue
           }
           return headers
       }
    
    class func prepareUrl(isRelativeUrl: Bool, url: String) -> URL {
        let   pathOfURL: URL?
        if isRelativeUrl {
            pathOfURL = URL(fileURLWithPath: Constants.Server.baseURL).appendingPathComponent(url)
        } else {
            pathOfURL =  URL(string: url)
        }
        
        return pathOfURL!
        
    }
    
    class    func prepareQueryParameters(_ value: String, params: [String: String]?) -> String? {
        var components = URLComponents(string: value)
        if let paramters = params {
            components?.queryItems = paramters.map { element in URLQueryItem(name: element.key, value: element.value) }
        }
        return components?.url?.absoluteString
    }
    class func isValidToken() -> Bool {
        // mins 1m from
        let secondDate = Date()
        var firstDate =  Date()
//        if let tokenTime = UserStatus.getTokenTimestamp()
//        {
//            firstDate = Date(timeIntervalSince1970: tokenTime)
//        }
        return firstDate < secondDate
    }
}
