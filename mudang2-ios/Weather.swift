//
//  Weather.swift
//  mudang2-ios
//
//  Created by ha on 2022/12/22.
//

import Foundation
import SwiftUI
import Alamofire

class Weather {
    let weatherAPI : WeatherAPI = WeatherAPI()
    
    var baseTime : String? = nil
    var tmpIdx : Int? = nil
    var skyIdx : Int? = nil
    var ptyIdx : Int? = nil
    var todayDate : String? = nil

    func weatherStatus(
        dataType:String,
        numOfRows:Int,
        pageNo:Int,
        baseData:String,
        baseTime:String,
        nx:Int,
        ny:Int,
        completion:@escaping(String,String,String)->Void
    ){
        let parameters : Parameters = [
            "serviceKey" : ApiKey().API_KEY,
            "dataType" : dataType,
            "numOfRows" : numOfRows,
            "pageNo" : pageNo,
            "base_date": baseData,
            "base_time" : baseTime,
            "nx": nx,
            "ny":ny
        ]
        
        weatherAPI.getWeather(parameters: parameters){ [self] response in
            let tmp = response.response.body.items.item[tmpIdx!].fcstValue
            let sky = response.response.body.items.item[skyIdx!].fcstValue
            let pty = response.response.body.items.item[ptyIdx!].fcstValue
            completion(tmp,sky,pty)
        }
    }
    
    func setHourDate(){
        var currentHour = getCurrentHour()
        
        if (currentHour[0] == "0"){ // 현재 시간이 오전일 때
            currentHour = String(currentHour[1]) // 0 제거
        }
        if (Int(currentHour)! <= 2){ // 0,1,2
            getCurrentDate(beforeDay: 1)
        } else {
            getCurrentDate(beforeDay: 0)
        }
        setBaseTime(hour: Int(currentHour)!)
    }
    
    // 현재 시간 불러오기
    private func getCurrentHour() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter.string(from: Date())
    }
    
    // 현재 날짜 불러오기
    private func getCurrentDate(beforeDay:Int){
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month,.day], from: date)
        let year = String(components.year!)
        var month = String(components.month!)
        var day = String(components.day! - beforeDay)
        
        if (Int(month)! <= 9){
            month = "0"+month
        }
            
        if (Int(day)! <= 9){
            day = "0"+day
        }
        todayDate = year + month + day
    }
    
    private func setBaseTime(hour:Int){
        switch hour {
        case 0 :
            baseTime = "2300"
            tmpIdx = 0
            skyIdx = 5
            ptyIdx = 6
        case 1:
            baseTime = "2300"
            tmpIdx = 12
            skyIdx = 17
            ptyIdx = 18
        case 2:
            baseTime = "2300"
            tmpIdx = 24
            skyIdx = 29
            ptyIdx = 30
        case 3:
            baseTime = "0200"
            tmpIdx = 0
            skyIdx = 5
            ptyIdx = 6
        case 4:
            baseTime = "0200"
            tmpIdx = 12
            skyIdx = 17
            ptyIdx = 18
        case 5:
            baseTime = "0200"
            tmpIdx = 24
            skyIdx = 29
            ptyIdx = 30
        case 6:
            baseTime = "0500"
            tmpIdx = 0
            skyIdx = 5
            ptyIdx = 6
        case 7:
            baseTime = "0500"
            tmpIdx = 12
            skyIdx = 17
            ptyIdx = 18
        case 8:
            baseTime = "0500"
            tmpIdx = 24
            skyIdx = 29
            ptyIdx = 30
        case 9:
            baseTime = "0800"
            tmpIdx = 0
            skyIdx = 5
            ptyIdx = 6
        case 10:
            baseTime = "0800"
            tmpIdx = 12
            skyIdx = 17
            ptyIdx = 18
        case 11:
            baseTime = "0800"
            tmpIdx = 24
            skyIdx = 29
            ptyIdx = 30
        case 12:
            baseTime = "1100"
            tmpIdx = 0
            skyIdx = 5
            ptyIdx = 6
        case 13:
            baseTime = "1100"
            tmpIdx = 12
            skyIdx = 17
            ptyIdx = 18
        case 14:
            baseTime = "1100"
            tmpIdx = 24
            skyIdx = 29
            ptyIdx = 30
        case 15:
            baseTime = "1400"
            tmpIdx = 0
            skyIdx = 5
            ptyIdx = 6
        case 16:
            baseTime = "1400"
            tmpIdx = 12
            skyIdx = 17
            ptyIdx = 18
        case 17:
            baseTime = "1400"
            tmpIdx = 24
            skyIdx = 29
            ptyIdx = 30
        case 18:
            baseTime = "1700"
            tmpIdx = 0
            skyIdx = 5
            ptyIdx = 6
            
        case 19:
            baseTime = "1700"
            tmpIdx = 12
            skyIdx = 17
            ptyIdx = 18
        case 20:
            baseTime = "1700"
            tmpIdx = 24
            skyIdx = 29
            ptyIdx = 30
        case 21:
            baseTime = "2000"
            tmpIdx = 0
            skyIdx = 5
            ptyIdx = 6
        case 22:
            baseTime = "2000"
            tmpIdx = 12
            skyIdx = 17
            ptyIdx = 18
        case 23:
            baseTime = "2000"
            tmpIdx = 24
            skyIdx = 29
            ptyIdx = 30
        default:
            print("다른값")
        }
    }
}
