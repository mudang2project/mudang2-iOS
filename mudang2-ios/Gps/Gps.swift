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
    
    var busIdx : Int = 0
    var lat : String = ""
    var lon : String = ""

    func gpsStatus(
        busIdx:Int,
        completion:@escaping(Int,String,String)->Void){

            gpsAPI.getGPS(idx: busIdx){ response in
            let busIdx =
                response.result!.busIdx
            let lat =
            response.result!.lat
            let lon =
            response.result!.lon
            completion(busIdx,lat,lon)
        }
    }
}
