//
//  AuthService.swift
//  mapsTest
//
//  Created by Андрей Садовщиков on 03.10.2020.
//

import Foundation
import Alamofire

class AuthService {
    var isAuth: VoidClosure?
    var isError: VoidClosure?
    
    func getAuth(login: String, password: String) {
        AlamofireManager.shared.request(Router.getAuth(login: login, password: password)).responseJSON { response in
            
            DataConverter.getData(response: response, dataType: AuthData.self, complition: { [self] success, data in
                if success {
                    let authData = (data! as AuthData)
                    if authData.success! {
                        KeyChainService.delData()
                        KeyChainService.setDataToChain(authData.data ?? "")
                        self.isAuth?()
                    } else {
                        self.isError?()
                        KeyChainService.delData()
                    }
                } else {
                    self.isError?()
                    KeyChainService.delData()
                }
            })
        }
    }
}

