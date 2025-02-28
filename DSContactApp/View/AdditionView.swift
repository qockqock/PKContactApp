//
//  AdditionView.swift
//  DSContactApp
//
//  Created by 머성이 on 7/15/24.
//

import UIKit
import SnapKit

class AdditionView: UIView {
    
    // 이미지 관련
    public let additionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 100
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        imageView.clipsToBounds = true
        
        return imageView
    }()

    public let randomButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("랜덤 이미지 생성", for: .normal)
        
        return button
    }()
    
    // 이름
    public let nameTextView: UITextView = {
        let textView = UITextView()
//        textView.delegate = self
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.font = .systemFont(ofSize: 20)
        textView.layer.cornerRadius = 10
        
        textView.textColor = .systemGray4 //placeholder 텍스트
        textView.text = "이름을 입력하세요."
        textView.tag = 1
        
        return textView
    }()
    
    // 전화번호
    public let phoneNumberTextView: UITextView = {
        let textView = UITextView()
//        textView.delegate = self
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.font = .systemFont(ofSize: 20)
        textView.layer.cornerRadius = 10
        
        textView.textColor = .systemGray4 //placeholder 텍스트
        textView.text = "전화번호를 입력하세요."
        textView.tag = 2
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        additionConfigureUI()
        nameTextView.delegate = self
        phoneNumberTextView.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 레이아웃 관련
    private func additionConfigureUI() {
        self.backgroundColor = .white
        
        // 에드섭뷰 해주기
        [additionImageView, randomButton, nameTextView, phoneNumberTextView].forEach{
            self.addSubview($0)
        }
        
        // 이미지 관련
        additionImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(120)
            $0.width.height.equalTo(200)
        }
        
        // 랜덤 이미지 생성
        randomButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(additionImageView.snp.bottom).offset(10)
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        // 텍스트 뷰
        nameTextView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(randomButton.snp.bottom).offset(20)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(40)
        }
        
        phoneNumberTextView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameTextView.snp.bottom).offset(20)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(40)
        }
    }
}

extension AdditionView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .systemGray4 else { return }
        
        textView.text = nil
        textView.textColor = .darkGray
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if textView.tag == 1 {
                textView.text = "이름을 입력하세요."
                textView.textColor = .systemGray4
            } else if textView.tag == 2 {
                textView.text = "전화번호를 입력하세요."
                textView.textColor = .systemGray4
            }
        }
    }
}

