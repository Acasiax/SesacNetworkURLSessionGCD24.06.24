//
//  TMDBMamager.swift
//  SesacNetworkURLSessionGCD24.06.24
//
//  Created by 이윤지 on 6/26/24.
//

import Foundation

class TMDBManager {
    
    static let shared = TMDBManager()
    
    private init() {}
    
    func callRequest() {
        print(#function)
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1100")!
        
        let request = URLRequest(url: url, timeoutInterval: 5)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            
            print(data)
            print(response)
            print(error)
        }.resume()
        
    }
    
}
