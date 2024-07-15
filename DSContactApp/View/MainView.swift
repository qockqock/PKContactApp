//
//  MainView.swift
//  DSContactApp
//
//  Created by 머성이 on 7/15/24.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    // 타이틀 이름 관련
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "친구 목록"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        
        return label
    }()
    
    // 추가 버튼
    private let addButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(.systemCyan, for: .normal)
        button.setTitle("추가", for: .normal)
        return button
    }()
    
    // 메인 테이블 뷰
    lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureUI() {
        self.backgroundColor = .white
        
        // 에드섭뷰 해주기
        [addButton, mainTableView, titleLabel].forEach{
            self.addSubview($0)
        }
        
        // 타이틀 잡아주기
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(80)
        }
        
        // 테이블 뷰 잡아주기
        mainTableView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        //버튼 잡아주기
        addButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(80)
            $0.top.equalTo(80)
        }
    }
}
