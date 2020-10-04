//
//  KeyChainService.swift
//  mapsTest
//
//  Created by Андрей Садовщиков on 03.10.2020.
//

import Foundation
import KeychainSwift

class KeyChainService: NSObject {
    static let shared: KeyChainService = .init()
    
    static let keychain = KeychainSwift()
    override init() {
        KeyChainService.keychain.synchronizable = true
    }
    
    static func getDataFromChain() -> String {
        return self.keychain.get("myKey") ?? ""
    }
    
    static func setDataToChain(_ data: String) {
        keychain.set(data, forKey: "myKey")
    }
    
    static func delData() {
        keychain.delete("myKey")
    }
}
