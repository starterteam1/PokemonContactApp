# Pokemon Contact App

## 프로젝트 소개

`PokemonContactApp`은 내배움캠프 iOS 과정에서 진행한 개인 프로젝트로, 귀여운 포켓몬 이미지를 활용하여 연락처를 관리하는 앱입니다. 단순히 정보를 저장하는 것을 넘어, 랜덤 포켓몬 이미지를 통해 사용자에게 재미와 시각적인 즐거움을 선사하는 것을 목표로 합니다.

## 주요 기능 및 상세 설명

### 1. 연락처 목록 (Contact List)
- **Core Data 연동**: 앱이 실행되면 Core Data에 저장된 연락처들을 가져와 목록에 표시합니다. 데이터는 이름순으로 정렬됩니다.
- **동적 UI 업데이트**: `viewWillAppear` 시점에 데이터를 리로드하여, 연락처 추가/수정/삭제 시 목록이 항상 최신 상태로 유지됩니다.
- **상세 화면 이동**: 특정 연락처를 탭하면 해당 연락처의 상세 정보 화면으로 이동하여 정보를 확인하고 수정할 수 있습니다.

### 2. 연락처 추가 및 수정 (Add/Detail Contact)
- **화면 재사용**: `AddContactViewController` 하나를 `ContactMode`(.create, .detail) 열거형으로 분기하여 '추가'와 '상세/수정' 두 가지 시나리오에 모두 대응합니다.
- **랜덤 포켓몬 이미지 생성**:
    - '랜덤 이미지 생성' 버튼을 누르면 `PokeAPI`에 비동기적으로 요청을 보냅니다.
    - 1부터 1000까지의 랜덤한 포켓몬 ID를 사용하여 API를 호출하고, 응답으로 받은 이미지 URL을 통해 이미지를 다운로드합니다.
    - `Alamofire`를 사용하여 네트워킹을 처리하고, `Decodable`을 통해 JSON 데이터를 안전하게 파싱합니다.
- **데이터 저장 및 업데이트**:
    - '적용' 버튼을 누르면 입력된 이름, 전화번호, 그리고 생성된 포켓몬 이미지 데이터를 `CoreDataManage`를 통해 영구 저장소에 저장하거나 업데이트합니다.
    - `NSManagedObjectID`를 사용하여 특정 연락처를 고유하게 식별하고 업데이트를 수행합니다.

## 적용 기술 및 라이브러리

| 구분 | 기술/라이브러리 | 상세 내용 |
| :--- | :--- | :--- |
| **UI** | `UIKit`, `SnapKit`, `Then` | 코드를 통해 UI를 구성하고, SnapKit과 Then을 사용하여 간결하고 직관적인 Auto Layout 및 UI 코드 작성을 구현했습니다. |
| **Architecture**| `MVVM (Model-View-ViewModel)` | UI 로직과 비즈니스 로직을 분리하여 코드의 테스트 용이성, 재사용성, 유지보수성을 극대화했습니다. |
| **Asynchronous**| `Alamofire` | PokeAPI와의 HTTP 통신을 통해 포켓몬 이미지 데이터를 비동기적으로 가져옵니다. |
| **Data Persistence**| `Core Data` | 연락처 정보를 앱 내에 영구적으로 저장하고 관리하기 위해 사용했습니다. |

## 프로젝트 구조

```
PokemonContactApp
├── Application
│   ├── AppDelegate.swift       # 앱 생명주기, Core Data Persistent Container 설정
│   └── SceneDelegate.swift       # UIWindow 설정, 초기 ViewController 지정
├── Modules
│   ├── AddContact              # 연락처 추가/수정 모듈
│   │   ├── Model
│   │   │   └── ImageResponse.swift # PokeAPI 응답 모델
│   │   ├── View
│   │   │   ├── AddContactFormView.swift # 연락처 입력 폼 UI
│   │   │   └── AddContactViewController.swift # 연락처 추가/수정 화면
│   │   └── ViewModel
│   │       └── AddContactViewModel.swift # 연락처 추가/수정 로직
│   └── ContactList             # 연락처 목록 모듈
│       ├── Model
│       │   └── ContactModel.swift    # View-ViewModel 데이터 전달 모델
│       ├── View
│       │   ├── ContactListCell.swift # 연락처 목록 테이블뷰 셀
│       │   └── ContactListViewController.swift # 연락처 목록 화면
│       └── ViewModel
│           └── ContactListViewModel.swift # 연락처 목록 로직
├── Persistence
│   ├── CoreDataManage.swift    # Core Data CRUD 관리 클래스
│   ├── Contact+CoreDataClass.swift
│   └── Contact+CoreDataProperties.swift
└── Resources
    ├── Assets.xcassets
    └── Base.lproj
```

## 실행 화면

| 연락처 목록 | 연락처 추가/수정 |
| :---: | :---: |
| <img width="250" alt="image" src="https://github.com/user-attachments/assets/5bbab850-cffd-4483-b8a1-9ee0d933c4ee" /> | <img width="250" alt="Simulator Screenshot - iPhone 16e - 2025-07-14 at 11 02 19" src="https://github.com/user-attachments/assets/aa078f79-ed59-448f-bb3e-a19757c42da6" />
