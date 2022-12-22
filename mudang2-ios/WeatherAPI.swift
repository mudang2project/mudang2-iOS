//
//  WeatherAPI.swift
//  mudang2-ios
//
//  Created by ha on 2022/12/21.
//

import SwiftUI
import Foundation
import Alamofire

struct ApiKey {
    let END_POINT = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"
    // Encoding
    //let API_KEY = "LjvVdAj8xkMki3iLA6c%2F4WirxV6jbjM9RQkzfahxOUDyYDxuFkETc77ui6iM7vj4qLjAtZYXXZG7eH5aQPHrRQ%3D%3D"
    // Decoding
    let API_KEY = "LjvVdAj8xkMki3iLA6c/4WirxV6jbjM9RQkzfahxOUDyYDxuFkETc77ui6iM7vj4qLjAtZYXXZG7eH5aQPHrRQ=="
}

struct WeatherAPI {
    func getWeather(parameters:Parameters,completion:@escaping(WeatherResponse)->Void){
        AF.request(ApiKey().END_POINT,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .responseString { response in
                
            /** 서버로부터 받은 데이터 활용 */
            switch response.result {
            case .success(let data):
                /** 정상적으로 reponse를 받은 경우 */
                
                let response = try? JSONDecoder().decode(WeatherResponse.self, from: data.data(using: .utf8)!)
                
                completion(response!)
            case .failure(let error):
                /** 그렇지 않은 경우 */
                print("오류\n\(error)")
            }
        }
    }
}

struct WeatherResponse : Codable {
    let response : Response
}

struct Response : Codable {
    let header : Header
    let body : Body
}

struct Header : Codable {
    let resultCode : String
    let resultMsg : String
}

struct Body : Codable {
    let dataType : String
    let items : Items
}

struct Items : Codable {
    let item : [Item]
}

struct Item : Codable {
    let baseDate : String
    let baseTime : String
    let category : String
    let fcstDate : String
    let fcstTime : String
    let fcstValue : String
    let nx : Int
    let ny : Int
}
