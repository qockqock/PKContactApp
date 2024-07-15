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
    private let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewconfigureUI()
    }
    
// MARK: - 메인 뷰 관련
    private func mainViewconfigureUI() {
        view.addSubview(mainView)
        // mainView의 레이아웃 설정
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
        mainView.mainTableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        
        dataSource = [
            User(name: "name", phoneNumber: "010-0000-0000"),
            User(name: "name", phoneNumber: "010-0000-0000"),
            User(name: "name", phoneNumber: "010-0000-0000"),
            User(name: "name", phoneNumber: "010-0000-0000"),
            User(name: "name", phoneNumber: "010-0000-0000"),
            User(name: "name", phoneNumber: "010-0000-0000"),
            User(name: "name", phoneNumber: "010-0000-0000"),
        ]
        
        configureNavigationBar()
    }
    
// MARK: - 네비게이션 관련
    private func configureNavigationBar() {
        // 네비게이션 타이틀 설정
        self.title = "친구 목록"
        
        // 네비게이션 바 타이틀 텍스트 속성 관련 도구
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        // 우측 버튼 설정
        let additionButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(buttonTapped))
        self.navigationItem.rightBarButtonItem = additionButton
    }
    
// MARK: - 버튼 눌렸을 때
    @objc
    private func buttonTapped() {
        // 적용 버튼 클릭시 동작
        self.navigationController?.pushViewController(AdditionController(), animated: true)
    }
}

// MARK: - 뷰컨 관련 extension
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


