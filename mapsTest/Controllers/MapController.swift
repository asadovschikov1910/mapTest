//
//  MapController.swift
//  mapsTest
//
//  Created by Андрей Садовщиков on 03.10.2020.
//

import UIKit
import GoogleMaps


class MapController: UIViewController {
    
    @IBOutlet weak var menu: UIPickerView!
    
    private var mapService = MapService()

    private var camera = GMSCameraPosition()
    private var mapView = GMSMapView()
    
    private var lastZoom :Float = 12.0
    private var mapData = [MapData]()
    private var myMarkers = [GMSMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapService.isLoad = {
            self.mapData = self.mapService.mapData
            if self.mapData.count > 0 {
                self.showMap()
                self.createMarkers()
                self.menu.delegate = self
                self.menu.dataSource = self
            }
        }
        mapService.getMapData()
    }
    
    private func showMap() {
        camera = GMSCameraPosition.camera(withLatitude: mapData[0].position.lt, longitude: mapData[0].position.ln, zoom: lastZoom)
        mapView = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 120, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 180), camera: camera)
        
        self.view.addSubview(mapView)
    }
    
    @IBAction func zoomMinus(_ sender: Any) {
        lastZoom -= 1
        mapView.animate(toZoom: Float(lastZoom))
    }
    
    @IBAction func zoomPlus(_ sender: Any) {
        lastZoom += 1
        mapView.animate(toZoom: Float(lastZoom))
    }
    
    private func createMarkers() {
        for i in 0 ..< mapData.count {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: mapData[i].position.lt, longitude: mapData[0].position.ln)
            marker.title = mapData[i].name
            
            marker.map = mapView
            marker.isFlat = true
            if !mapData[i].isAlpha {
                marker.opacity = 0.5
            }
            myMarkers.append(marker)
        }
        mapView.selectedMarker = myMarkers[0]
    }
}

extension MapController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mapData[row].name
      }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        mapData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let position = GMSCameraPosition.init(latitude: mapData[row].position.lt, longitude: mapData[row].position.ln, zoom: 12)
        mapView.animate(to: position)
        mapView.selectedMarker = myMarkers[row]
    }
    
}
