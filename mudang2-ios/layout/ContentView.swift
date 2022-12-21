//
//  ContentView.swift
//  mudang2-ios
//
//  Created by ha on 2022/12/19.
//

import SwiftUI

struct ContentView: View {
    let smallTextSize : CGFloat = 14
    let bigTextSize : CGFloat = 25
    let weatherAPI : WeatherAPI = WeatherAPI(apiKey: ApiKey())
    
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
                
            
            
            Rectangle()
                .frame(width:Screen.width*0.93,height: Screen.height*0.60)
            
            
            
            HStack{
                VStack(spacing:0){
                    Text("대기 인원수(정문)")
                        .font(.system(size: smallTextSize))
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading,10)
                    Text("\(20)명")
                        .font(.system(size: bigTextSize))
                        //.fontWeight(.bold)
                        .frame(width:70,height:70)
                    Text("혼잡")
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
                    
                    Image("sun")
                        .resizable()
                        .frame(width:70,height:70)
                    Text("\(20)℃")
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
            weatherAPI.getWeather()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
