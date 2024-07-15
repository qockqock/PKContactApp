//
//  ViewController.swift
//  DSContactApp
//
//  Created by 머성이 on 7/12/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var dataSource = [User]()
    
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
    private lazy var mainTableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        mainTableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        
        dataSource = [
            User(name: "name", phoneNumber: "010-0000-0000"),
            User(name: "name", phoneNumber: "010-0000-0000"),
            User(name: "name", phoneNumber: "010-0000-0000"),
            User(name: "name", phoneNumber: "010-0000-0000"),
            User(name: "name", phoneNumber: "010-0000-0000"),
            User(name: "name", phoneNumber: "010-0000-0000"),
            User(name: "name", phoneNumber: "010-0000-0000"),
        ]
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        // 에드섭뷰 해주기
        [addButton, mainTableView, titleLabel].forEach{
            view.addSubview($0)
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
        
//         버튼 잡아주기
        addButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(80)
            $0.top.equalTo(80)
        }
    }
}


extension ViewController: UITableViewDelegate {
    // 테이블 뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension ViewController: UITableViewDataSource {
    // 셀 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(user: dataSource[indexPath.row])
        return cell
    }
    
    // 테이블 뷰 섹션에 행이 몇 개 들어가는지?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
}

#Preview{
    let vc = ViewController()
    return vc
}
