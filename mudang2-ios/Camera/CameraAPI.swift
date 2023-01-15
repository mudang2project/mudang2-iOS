//
//  GpsAPI.swift
//  mudang2-ios
//
//  Created by ha on 2023/01/12.
//

import Foundation
import Alamofire

struct CameraAPI {
    func getCamera(completion:@escaping(CameraResponse?)->Void){
        AF.request("http://210.102.178.97/cameras/headcount",
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .responseString { response in
                
            /** 서버로부터 받은 데이터 활용 */
            switch response.result {
            case .success(let data):
                /** 정상적으로 reponse를 받은 경우 */
                let response = try? JSONDecoder().decode(CameraResponse.self, from: data.data(using: .utf8)!)
                
                if response != nil && response!.response.isSuccess {
                    print("Camera Success : \(response!.response.code)")
                    completion(response!)
                } else {
                    print("Camera Failed : \(response?.response.code)")
                    completion(nil)
                }
                
            case .failure(let error):
                /** 그렇지 않은 경우 */
                print("Camera Failed : \(error)")
                completion(nil)
            }
        }
    }
}

struct CameraResponse : Codable {
    let response : C_Response
}

struct C_Response : Codable {
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : CameraResult
}

struct CameraResult : Codable {
    let headCount : Int
    let interval : Int
}

