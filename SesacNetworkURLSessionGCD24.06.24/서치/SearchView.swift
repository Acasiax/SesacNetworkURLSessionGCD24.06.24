//
//  SearchView.swift
//  SesacNetworkURLSessionGCD24.06.24
//
//  Created by 이윤지 on 6/25/24.
//

import UIKit

class SearchView: BaseView {
    let searchBar = UISearchBar()
    //뷰컨트롤러 인스턴스 생성 전에 클로저가 먼저 실행이 된다.🌟
    lazy var resultLabel = {
        let view = UILabel()
        print("ResultLabel")
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = "검색 결과가 없습니다."
        return view
    }()
    
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(resultLabel)
    }
    
    
    //스냅킷
    override func configureLayout(){
        print(#function)
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
    
    override func configureView() {
        print(#function)
        searchBar.placeholder = "아무거나 검색해보세요"
        searchBar.delegate = self
    }
    
}

// delegate를 view에서 채택하고 사용해도 상관 없지만. 여기에서는 화면 이동 코드가 안나몸?🌟
extension SearchView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("검색 버튼 클릭")
      //  resultLabel.text = "확인 확인!!"
     //   Present, nav 안나옴🌟
    }
    
    
}
