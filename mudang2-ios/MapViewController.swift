//
//  MapViewControllerBridge.swift
//  mudang2-ios
//
//  Created by ha on 2023/01/11.
//

import UIKit
import GoogleMaps
import SwiftUI

class ViewController: UIViewController {
    var busList : [Bus] = []
    let mapView = GMSMapView.map(withFrame:  CGRect(x: 0, y: 0, width:Screen.width*0.93,height: Screen.height*0.60), camera: GMSCameraPosition.camera(withLatitude: 37.4525, longitude: 127.1312, zoom: 15.5))


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: 37.4519, longitude: 127.1312))
        path.add(CLLocationCoordinate2D(latitude: 37.4526, longitude: 127.1307))
        path.add(CLLocationCoordinate2D(latitude: 37.4526, longitude: 127.1305))
        path.add(CLLocationCoordinate2D(latitude: 37.4525, longitude: 127.1300))
        path.add(CLLocationCoordinate2D(latitude: 37.4521, longitude: 127.1295))
        path.add(CLLocationCoordinate2D(latitude: 37.4517, longitude: 127.1275))
        path.add(CLLocationCoordinate2D(latitude: 37.4506, longitude: 127.1275))
        path.add(CLLocationCoordinate2D(latitude: 37.4499, longitude: 127.1299))
        path.add(CLLocationCoordinate2D(latitude: 37.4509, longitude: 127.1303))
        path.add(CLLocationCoordinate2D(latitude: 37.4512, longitude: 127.1308))
        path.add(CLLocationCoordinate2D(latitude: 37.4522, longitude: 127.1314))
        path.add(CLLocationCoordinate2D(latitude: 37.4524, longitude: 127.1319))
        path.add(CLLocationCoordinate2D(latitude: 37.4531, longitude: 127.1336))
        path.add(CLLocationCoordinate2D(latitude: 37.4535, longitude: 127.1342))
        path.add(CLLocationCoordinate2D(latitude: 37.4536, longitude: 127.1345))
        path.add(CLLocationCoordinate2D(latitude: 37.4537, longitude: 127.1347))
        path.add(CLLocationCoordinate2D(latitude: 37.4541, longitude: 127.1348))
        path.add(CLLocationCoordinate2D(latitude: 37.4555, longitude: 127.1347))
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .red
        polyline.strokeWidth = 3.0
        polyline.map = mapView
        
        self.view.addSubview(mapView)
    }
     
    
    func viewUpdate(busList:[Bus]){
        mapView.clear()
        for bus in busList {
            if bus.lon != "null" && bus.lat != "null" {
                
                print("busIdx:\(bus.busIdx), lat:\(bus.lat), lon:\(bus.lon)")
                
                let mudang = UIImage(named: "bus\(bus.busIdx+1)")!.resized(to: CGSize(width: 25, height: 40))
                let markerView = UIImageView(image: mudang)
                let position = CLLocationCoordinate2D(latitude: Double(bus.lat!)!, longitude: Double(bus.lon!)!)
                let marker = GMSMarker(position: position)
                marker.iconView = markerView
                marker.title = String(bus.busIdx)
                marker.tracksViewChanges = true
                marker.map = mapView
            }
        }
        self.view.addSubview(mapView)
        self.view.layoutIfNeeded()
    }

}

struct MapView: UIViewControllerRepresentable {
    let mapViewController = ViewController()
    
    func makeUIViewController(context: Context) -> ViewController {
        
        return mapViewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
    
    func viewUpdate(busList:[Bus]){
        mapViewController.viewUpdate(busList: busList)
    }
}

