//
//  ContentView.swift
//  mudang2-ios
//
//  Created by ha on 2022/12/19.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    let smallTextSize : CGFloat = 14
    @State var bigTextSize : CGFloat = 25
    let weather = Weather()
    let gps = Gps()
    let camera = Camera()
        
    @State var tmp : String = ""
    @State var sky : String = ""
    @State var pty : String = ""
    
    @State var busIdx : Int = 0
    @State var lat : String = ""
    @State var lon : String = ""
    
    @State var headCount : String = ""
    
    @State var congestion : String = ""
    
    var body: some View {
        VStack {
            HStack{
                Image("logoG")
                Text("가천대 무당이")
                    .foregroundColor(Colors.blueTextColor)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Spacer()
                Button {
                    print("click")
                } label: {
                    Image("qIcon")
                        .resizable()
                        .frame(width:30,height: 30)
                }

                
            }.frame(maxWidth:.infinity)
                .padding([.leading,.trailing],Screen.width*0.05)
                
            
            
            MapView()
                .frame(width:Screen.width*0.93,height: Screen.height*0.60)
            
            
            
            HStack{
                VStack(spacing:0){
                    Text("대기 인원수(정문)")
                        .font(.system(size: smallTextSize))
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading,10)
                    Text(headCount)
                        .font(.system(size: bigTextSize))
                        //.fontWeight(.bold)
                        .frame(width:70,height:70)
                    Text(congestion)
                        .font(.system(size: smallTextSize))
                        .foregroundColor(.red)
                }.frame(width:Screen.width*0.44, height: Screen.height*0.16)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 1, x: 2, y: 2)
                    
                Spacer()
                
                VStack(spacing:0){
                    Text("복정동 날씨")
                        .font(.system(size: smallTextSize))
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading,10)
                    
                    Image(skyImage(sky,pty))
                        .resizable()
                        .frame(width:70,height:70)
                    Text("\(tmp)℃")
                        .font(.system(size: smallTextSize))
                }.frame(width:Screen.width*0.44, height: Screen.height*0.16)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 1, x: 2, y: 2)
                
            }.frame(width:Screen.width*0.93)
            Spacer()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Colors.blueBackgoundColor)
        .task {
            getWeather()
            getGPS()
            getCamera()
        }
    }
    
    private func skyImage(_ sky:String,_ pty:String) -> String {
        var img = ""
        
        switch sky {
        case "1" :
            img = "sun"
        case "3","4":
            img = "cloud"
        default:
            img = "sun"
        }
        
        switch pty {
        case "0" :
            break
        case "3":
            img = "snow"
        default:
            img = "rain"
        }
        
        return img
    }
    
    private func getWeather(){
        weather.setHourDate()
        weather.weatherStatus(dataType: "JSON", numOfRows: 36, pageNo: 1, baseData: weather.todayDate!, baseTime: weather.baseTime!, nx: 62, ny: 124){ tmp,sky,pty in
            print("\(tmp)\n\(sky)\n\(pty)")
            self.tmp = tmp
            self.sky = sky
            self.pty = pty
        }
    }
    
    private func getCamera(){
        camera.cameraStatus { headCount in
            if headCount != nil {
                self.headCount = "\(headCount!)명"
                self.bigTextSize = 25
                if headCount! >= 20 {
                    self.congestion = "혼잡"
                } else if headCount! >= 10 {
                    self.congestion = "보통"
                } else {
                    self.congestion = "원활"
                }
            } else {
                self.headCount = "점검 중"
                self.bigTextSize = 15
                self.congestion = ""
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { timer in
            camera.cameraStatus { headCount in
                if headCount != nil {
                    self.headCount = "\(headCount!)명"
                    self.bigTextSize = 25
                    if headCount! >= 20 {
                        self.congestion = "혼잡"
                    } else if headCount! >= 10 {
                        self.congestion = "보통"
                    } else {
                        self.congestion = "원활"
                    }
                } else {
                    self.headCount = "점검 중"
                    self.bigTextSize = 15
                    self.congestion = ""
                }
            }
        })
    }
    
    private func getGPS(){
        
        for idx in 1...6 {
            gps.gpsStatus(busIdx: idx) { busIdx, lat, lon in
                self.busIdx = busIdx
                self.lat = lat
                self.lon = lon
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { timer in
            for idx in 1...6 {
                gps.gpsStatus(busIdx: idx) { busIdx, lat, lon in
                    self.busIdx = busIdx
                    self.lat = lat
                    self.lon = lon
                }
            }
        })
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
