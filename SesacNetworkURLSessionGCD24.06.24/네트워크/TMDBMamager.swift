//
//  TMDBMamager.swift
//  SesacNetworkURLSessionGCD24.06.24
//
//  Created by 이윤지 on 6/26/24.
//

import Foundation


struct Lotto: Decodable {
    let drwNoDate: String
    let totSellamnt: String
}

//열거형을 활용하면 더 명확하게 에러를 던져줄 수 있음
enum jackError: Int, Error {
    case failedRequest = 401
    case noData = 403
    case invalidResponse
    case invalidData
}

class TMDBManager {
    
    static let shared = TMDBManager()
    
    private init() {}
    
    func callRequest(completionHandler: @escaping (Lotto?,jackError?)-> Void) {
        print(#function, Thread.isMainThread)

        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1100")!
        
        //URL / URLRequest / URLComponent
        
        var component = URLComponents()
        component.scheme = "https"
        component.host = "www.dhlottery.co.kr"
        component.path = "/common.do"
        component.queryItems = [
            URLQueryItem(name: "method", value: "getLottoNumber"),
            URLQueryItem(name: "drwNo", value: "1100")
        ]
        
        let request = URLRequest(url: component.url!, timeoutInterval: 5)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                print(data)
                print(response)
                print("🔍\(Thread.isMainThread)")
                print(error)
                print("🔍🔍")
                
                
                guard error == nil else {
                    print("실패한 리퀘스트 요청")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("데이터 없다")
                    completionHandler(nil, .noData)
                    return
                }
                
                //error가 nil인 상황, data가 있는 상황
                guard let response = response as? HTTPURLResponse else {
                    print("응답이 허용되지 않음")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode  == 200 else {
                    print("응답이 허용되지 않음")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
               print("이제 식판에 담으면 됨")
                
                do {
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
                    print("성공")
                    print(result)
                    completionHandler(result, nil)
                    
                } catch {
                    print("에러")
                    print(error)
                    completionHandler(nil, .invalidData)
                    
                }
            }
            
         
            
            
        }.resume()
        
    }
    
}
