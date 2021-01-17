//
//  DataManager.swift
//  Pharma247Store
//
//  Created by Sagar Chauhan on 07/10/19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import Foundation
import Alamofire

class DataManager: NSObject {
    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Variables
    //------------------------------------------------------------------------------
    
    static let shared   = DataManager()
    let baseUrl         = WebServiceURL.live
    
    // Create http headers
    func getHeaders() -> HTTPHeaders {
        var httpHeader = HTTPHeaders()
        httpHeader["Content-Type"] = "application/json"
        httpHeader["Accept"] = "application/json"
        httpHeader["role"] = "user"
        httpHeader["Authorization"] = UserDefaults.Tokens.string(forKey: .authToken)
        print("Headers: \(httpHeader)")
        return httpHeader
    }
    
    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Custom Methods
    //------------------------------------------------------------------------------
    
    // Get API url with endpoints
    func getURL(_ endpoint: WSEndPoints) -> String {
        return baseUrl + endpoint.rawValue
    }
}


//------------------------------------------------------------------------------
// MARK:-
// MARK:- WebserviceURL
//------------------------------------------------------------------------------

struct WebServiceURL {
    static let live         = "http://motorserviceapi.electromech.ie/"
    static let worldPay     = "https://api.worldpay.com/v1/orders"
    static let tokenDetails = "https://api.worldpay.com/v1/tokens/"
}


//------------------------------------------------------------------------------
// MARK:-
// MARK:- WebserviceEndPoints
//------------------------------------------------------------------------------

enum WSEndPoints: String {
    
    case login                      = "users/login"
    case signup                     = "users/signup"
    case forgotPassword             = "users/forgotpassword"
    case logout                     = "users/logout"
    case editProfile                = "users/edituser"
    
    case addCar                     = "users/addcar"
    case carBrandList               = "users/carbrand_list"
    case carModelList               = "users/carmodellist"
    case carList                    = "users/usercaraddedlist"
    case motorcheckCarDetails       = "users/motorcheck_car_details"
    case deleteCar                  = "users/delete_car"
    case vehicleTypeList            = "users/vehicle_type_list"
    
    case serviceList                = "users/car_servicelist"
    
    case nearByGarageList           = "users/nearbygarage_list"
    
    case autoPartsCategoryList      = "users/autoparts_category_list"
    case autoPartsSubCategoryList   = "users/autoparts_sub_category_list"
    case autoPartsOrder             = "users/autoparts_order"
    
    case needMechanic               = "users/need_mechanic"             
    
    case autoPartsCompanyList       = "users/autoparts_company_list"
    case productList                = "users/autoparts_child_category_list"
    case addProduct                 = "users/shopping_cart"
    case cartList                   = "users/shopping_cart_list"
    case deleteProduct              = "users/shopping_cart_update"
    
    case chatList                   = "users/chatlist"
    case chatMessages               = "users/chatmessages"
    case quotationAcceptReject      = "users/quotation_accept_reject"
    case currentJobs                = "users/current_jobs"              
    
    case userServices               = "users/userservices"
    case userServicesList           = "users/userservices_list"
    case leaveFeedback              = "users/leave_feedback"
    case newsLetter                 = "users/newsletter"

    case offerRewardList            = "users/offer_rewards_list"
    case history                    = "users/history"
    case rewardHistory              = "users/reward_history"
    
    case insertCardToken            = "users/insert_card_token"
    case listCardToken              = "users/list_card_token"
    case deleteCardToken            = "users/delete_card_token"
    
    case markInvoice                = "users/mark_invoice"
    case rewardPointsList           = "users/reward_points_list"
    case addRewardPoints            = "users/add_reward_points"
    case removeRewardPoints         = "users/remove_reward_points"
    
    case createInvoice              = "users/create_invoice"
    
    /*
     [12:11 AM, 12/20/2020] Amit Kanhasoft: "booking_fees"=>$data['booking_fees'],
                 "booking_fees_status"=>$data['booking_fees_status'],
                 "amount_total_by_app"=>$data['amount_total_by_app'],
     jobs_id
     [12:21 AM, 12/20/2020] Amit Kanhasoft: users/create_invoice
     [12:26 AM, 12/20/2020] Amit Kanhasoft: is_reward_used
     [12:26 AM, 12/20/2020] Amit Kanhasoft: used_reward_point
     */
}


enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}


enum APIError: Error {
    
    case errorMessage(String)
    case requestFailed(String)
    case jsonConversionFailure(String)
    case invalidData(String)
    case responseUnsuccessful(String)
    case jsonParsingFailure(String)
    
    var localizedDescription: String {
        
        switch self {
            
        case.errorMessage(let msg):
            return msg
            
        case .requestFailed(let msg):
            return msg
            
        case .jsonConversionFailure(let msg):
            return msg
            
        case .invalidData(let msg):
            return msg
            
        case .responseUnsuccessful(let msg):
            return msg
            
        case .jsonParsingFailure(let msg):
            return msg
        }
    }
}


internal let DEFAULT_MIME_TYPE = "image/jpeg"

internal let mimeTypes = [
    "html": "text/html",
    "htm": "text/html",
    "shtml": "text/html",
    "css": "text/css",
    "xml": "text/xml",
    "gif": "image/gif",
    "jpeg": "image/jpeg",
    "jpg": "image/jpeg",
    "js": "application/javascript",
    "atom": "application/atom+xml",
    "rss": "application/rss+xml",
    "mml": "text/mathml",
    "txt": "text/plain",
    "jad": "text/vnd.sun.j2me.app-descriptor",
    "wml": "text/vnd.wap.wml",
    "htc": "text/x-component",
    "png": "image/png",
    "tif": "image/tiff",
    "tiff": "image/tiff",
    "wbmp": "image/vnd.wap.wbmp",
    "ico": "image/x-icon",
    "jng": "image/x-jng",
    "bmp": "image/x-ms-bmp",
    "svg": "image/svg+xml",
    "svgz": "image/svg+xml",
    "webp": "image/webp",
    "woff": "application/font-woff",
    "jar": "application/java-archive",
    "war": "application/java-archive",
    "ear": "application/java-archive",
    "json": "application/json",
    "hqx": "application/mac-binhex40",
    "doc": "application/msword",
    "pdf": "application/pdf",
    "ps": "application/postscript",
    "eps": "application/postscript",
    "ai": "application/postscript",
    "rtf": "application/rtf",
    "m3u8": "application/vnd.apple.mpegurl",
    "xls": "application/vnd.ms-excel",
    "eot": "application/vnd.ms-fontobject",
    "ppt": "application/vnd.ms-powerpoint",
    "wmlc": "application/vnd.wap.wmlc",
    "kml": "application/vnd.google-earth.kml+xml",
    "kmz": "application/vnd.google-earth.kmz",
    "7z": "application/x-7z-compressed",
    "cco": "application/x-cocoa",
    "jardiff": "application/x-java-archive-diff",
    "jnlp": "application/x-java-jnlp-file",
    "run": "application/x-makeself",
    "pl": "application/x-perl",
    "pm": "application/x-perl",
    "prc": "application/x-pilot",
    "pdb": "application/x-pilot",
    "rar": "application/x-rar-compressed",
    "rpm": "application/x-redhat-package-manager",
    "sea": "application/x-sea",
    "swf": "application/x-shockwave-flash",
    "sit": "application/x-stuffit",
    "tcl": "application/x-tcl",
    "tk": "application/x-tcl",
    "der": "application/x-x509-ca-cert",
    "pem": "application/x-x509-ca-cert",
    "crt": "application/x-x509-ca-cert",
    "xpi": "application/x-xpinstall",
    "xhtml": "application/xhtml+xml",
    "xspf": "application/xspf+xml",
    "zip": "application/zip",
    "bin": "application/octet-stream",
    "exe": "application/octet-stream",
    "dll": "application/octet-stream",
    "deb": "application/octet-stream",
    "dmg": "application/octet-stream",
    "iso": "application/octet-stream",
    "img": "application/octet-stream",
    "msi": "application/octet-stream",
    "msp": "application/octet-stream",
    "msm": "application/octet-stream",
    "docx": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "xlsx": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    "pptx": "application/vnd.openxmlformats-officedocument.presentationml.presentation",
    "mid": "audio/midi",
    "midi": "audio/midi",
    "kar": "audio/midi",
    "mp3": "audio/mpeg",
    "ogg": "audio/ogg",
    "m4a": "audio/x-m4a",
    "ra": "audio/x-realaudio",
    "3gpp": "video/3gpp",
    "3gp": "video/3gpp",
    "ts": "video/mp2t",
    "mp4": "video/mp4",
    "mpeg": "video/mpeg",
    "mpg": "video/mpeg",
    "mov": "video/quicktime",
    "webm": "video/webm",
    "flv": "video/x-flv",
    "m4v": "video/x-m4v",
    "mng": "video/x-mng",
    "asx": "video/x-ms-asf",
    "asf": "video/x-ms-asf",
    "wmv": "video/x-ms-wmv",
    "avi": "video/x-msvideo"
]

internal func MimeType(ext: String) -> String {
    if mimeTypes.contains(where: { $0.0 == ext.lowercased() }) {
        return mimeTypes[ext.lowercased()]!
    }
    return DEFAULT_MIME_TYPE
}

extension NSString {
    public func mimeType() -> String {
        return MimeType(ext: self.pathExtension)
    }
}

extension String {
    public func mimeType() -> String {
        return (self as NSString).mimeType()
    }
}
