//
//  AdditionController.swift
//  DSContactApp
//
//  Created by 머성이 on 7/15/24.
//

import UIKit
import SnapKit

protocol AdditionControllerDelegate: AnyObject {
    func didAddContact(_ contact: User)
    func didEditcontact(_ contact: User)
}

class AdditionController: UIViewController {
    
    weak var delegate: AdditionControllerDelegate?
    private let additionView = AdditionView()
    
    var user: User?
    // 이미지 데이터 관련
    private var modelImageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        view.addSubview(additionView)
        // mainView의 레이아웃 설정
        additionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // 네비게이션 아이템 설정
        configureNavigationBar()
        
        // 랜덤 버튼
        additionView.randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        
        // 사용자가 있는 경우 데이터 채우기
        if let user = user {
            populateData(user: user)
        }
    }
    
    // MARK: - 서버 데이터 불러오는 메서드
    private func fetchData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                print("데이터 로드 실패")
                completion(nil)
                return
            }
            let successRange = 200..<300
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let decodeData = try? JSONDecoder().decode(T.self, from: data) else {
                    print("데이터가 없음")
                    completion(nil)
                    return
                }
                completion(decodeData)
            } else {
                print("응답 오류")
                completion(nil)
            }
        }.resume()
    }
    
    // MARK: - 서버에서 포켓몬 데이터를 불러오는 메서드
    private func pokemonInfoData() {
        let urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(Int.random(in: 1...1000))")
        
        guard let url = urlComponents?.url else {
            print("잘못된 URL")
            return
        }
        // 데이터를 가지고 오는 메서드 추출
        fetchData(url: url) { [weak self]  (result: Pokemon?) in
            guard let self, let result else { return }
            // 이미지 URL 확인 및 데이터 가져오기
            guard let imageUrl = URL(string: result.sprites.frontDefault) else { return }
            
            // 비동기적으로 이미지 데이터를 가지고 옴
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        // UI 업데이트는 메인 스레드에서 수행 해야겠지?
                        self.additionView.additionImageView.image = image
                        // 이미지 데이터를 User에 저장
                        self.modelImageData = imageData
                    }
                } else {
                    print("이미지 로드 실패")
                }
            }
        }
    }
    
    // MARK: - 네비게이션 바 관련
    private func configureNavigationBar() {
        // 네비게이션 타이틀 설정
        self.title = user?.name ?? "연락처 추가"
        
        // 우측 버튼 설정
        let additionButton = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(addtionButtonTapped))
        self.navigationItem.rightBarButtonItem = additionButton
    }
    
    // MARK: - 추가버튼 눌렸을 때 동작
    @objc private func addtionButtonTapped() {
        // 이름과 전화번호 저장
        let name = additionView.nameTextView.text ?? ""
        let phoneNumber = additionView.phoneNumberTextView.text ?? ""
        
        if var user = user {
            user.name = name
            user.phoneNumber = phoneNumber
            user.profileImageData = self.modelImageData
            delegate?.didEditcontact(user)
        }else {
            // 새 연락처 인스턴스 생성
            let newContact = User(name: name, phoneNumber: phoneNumber, profileImageData: self.modelImageData)
            delegate?.didAddContact(newContact)
        }
        // 이전 화면으로 이동
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 랜덤 버튼 눌렸을 때
    @objc private func randomButtonTapped() {
        pokemonInfoData()
    }
    
    // MARK: - 기존 사용자 데이터 채우기
    private func populateData(user: User) {
        additionView.nameTextView.text = user.name
        additionView.phoneNumberTextView.text = user.phoneNumber
        if let imageData = user.profileImageData {
            additionView.additionImageView.image = UIImage(data: imageData)
            self.modelImageData = imageData
        }
    }
}
