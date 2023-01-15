//
//  Weather.swift
//  mudang2-ios
//
//  Created by ha on 2022/12/22.
//

import Foundation
import SwiftUI
import Alamofire

class Camera {
    let cameraAPI : CameraAPI = CameraAPI()
    
    var headCount : Int = 0

    func cameraStatus(completion:@escaping(Int?)->Void){
        cameraAPI.getCamera() { response in
            if response != nil {
                let headCount =
                response!.response.result.headCount
                completion(headCount)
            } else {
                completion(nil)
            }
            
        }
    }
}
