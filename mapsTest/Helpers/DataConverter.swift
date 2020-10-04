//
//  DataConverter.swift
//  mapsTest
//
//  Created by Андрей Садовщиков on 03.10.2020.
//

import Foundation
import Alamofire

class DataConverter {
    static func getData<DATA_TYPE: Codable>(response: AFDataResponse<Any>, dataType type: DATA_TYPE.Type,complition: @escaping(_ success: Bool, _ data: DATA_TYPE?)-> ()) {
        switch(response.result) {
        case .success(_):
            if(response.response?.statusCode == 200) {
                do {
                    let data = try JSONDecoder().decode(type.self, from: response.data!)
                    complition(true, data as DATA_TYPE)
                } catch {
                    complition(false, nil)
                }
            } else {
                complition(false, nil)
            }
            break
        case .failure(_):
            complition(false, nil)
            
            break
        }
    }
}
