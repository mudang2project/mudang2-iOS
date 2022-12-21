//
//  WeatherAPI.swift
//  mudang2-ios
//
//  Created by ha on 2022/12/21.
//

import SwiftUI
import Alamofire

struct ApiKey {
    let END_POINT = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/"
    // Encoding
    let API_KEY = "LjvVdAj8xkMki3iLA6c%2F4WirxV6jbjM9RQkzfahxOUDyYDxuFkETc77ui6iM7vj4qLjAtZYXXZG7eH5aQPHrRQ%3D%3D"
    // Decoding
    //let API_KEY = "LjvVdAj8xkMki3iLA6c/4WirxV6jbjM9RQkzfahxOUDyYDxuFkETc77ui6iM7vj4qLjAtZYXXZG7eH5aQPHrRQ=="
}

struct WeatherAPI {
    let apiKey : ApiKey
    
    func getWeather() {
        AF.request(apiKey.END_POINT,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json", "serviceKey" : apiKey.API_KEY])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
            /** 서버로부터 받은 데이터 활용 */
            switch response.result {
            case .success(let data):
                /** 정상적으로 reponse를 받은 경우 */
                print(data)
            case .failure(let error):
                /** 그렇지 않은 경우 */
                print(error)
            }
        }
    }
}

struct WeatherResponse{
    let reponse : Response
    
    
    init(reponse: Response) {
        self.reponse = reponse
    }
    
    struct Response {
        let header : Header
        let body : Body
    }
    
    struct Header {
        let resultCode : Int
        let resultMsg : String
    }
    
    struct Body {
        let dataType : String
        let items : Items
    }
    
    struct Items : Codable {
        let item : [Item]
    }
    
    struct Item : Codable {
        let baseData : Int
        let baseTime : String
        let category : String
        let fcstDate : String
        let fcstTime : String
        let fcstValue : String
        let nx : Int
        let ny : Int
    }
}
