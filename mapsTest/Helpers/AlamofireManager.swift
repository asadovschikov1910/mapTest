//
//  AlamofireManager.swift
//  mapsTest
//
//  Created by Андрей Садовщиков on 04.10.2020.
//

import Foundation
import Alamofire

struct AlamofireManager {
    static let shared: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "Authorization": "Bearer " + KeyChainService.getDataFromChain()]
        let sessionManager = Alamofire.Session(configuration: configuration, delegate: SessionDelegate(), serverTrustManager: nil)
        return sessionManager
    }()
}
