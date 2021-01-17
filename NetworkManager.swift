//
//  NetworkManager.swift

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

enum HUDFlag: Int {
    case show = 1
    case hide = 0
}


class NetworkManager: Session {
    
    static let shared       = NetworkManager()
    var progressVC          : ProgressVC?
    var unauthorisedVC      : UnauthorisedVC?
    
    
    // Create http headers
    lazy var httpHeaders : HTTPHeaders = {
        var httpHeader = HTTPHeaders()
        httpHeader["Content-Type"] = "application/json"
        httpHeader["Accept"] = "application/json"
        return httpHeader
    }()
    
    
    //----------------------------------------------------------------
    // MARK: Get Request Method
    //----------------------------------------------------------------
    
    func getResponse<T: Mappable>(_ url: String, parameter: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, header: HTTPHeaders? = nil, showHUD: HUDFlag = .show, message: String, mappingType: T.Type, completion: @escaping (Mappable?, APIError?) -> Void) {
        
        var newHeader: HTTPHeaders!
        
        if header != nil {
            newHeader = header!
        } else {
            newHeader = httpHeaders
        }
        
        if Reachability.isConnectedToNetwork() {
            
            self.objectRequest(url, method: .get, parameter: parameter, encoding: encoding, header: newHeader, mappingType: mappingType) { (mappableResponse) in
                
                switch mappableResponse.result {
                    
                case .success(let data):
                    completion(data, nil)
                    break
                    
                case .failure(let error):
                    completion(nil, .errorMessage(error.localizedDescription))
                    break
                }
            }
        } else {
            completion(nil, .errorMessage(""))
        }
    }
    
    // ----------------------------------------------------------------
    // MARK: Post Request Method
    // ----------------------------------------------------------------
    
    func postResponse<T: Mappable>(_ url: String, parameter: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, header: HTTPHeaders? = nil, showHUD: HUDFlag = .show, message: String, mappingType: T.Type, completion: @escaping (Mappable?, APIError?) -> Void) {
        
        if Reachability.isConnectedToNetwork() {
            
            var newHeader: HTTPHeaders!
            
            if header != nil {
                newHeader = header!
            } else {
                newHeader = [:]
            }
            
            self.objectRequest(url, method: .post, parameter: parameter, encoding: encoding, header: newHeader, mappingType: mappingType) { (mappableResponse) in
                
                switch mappableResponse.result {
                    
                case .success(let data):
                    completion(data, nil)
                    break
                    
                case .failure(let error):
                    completion(nil, .errorMessage(error.localizedDescription))
                    break
                }
            }
        } else {
            completion(nil, .errorMessage(""))
        }
    }
    
    // ----------------------------------------------------------------
    // MARK: Put Request Method
    // ----------------------------------------------------------------
    
    func putResponse<T: Mappable>(_ url: String, parameter: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, header: HTTPHeaders? = nil, showHUD: HUDFlag = .show, message: String, mappingType: T.Type, completion: @escaping (Mappable?, APIError?) -> Void) {
        
        if Reachability.isConnectedToNetwork() {
            
            var newHeader: HTTPHeaders!
            
            if header != nil {
                newHeader = header!
            } else {
                newHeader = [:]
            }
            
            self.objectRequest(url, method: .put, parameter: parameter, encoding: encoding, header: newHeader, mappingType: mappingType) { (mappableResponse) in
                
                switch mappableResponse.result {
                    
                case .success(let data):
                    completion(data, nil)
                    break
                    
                case .failure(let error):
                    completion(nil, .errorMessage(error.localizedDescription))
                    break
                }
            }
        } else {
            completion(nil, .errorMessage(""))
        }
    }
    
    
    // ----------------------------------------------------------------
    // MARK: Object Request Method
    // ----------------------------------------------------------------
    
    func objectRequest<T: BaseMappable>(_ url: String, method: Alamofire.HTTPMethod, parameter: Parameters? = nil, encoding: ParameterEncoding, header: HTTPHeaders? = nil, mappingType: T.Type, completionHandler: @escaping (DataResponse<T, AFError>) -> Void) -> Void {
        
        // Show loader
        self.showProgress(.show)
        
        self.request(url, method: method, parameters: parameter, encoding: encoding, headers: header).responseObject { (response: DataResponse<T, AFError>) in
            
            if let newURL = URL(string: url),
               newURL.host != "api.worldpay.com" {
                
                guard response.response?.statusCode != 400 else {
                    self.unauthorisedVC = UnauthorisedVC.viewController()
                    AppDelegate.shared.window?.addSubview(self.unauthorisedVC!.view)
                    return
                }
            }
            
            // Hide loader
            self.showProgress(.hide)
            
            completionHandler(response as DataResponse<T, AFError>)
        }
    }
    
    //---------------------------------------------------------------------------
    
    func showProgress(_ show: HUDFlag) {
        
        if show == .show {
            
            if progressVC != nil {
                self.progressVC?.view!.removeFromSuperview()
                self.progressVC = nil
            }
            
            self.progressVC = ProgressVC.viewController()
            AppDelegate.shared.window?.addSubview(self.progressVC!.view)
            
        } else {
            
            if progressVC != nil {
                self.progressVC?.view!.removeFromSuperview()
                self.progressVC = nil
            }
        }
    }
}
