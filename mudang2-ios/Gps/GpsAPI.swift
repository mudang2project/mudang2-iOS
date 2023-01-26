//
//  GpsAPI.swift
//  mudang2-ios
//
//  Created by ha on 2023/01/12.
//

import Foundation
import Alamofire

struct GpsAPI {
    func getGPS(completion:@escaping(GpsResponse)->Void){
        AF.request("http://210.102.178.97/gps/location",
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .responseString { response in
                
            /** 서버로부터 받은 데이터 활용 */
            switch response.result {
            case .success(let data):
                /** 정상적으로 reponse를 받은 경우 */
                
                let response = try? JSONDecoder().decode(GpsResponse.self, from: data.data(using: .utf8)!)

                if response != nil && response!.isSuccess == true {
                    print("GPS Success : \(response!.code)")
                    completion(response!)
                } else {
                    print("GPS Failed : \(response?.code)")
                }
                
            case .failure(let error):
                /** 그렇지 않은 경우 */
                print("GPS Failed : \(error)")
            }
        }
    }
}

struct GpsResponse : Codable {
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [Bus]
}

struct Bus : Codable {
    let busIdx : Int
    let lat : String?
    let lon : String?
}

class BusListViewModel: ObservableObject {
    @Published var busList : [Bus] = []
    
    func addList(bus:Bus) {
        busList.append(bus)
    }
    
    func refresh(){
        busList = []
    }
}
