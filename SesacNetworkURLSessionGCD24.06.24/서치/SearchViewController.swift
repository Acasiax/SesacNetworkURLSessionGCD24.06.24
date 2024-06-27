//
//  SearchViewController.swift
//  SesacNetworkURLSessionGCD24.06.24
//
//  Created by 이윤지 on 6/25/24.
//

import UIKit
import SnapKit //없어도 작동 가능

/*
 Meta Type: 타입의 타입 이다.
 
 */

struct User {
    let name = "고래밥" //
    static let originalName = "Jack"
    
}


class SearchViewController: BaseViewcontroller {

    let mainView = SearchView()
    
    //주의점: viewDidLoad보다 먼저 실행됨.
    //loadView: 뷰컨트롤러의 루트뷰를 생성하주는 기능
    //super.loadView()를 절대 호출하지 말아야 한다! 네버! ->  당연하게 안되야만 하는 이유가 있다 -> 애플이 설정한 걸 불러오면 우리가 만든것만 온전하게 사용할 수 없음?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        
        let nickname = "고래밥"
        let user = User()
        
        print(type(of: user.name))
        print(type(of: User.self))
        print(type(of: user)) //User라는 인스턴스의 타입
       // print(type(of: string))
//        User.originalName
//        PosterTableViewCell.id //우리가 사용하던 것도 메타타입이다.
        
        // "고래밥" => String/String.self  => String.Type
        
        
        TMDBAPI.shared.request(api: .trendingMovie, model: Trending.self) { value, error in
            value?.results
        }
        
    
        
        let cast = DummyData(main: "", sub: 13)
        let todo = DummyData(main: "", sub: "")
        let test = DummyData(main: false, sub: false)
        
        
        let button = UIButton()
        configureBorderLabel(button)
        configureBorderLabel(mainView.resultLabel)
        
        
        
//        TMDBManager.shared.callRequest { lotto, error in
//            print("서치뷰컨트롤러 핸들러", Thread.isMainThread)
//            print(lotto, error)
//            //잘 동작되는 코드로 바꾸기
//            //이렇게 처리해라 필수 두개로
//            guard error != nil else {
//                print("여기가 에러 지점")
//                return}
//            guard let lotto = lotto else {
//                print("여기가 로또 지점")
//                return}
//            
//            self.mainView.resultLabel.text = lotto.drwNoDate
//           
//            
//        }
    }
    
    //서브뷰
    override func configureHierarchy() {
        print(#function)
        
        
    }
 
    
    
    //백그라운드
    override func configureView(){
        
        
    }
}

//1. gcd 명확하게 이해하기, 디스패치 그룹 이해하기
//2. 알람어파이어 사용해서 네트워크 구조 이용하고 + enum으로 라우터 패턴? 이용하기
//3. 명확하게 복습 URLSession + Handler
//4. 제네릭 + 메타 타입

// 다음주는 네트워크 통신 x, 데이타베이스
