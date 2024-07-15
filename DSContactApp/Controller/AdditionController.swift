//
//  AdditionController.swift
//  DSContactApp
//
//  Created by 머성이 on 7/15/24.
//

import UIKit
import SnapKit

class AdditionController: UIViewController {

    private let addtionView = AdditionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        view.addSubview(addtionView)
        // mainView의 레이아웃 설정
        addtionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // 네비게이션 아이템 설정
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        // 네비게이션 타이틀 설정
        self.title = "연락처 추가"
        
        // 우측 버튼 설정
        let additionButton = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(addtionButtonTapped))
        self.navigationItem.rightBarButtonItem = additionButton
    }
    
    @objc private func addtionButtonTapped() {
        // 적용 버튼 클릭시 동작
        print("안농")
    }
}
