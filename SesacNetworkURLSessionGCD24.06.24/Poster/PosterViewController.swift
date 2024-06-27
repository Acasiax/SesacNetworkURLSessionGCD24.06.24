//
//  PosterViewController.swift
//  SesacNetworkURLSessionGCD24.06.24
//
//  Created by 이윤지 on 6/25/24.
//

import UIKit
import SnapKit
import Kingfisher

class PosterViewController: BaseViewcontroller {
    //view.delegate = self,view.dataSource = self는 먼저 인스턴스가 만들어진 후에 self가 가능해서 클로저에 넣으면 안됨 -> 그래서 lazt var 사용
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 200
        view.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
        return view
    }()
    
//    var imageList: [[String]] = [ ["star", "person", "xmark"], ["star.fill", "bubble", "mic", "bird.fill"], ["phone", "envelope", "tortoise"] ]
    var imageList: [[TrendingDetail]] = [
        [TrendingDetail(poster_path: "")],
        [TrendingDetail(poster_path: "")]
    ]
    
    static let id = "PosterViewController"
    
    
    //1. 우연의 일치로 DispatchGroup을 사용하지 않더라도 뷰 갱신이 잘 될 수도 있긴 하다 > 하지만 올바른 해결책이 아님!
    //2. completionHandler가 호출되지 않는 상황
    // => 호출되게 만들고 group.leave
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TMDBManager.shared.callRequest(completionHandler: <#(Lotto?, jackError?) -> Void#>)
        
        let group = DispatchGroup() // +2
        
        group.enter() //일을 보내기 직전에 호출 // +1
        DispatchQueue.global().async(group: group) {
            TMDBAPI.shared.trending(api: .trendingTV) { movie, error in
                if let error = error {
                    print(error)  //사용자에게 상황 고지
                } else {
                    guard let movie = movie else { return }
                    self.imageList[0] = movie
                }
                group.leave()  //한번만 작성해도 네트워킹이 성공, 실패 했던 실행됨
            }

        }
        
        
        DispatchQueue.global().async(group: group) {
            
            group .enter()
      //      TMDBAPI.shared.trendingMovies(api: .trendingMovie) { movie, error in
            TMDBAPI.shared.trending(api: .trendingMovie) { movie, error in
                if let error = error {
                    print(error)  //사용자에게 상황 고지
                } else {
                    guard let movie = movie else { return }
                    self.imageList[1] = movie
                }
                group.leave()  //한번만 작성해도 네트워킹이 성공, 실패 했던 실행됨
                
            }
        }
        
      
        //enter,leave -> 제로 0 이 되는 시점에 이게 실행 될 것은
        group.notify(queue: .main) {
            print("3333")
            self.tableView.reloadData()
        }
     
    }
    
    //serial, concurrent / sync aunc
    //main global
    // global qos
    // dispatchgroup

    
    //서브뷰
    override func configureHierarchy() {
        view.addSubview(tableView)
        
    }
    
    //스냅킷
    override func configureLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //백그라운드
    
    override func configureView(){
        
    }
    
}

extension PosterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as! PosterTableViewCell
        cell.backgroundColor = .brown
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)

        
        return cell
    }
    
}


extension PosterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//        if collectionView.tag == 0 {
//            return imageList[0].count
//        } else if collectionView.tag == 1 {
          //  return imageList[1].count
     //   }
        
        return imageList[collectionView.tag].count
        
//        if collectionView.tag == 3 {
//            return 3
//        } else {
//            return 10
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
        let data = imageList[collectionView.tag][indexPath.item]
        
    //   cell.posterImageView.image = UIImage(systemName: data)
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(data.poster_path)")
        cell.posterImageView.kf.setImage(with: url)
        collectionView.reloadData() //🌟
        return cell
    }
    
    
    
}


//HTTP
//1. request 단방향 통신
//2. connectionless 비연결성
//3. stateless 무상태성 (식별x) 요청한 유저가 누구인지 모름, 이전에 유저에 검색한게 무엇인지 모름. ->그래서 식별할 수 있는게 필요함-> 토큰, 세션, 쿠키를 활욯한다. (16회차 강의 자료에 있다고 함)


// 🌟 면접 질문 http의 특성은?
// 🌟 단방향 통신의 근거나 이유는? 단방향 통신이 뭔지, 비연결성이 뭔지 그래서 이 특성을 어떻게 연결할 수 있는지. 비연결성이 무엇이에요?


//인터페이스 자체가 애플이 제공하는 기능 같은 거, 우리는 모름. 네트워크를 통해서 핵심 컨텐츠와 기능을 활용할 수 있도록 제공한 아키텍쳐 혹은 아키텍처 스타일

//서버의 자원 = 리소스 -> 이미지 같은 자원들을 말함. 자원을 중심으로 엔트포인트를 말함. 자원을 중심으로 리소스가 나옴,

//6원칙
// 1. 유니폼 인터페이스
// 2. stateless
//3. 캐쉬어블 - 이런게 있는게 좋다
//4. self-descriptiveness

//rest api - 특정 언어나 기술에 종속 되지 않음
 //🌟 rest api가 가지고 있는 장점과 단점을 이야기하라
    // 🌟이걸 선택한 이유가 뭔지. 오버페칭 / 언더패칭

//오버패칭 - 필요한 정보보다 더 많은 정보값이 로딩될 수 있음
//언더패칭 - 필요한 정보보다 부족한 정보 로딩으로 인해 추가 api 요청이 필요 -> 영화 전반 정보를 모두 요청하고 싶으나 다시 다른걸 호출하는 경우가 있음?
//엔드포인트 늘어남 - 서비스 규모가 커질수록 엔트포인트가 늘어나 관리하기 어려워짐





