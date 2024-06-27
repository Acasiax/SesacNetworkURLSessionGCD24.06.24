//
//  TMDBAPI.swift
//  SesacNetworkURLSessionGCD24.06.24
//
//  Created by 이윤지 on 6/25/24.
//

import UIKit
import Alamofire

struct APIKey {
    static let tmdb = "5f2db2ebdd9c192816eae0ca0e888406"
    static let key = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZjJkYjJlYmRkOWMxOTI4MTZlYWUwY2EwZTg4ODQwNiIsInN1YiI6IjY2NjVhNjM0YTBkZmU4OTM3Y2UwY2QzYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S6Yn5qQLaAZVZIVwlmXtaPtiUbnnR_nDH4GuzBv9rKc"
}

struct Trending: Decodable {
    let page: Int
    let results: [TrendingDetail]
    let total_pages: Int
    let total_results: Int
}

struct TrendingDetail: Decodable {
    let poster_path: String
    // 다른 필요한 속성 추가
}

class TMDBAPI {
    
    static let shared = TMDBAPI()
    
    private init() {}
    
    //오류가 났을 때 사용자에게 토스트나 메세지를 주기 위해 string으로 하는 편  @escaping (String) -> Void)
   // func trendingMovies(completionHandler: @escaping ([TrendingDetail]) -> Void, errorHandler: @escaping (String) -> Void) {
    //func trendingMovies(completionHandler: @escaping ([TrendingDetail]) -> Void) {
    
    
    typealias TrendingHandler = ([TrendingDetail]?, String?) -> Void
    
    //T를 만들고 : Decodable 하고 .responseDecodable(of: T.self)으로 바꾸고 -> 그럼에도 문법 오류 -> T는 어떤 타입이 들어올 지 호출시점에서 들어와야하는데 와야하는 공간조차 마련되어 있지 않다 그래서 트렌딩헨들러에서 @escaping (T?, jackError) -> Void) 으로 구성 ->  completionHandler(value, nil)
    func request<T: Decodable>(api: TMDBRequest, model: T.Type, completionHandler: @escaping (T?, jackError?) -> Void) {
        print(#function)

        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let value):
                print("성공 - Movies")
               // dump(value.results)
                
                completionHandler(value, nil)
                
            case .failure(let error):
                print("실패 - Movies")
                completionHandler(nil, .failedRequest)
                print(error)
            }
        }
    }
    
    
    
    
    
    //best
    //성공했을 때는 [TrendingDetail] 오고, 실패했을 때는 String 에러메세지를 던저 줄 것, 근데 실패했을 때는 데이터가 안오니깐 두가지 매개변수를 동시에 받겠다 ->  ? 옵셔널을 넣어줌 ([TrendingDetail]?, String?) -> 튜플타입
    func trending(api: TMDBRequest, completionHandler: @escaping TrendingHandler) {
        print(#function)

        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Trending.self) { response in
            
            switch response.result {
            case .success(let value):
                print("성공 - Movies")
                dump(value.results)
                
                completionHandler(value.results, nil)
                
            case .failure(let error):
                print("실패 - Movies")
                completionHandler(nil, "잠시후 다시 시도해주세요")
                print(error)
            }
        }
    }
    
    func trendingPeople() {
        print(#function)
        
        let url = "https://api.themoviedb.org/3/trending/person/day?api_key=\(APIKey.key)&language=ko-KR"
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Trending.self) { response in
                
            switch response.result {
            case .success(let value):
                print("성공 - People")
                dump(value.results)
            case .failure(let error):
                print("실패 - People")
                print(error)
            }
        }
    }
    
    
    func moviePoster() {
            print(#function)
            let url = "https://api.themoviedb.org/3/movie/10300/images"
            
            let header: HTTPHeaders = [
                "Authorization": APIKey.tmdb
            ]
            
            AF.request(url,
                       method: .get,
                       headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Trending.self) { response in
                 
                switch response.result {
                case .success(let value):
                    print("SUCCESS")
                    dump(value)
                case .failure(let error):
                    print("FAILED")
                    print(error)
                }
            }
        }
    
    func movieSearch() {
            print(#function)
            let url = "https://api.themoviedb.org/3/search/movie?query=해리포터"
            
            let header: HTTPHeaders = [
                "Authorization": APIKey.tmdb
            ]
            
            AF.request(url,
                       method: .get,
                       headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Trending.self) { response in
                 
                switch response.result {
                case .success(let value):
                    print("SUCCESS")
                    dump(value)
                case .failure(let error):
                    print("FAILED")
                    print(error)
                }
            }
        }
    

}
