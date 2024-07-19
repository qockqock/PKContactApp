# DSContactApp

DSContactApp은 사용자가 연락처 목록을 관리하고, 포켓몬 API에서 랜덤 프로필 이미지를 가져오는 기능을 제공하는 iOS 애플리케이션입니다.

## 주요 기능

- 연락처 목록 보기, 추가, 편집 및 삭제
- 포켓몬 API를 사용하여 랜덤 프로필 이미지 가져오기
- 사용자 정보는 UserDefaults를 통해 로컬에 저장

## 사용한 기술 스택

- **Swift**: 애플리케이션의 주요 언어
- **UIKit**: 사용자 인터페이스 구성
- **SnapKit**: 오토 레이아웃을 위한 DSL
- **URLSession**: 네트워크 요청
- **Codable**: JSON 데이터 인코딩 및 디코딩
- **UserDefaults**: 로컬 데이터 저장

## 프로젝트 구조

```plaintext
DSContactApp/
│
├── Controllers/
│   ├── ViewController.swift
│   └── AdditionController.swift
│
├── Models/
│   ├── Pokemon.swift
│   └── UserInfo.swift
│
├── Views/
│   ├── MainView.swift
│   ├── AdditionView.swift
│   └── TableViewCell.swift
│
└── Info.plist
```

## 시연 영상
<p align="center">
  <img src="https://github.com/user-attachments/assets/80fd9f3b-07db-4399-b30e-0361074af9c2" alt="Simulator Screen Recording 3" width="300"/>
  <img src="https://github.com/user-attachments/assets/6bca5940-5414-4274-acba-349261928171" alt="Simulator Screen Recording 2" width="300"/>
</p>
