//
//  Weather.swift
//  mudang2-ios
//
//  Created by ha on 2022/12/22.
//

import Foundation
import SwiftUI
import Alamofire

class Gps {
    let gpsAPI : GpsAPI = GpsAPI()

    func gpsStatus(
        completion:@escaping([Bus])->Void){

            gpsAPI.getGPS(){ response in
            let busList =
                response.result
            completion(busList)
        }
    }
}
