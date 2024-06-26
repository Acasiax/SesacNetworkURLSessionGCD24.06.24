//
//  SearchViewController.swift
//  SesacNetworkURLSessionGCD24.06.24
//
//  Created by 이윤지 on 6/25/24.
//

import UIKit
import SnapKit //없어도 작동 가능

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
        
    }
    
    //서브뷰
    override func configureHierarchy() {
        print(#function)
        
        
    }
    
    
    
    //백그라운드
    override func configureView(){
        
        
    }
}
