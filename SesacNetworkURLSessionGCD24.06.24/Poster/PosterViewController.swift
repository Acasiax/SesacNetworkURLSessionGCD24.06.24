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
        
        let group = DispatchGroup() // +1
        
        group.enter() //일을 보내기 직전에 호출 // +1
        DispatchQueue.global().async(group: group) {
            
            
            TMDBAPI.shared.trendingMovies { movie, error in
                
                if let error = error {
                    print(error)  //사용자에게 상황 고지
                } else {
                    guard let movie = movie else { return }
                    self.imageList[0] = movie
                }
                group.leave()  //한번만 작성해도 네트워킹이 성공, 실패 했던 실행됨
                
            }
//            //성공했을 때
//            TMDBAPI.shared.trendingMovies { data in
//                self.imageList[0] = data
//                print("111⛑️\(data)")
//                group.leave() // -1
//           
//            } errorHandler: { value in  //실패했을때
//                print(value) //얼럿으로 사용자에게 표시
//                self.imageList.remove(at: 0)  //리무브 해주는 데이터 가공 
//                group.leave() //오류여도 해제하게
//            }

        }
        
        
        DispatchQueue.global().async(group: group) {
            
            
            TMDBAPI.shared.trendingMovies { movie, error in
                
                if let error = error {
                    print(error)  //사용자에게 상황 고지
                } else {
                    guard let movie = movie else { return }
                    self.imageList[1] = movie
                }
                group.leave()  //한번만 작성해도 네트워킹이 성공, 실패 했던 실행됨
                
            }
        }
        
        
//        group.enter() //일을 보내기 직전에 호출 // +2
//        DispatchQueue.global().async(group: group) {
//            //성공했을 때
//            TMDBAPI.shared.trendingMovies { data in
//                self.imageList[1] = data
//                print("222⛑️\(data)")
//                group.leave() // -1
//           
//            } errorHandler: { value in  //실패했을때
//                print(value) //얼럿으로 사용자에게 표시
//                group.leave() //오류여도 해제하게
//            }
//
//        }
        
        
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
    
    func aboutGCD() {
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for item in 1...100 {
                print(item, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for item in 101...200 {
                print(item, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for item in 201...300 {
                print(item, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for item in 301...400 {
                print(item, terminator: " ")
            }
        }
        group.notify(queue: .main) {
            print("4명 알바생 업무 끝났어요")
        }
        
    }
    
    
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
