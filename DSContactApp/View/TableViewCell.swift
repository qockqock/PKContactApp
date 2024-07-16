//
//  TableViewCell.swift
//  DSContactApp
//
//  Created by 머성이 on 7/12/24.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {

    static let id = "TableViewCell"
    
    // 메인 이름 관련
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        
        return label
    }()
    
    // 메인 번호 관련
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        
        return label
    }()
    
    // 프로필 이미지 관련
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        self.backgroundColor = .yellow
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 테이블 셀 안 내용관련 레이아웃
    private func configureUI() {
        contentView.backgroundColor = .white
        [ nameLabel, numberLabel, profileImage].forEach{
            contentView.addSubview($0)
        }
        
        // 이미지 레이아웃
        profileImage.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.width.height.equalTo(60)
        }
        
        // 이름 레이아웃
        nameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
        }
        
        // 전화번호 레이아웃
        numberLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - 테이블 셀 -> 테이블에 연결
    public func configureCell(user: User) {
        nameLabel.text = "\(user.name)"
        numberLabel.text = "\(user.phoneNumber)"
    }
}
