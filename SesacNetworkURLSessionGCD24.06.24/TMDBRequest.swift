//
//  TMDBRequest.swift
//  SesacNetworkURLSessionGCD24.06.24
//
//  Created by 이윤지 on 6/26/24.
//

import UIKit
import Alamofire

//api 관리소
enum TMDBRequest {
    
    case trendingTV
    case trendingMovie
    case search
    case images
    
    //"https://api.themoviedb.org/3/search/movie?query=해리포터"
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.tmdb]
    }
    
    var endPoint: URL {
        switch self {
        case .trendingTV:
            return URL(string: baseURL + "trending/tv/day?language=ko-KR")!
        case .trendingMovie:
            return URL(string: baseURL + "trending/movie/day?api_key=\(APIKey.tmdb)&language=ko-KR")!
        case .search:
            return URL(string: baseURL + "search/movie?query=해리포터")!
        case .images:
            return URL(string: baseURL + "movie/10300/images")!
        }
        
    }
    
}

