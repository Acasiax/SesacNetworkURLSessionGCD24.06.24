//
//  UI+EXT.swift
//  SesacNetworkURLSessionGCD24.06.24
//
//  Created by 이윤지 on 6/27/24.
//

import UIKit

struct Cast {
    let name: String
    let age: Int
}

struct Movie{
    let name: String
    let runtime: Int
}

struct DummyData<T, U> {
    let main: T
    let sub: U
    
}


extension UIViewController {

    func configureBorderLabel<T: UIView>(_ view: T){
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .clear
        
    }
    
    //제네릭, 범용타입 <>
    //타입 파라미터 >> Placeholder 와 같은 역할
    //타입이 뭔지 모르지만 특정 타입이라는 거는 알 수 있음.
    //🌟제네릭이 무엇인가요?
    //제네릭은 범용적인 타입이고 호출 시 타입이 결정이 되고 제약조건을 걸 때 프로토콜이나 클래스의 제약을 걸 수 있습니다.
    //type constraints -> 프로토콜 제약, 클래스 제약 <T: Numeric>
    func plus<T: Numeric>(a: T, b: T) -> T {
        return a + b
        
    }
    
    
    
    
}
