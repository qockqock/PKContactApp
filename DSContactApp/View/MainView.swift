//
//  MainView.swift
//  DSContactApp
//
//  Created by 머성이 on 7/15/24.
//

import UIKit
import SnapKit

class MainView: UIView {
    
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
    
    // MARK: - 레이아웃 관련
    public func configureUI() {
        self.backgroundColor = .white
        
        // 에드섭뷰 해주기
        [mainTableView].forEach{
            self.addSubview($0)
        }
        
        // 테이블 뷰 잡아주기
        mainTableView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(150)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
