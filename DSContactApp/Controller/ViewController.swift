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
    
    // 메인 뷰 관련
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

//#Preview{
//    let vc = ViewController()
//    return vc
//}
