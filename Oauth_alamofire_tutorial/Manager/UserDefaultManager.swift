//
//  UserDefaultManager.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/18.
//

import Foundation

class UserDefaultsManager {
    enum Key : String, CaseIterable {
        case refreshToken, accessToken
    }
    
    static let shared: UserDefaultsManager = {
        return UserDefaultsManager()
    }()
    
    // 저장된 모든 데이터 지우기
    func clearAll(){
        print("UserDefaultManager - clearAll() called")
        Key.allCases.forEach{
            UserDefaults.standard.removeObject(forKey: $0.rawValue)
        }
    }
    
    // 토큰들 저장
    func setTokens(accessToken: String, refreshToken: String){
        print("UserDefaultsManager - setTokens() called ")
        UserDefaults.standard.set(accessToken, forKey: Key.accessToken.rawValue)
        UserDefaults.standard.set(refreshToken, forKey: Key.refreshToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    //토큰들 가져오기
    func getTokens() -> TokenData {
        let accessToken = UserDefaults.standard.string(forKey: Key.accessToken.rawValue) ?? ""
        let refreshToken = UserDefaults.standard.string(forKey: Key.refreshToken.rawValue) ?? ""
        return TokenData(accessToken: accessToken, refreshToken: refreshToken)
    }
}

//----------------------------------------------------------------------------------------------

final class KeychainHelper {
    
    static let standard = KeychainHelper()

    // 토큰을 받아와 키체인에 저장
    func save(_ data: Data, service: String, account: String) {
        
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary
        
        // Add data in query to keychain
        let status = SecItemAdd(query, nil)
        
        // 혹시 키체인에 같은 값이 있다면 새로운 값으로 교체(업데이트)
        if status == errSecDuplicateItem {
             // Item already exist, thus update it.
             let query = [
                 kSecAttrService: service,
                 kSecAttrAccount: account,
                 kSecClass: kSecClassGenericPassword,
             ] as CFDictionary

             let attributesToUpdate = [kSecValueData: data] as CFDictionary

             // Update existing item
             SecItemUpdate(query, attributesToUpdate)
        } else {
            print(" 키체인 Error: => \(status)")
        }
            }
    
    //키체인에 저장 되어있는 값들을 불러올때 사용
    func read(service: String, account: String) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    //키체인에 있는 데이터 삭제
    func delete(service: String, account: String) {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }

}

extension KeychainHelper {
    
    func save<T>(_ item: T, service: String, account: String) where T : Codable {
        
        do {
            // Encode as JSON data and save in keychain
            let data = try JSONEncoder().encode(item)
            save(data, service: service, account: account)
            
        } catch {
            assertionFailure("Fail to encode item for keychain: \(error)")
        }
    }
    
    func read<T>(service: String, account: String, type: T.Type) -> T? where T : Codable {
        
        // Read item data from keychain
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        // Decode JSON data to object
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
    
}
