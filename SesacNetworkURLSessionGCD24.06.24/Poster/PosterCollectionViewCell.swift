//
//  PosterCollectionViewCell.swift
//  SesacNetworkURLSessionGCD24.06.24
//
//  Created by 이윤지 on 6/25/24.
//

import UIKit
import SnapKit

class PosterCollectionViewCell: UICollectionViewCell {
    static let id = "PosterCollectionViewCell"
    let posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        posterImageView.backgroundColor = .systemMint
    }
    
    required init?(coder: NSCoder) {
        fatalError("에러")
    }
    
}
