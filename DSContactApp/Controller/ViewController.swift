//
//  ViewController.swift
//  DSContactApp
//
//  Created by 머성이 on 7/12/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let mainView = MainView()
    private var dataSource = [User]() {
        didSet {
            dataSource.sort { $0.name < $1.name }
            mainView.mainTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewconfigureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserDefaultsData()
        mainView.mainTableView.reloadData()
        
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
        
        configureNavigationBar()
    }
    
    // MARK: - UserDefaults에서 데이터 로드
    private func loadUserDefaultsData() {
        if let savedData = UserDefaults.standard.data(forKey: "contacts"),
               let savedContacts = try? JSONDecoder().decode([User].self, from: savedData) {
                dataSource = savedContacts
            }
    }
    
    // MARK: - UserDefaults에 데이터 저장
    private func saveUserDefaultsData() {
        if let savedData = try? JSONEncoder().encode(dataSource) {
            UserDefaults.standard.set(savedData, forKey: "contacts")
            
            loadUserDefaultsData()
        }
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
        let additionController = AdditionController()
        additionController.delegate = self
        self.navigationController?.pushViewController(additionController, animated: true)
    }
}

// MARK: - 뷰컨 관련 extension
extension ViewController: UITableViewDelegate {
    // 테이블 뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    //셀 선택시 호출되는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = dataSource[indexPath.row]
        let additionController = AdditionController()
        additionController.user = selectedUser
        additionController.delegate = self
        
        self.navigationController?.pushViewController(additionController, animated: true)
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
    
    // 테이블 뷰 셀 스와이프 삭제
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (action, view, completionHandler) in
            // self가 올바르게 캡처 되었는지 확인
            guard let self = self else { return }
            
            // 데이터 소스에서 항목 삭제
            self.saveUserDefaultsData()
            
            // 테이블 뷰에서 행 삭제
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self.dataSource.remove(at: indexPath.row)
            }, completion: { finished in
                completionHandler(true)
            })
        }
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

extension ViewController: AdditionControllerDelegate {
    func didAddContact(_ contact: User) {
        dataSource.append(contact)
        saveUserDefaultsData()
        mainView.mainTableView.reloadData() // 추가
    }
    
    func didEditcontact(_ contact: User) {
        if let index = dataSource.firstIndex(where: { $0.name == contact.name }) {
            dataSource[index] = contact
            saveUserDefaultsData()
            mainView.mainTableView.reloadData() // 추가
        }
    }
    
}

