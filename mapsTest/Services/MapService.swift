//
//  MapService.swift
//  mapsTest
//
//  Created by Андрей Садовщиков on 03.10.2020.
//

import Foundation
import Alamofire

class MapService {
    var isError: VoidClosure?
    var isLoad: VoidClosure?
    var mapData = [MapData]()
    
    func getMapData() {
        AlamofireManager.shared.request(Router.getSession).responseJSON { response in
            DataConverter.getData(response: response, dataType: SessionData.self, complition: { [self] sessionSuccess, sessionData in
                if sessionSuccess {
                    let sData = (sessionData! as SessionData)
                    if sData.success! {
                        if sData.data!.count > 0 {
                            for i in 0 ..< sData.data![0].units!.count {
                                if sData.data![0].units![i].checked! {
                                    AlamofireManager.shared.request(Router.getUnits(id: sData.data![0].units![i].id!)).responseJSON { responseUnit in
                                        DataConverter.getData(response: responseUnit, dataType: UnitData.self, complition: {[self] unitSuccess, unitData in
                                            if unitSuccess {
                                                let uData = (unitData! as UnitData)
                                                if uData.success {
                                                    let mData = MapData.init(name: uData.data.name, position: uData.data.position, isAlpha: sData.data![0].units![i].eye!)
                                                    mapData.append(mData)
                                                }
                                                if mapData.count == sData.data![0].units!.count {
                                                    self.isLoad?()
                                                }
                                            }
                                        })
                                    }
                                }
                            }
                        }
                    }
                } else {
                    self.isError?()
                }
            })
            
        }
        
    }
    
    
}

