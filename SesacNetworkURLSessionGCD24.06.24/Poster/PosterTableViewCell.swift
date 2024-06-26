//
//  PosterTableViewCell.swift
//  SesacNetworkURLSessionGCD24.06.24
//
//  Created by 이윤지 on 6/25/24.
//

import UIKit
import SnapKit

class PosterTableViewCell: BaseTableViewCell {
    static let id = "PosterTableViewCell"
    
    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.text = "비슷한 영화"
        view.textColor = .black
        return view
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    //서브뷰
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        
    }
    
    //스냅킷
    override func configureLayout(){
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    //백그라운드
    override func configureView(){
       // collectionView.backgroundColor = .blue
     //   titleLabel.backgroundColor = .red
    }    
}
