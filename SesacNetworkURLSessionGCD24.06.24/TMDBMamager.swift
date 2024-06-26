//
//  TMDBMamager.swift
//  SesacNetworkURLSessionGCD24.06.24
//
//  Created by 이윤지 on 6/26/24.
//

import Foundation

class TMDBMamager {
    
    static let shared = TMDBMamager()
    
    private init() {}
    
    func callRequest() {
        print(#function)
        URLSession.shared
        
    }
    
}
