//
//  TMDBRequest.swift
//  SesacNetworkURLSessionGCD24.06.24
//
//  Created by 이윤지 on 6/26/24.
//

import UIKit
import Alamofire
//네트워크 요청 모델: Router Pattern
// - 아쉬운 점: ResponseDecodable에 있는 Model.self가 해결이 어려울 수 있다. 제네릭과 메타타입 개념으로 해결 할 수 있을거다!
// Moya 로 하면 되게 편함


//api 관리소
enum TMDBRequest {
    
    case trendingTV
    case trendingMovie
    case search(query: String)
    case images(id: Int)
    
    //"https://api.themoviedb.org/3/search/movie?query=해리포터"
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.key]
    }
    
    
    var method: HTTPMethod {
        return .get
        
    }
    
    var endPoint: URL {
        switch self {
        case .trendingTV:
            return URL(string: baseURL + "trending/tv/day")!
        case .trendingMovie:
            return URL(string: baseURL + "trending/movie/day")!
        case .search:  //매개변수?
           // return URL(string: baseURL + "search/movie?query=해리포터")!
            return URL(string: baseURL + "search/movie")!
        case .images(let id):
            return URL(string: baseURL + "movie/\(id)/images")!
        }
        
    }
    
    var parameter: Parameters {
        switch self {
        case .trendingTV, .trendingMovie:
            return ["language": "ko-KR"]
        
        case .search(let query):
            return ["query": query] //?
            
        case .images:
            return ["": ""]
        }
    }
    
    
}

