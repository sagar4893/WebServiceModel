//
//  WSUser.swift
//  Pharma247Store
//
//  Created by Sagar Chauhan on 07/10/19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

extension DataManager {
 
    func loginUser(email: String, password: String, completion: @escaping(Result<LoginModel, APIError>) -> Void) {
        
        let param: Parameters = [
            "user_email": email,
            "password": password,
            "fcm_token": UserDefaults.Tokens.string(forKey: .fcmToken) ?? "",
            "device_id": "",
            "device_name": "ios"
        ]
        
        NetworkManager.shared.postResponse(getURL(.login), parameter: param, header: nil, message: "", mappingType: LoginModel.self) { (mappableData, apiError) in
            
            if apiError == nil {
                completion(.success(mappableData as! LoginModel))
            } else {
                completion(.failure(apiError!))
            }
        }
    }
    
    //---------------------------------------------------------------------------
    
    func signupUser(parameter: [String: Any], completion: @escaping(Result<SignupModel, APIError>) -> Void) {
        
        NetworkManager.shared.postResponse(getURL(.signup), parameter: parameter, header: nil, message: "", mappingType: SignupModel.self) { (mappableData, apiError) in
            
            if apiError == nil {
                completion(.success(mappableData as! SignupModel))
            } else {
                completion(.failure(apiError!))
            }
        }
    }
    
    //---------------------------------------------------------------------------
    
    func editProfile(parameter: [String: Any], completion: @escaping(Result<SignupModel, APIError>) -> Void) {
        
        NetworkManager.shared.postResponse(getURL(.editProfile), parameter: parameter, header: self.getHeaders(), message: "", mappingType: SignupModel.self) { (mappableData, apiError) in
            
            if apiError == nil {
                completion(.success(mappableData as! SignupModel))
            } else {
                completion(.failure(apiError!))
            }
        }
    }
    
    //---------------------------------------------------------------------------
    
    func forgotPassword(email: String, completion: @escaping(Result<SignupModel, APIError>) -> Void) {
        
        let param: Parameters = [
            "email": email
        ]
        
        NetworkManager.shared.postResponse(getURL(.forgotPassword), parameter: param, header: nil, message: "", mappingType: SignupModel.self) { (mappableData, apiError) in
            
            if apiError == nil {
                completion(.success(mappableData as! SignupModel))
            } else {
                completion(.failure(apiError!))
            }
        }
    }
    
    //---------------------------------------------------------------------------
    
    func rewardList(completion: @escaping(Result<RewardsModel, APIError>) -> Void) {
        
        NetworkManager.shared.postResponse(getURL(.rewardPointsList), header: self.getHeaders(), message: "", mappingType: RewardsModel.self) { (mappableData, apiError) in
            
            if apiError == nil {
                completion(.success(mappableData as! RewardsModel))
            } else {
                completion(.failure(apiError!))
            }
        }
    }
    
    //---------------------------------------------------------------------------
    
    func rewardHistory(completion: @escaping(Result<RewardHistoryModel, APIError>) -> Void) {
        
        NetworkManager.shared.postResponse(getURL(.rewardHistory), header: self.getHeaders(), message: "", mappingType: RewardHistoryModel.self) { (mappableData, apiError) in
            
            if apiError == nil {
                completion(.success(mappableData as! RewardHistoryModel))
            } else {
                completion(.failure(apiError!))
            }
        }
    }
}

