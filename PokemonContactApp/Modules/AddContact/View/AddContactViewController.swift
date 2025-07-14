//
//  AddContactViewController.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/8/25.
//

import UIKit

class AddContactViewController: UIViewController {
    
    private let addContactFormView = AddContactFormView()
    private let addContactViewModel: AddContactViewModel
    
    init(viewModel: AddContactViewModel) {
        self.addContactViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addContactFormView.delegate = self
        addContactViewModel.delegate = self
        
        switch addContactViewModel.mode {
           case .create:
               title = "연락처 추가"

           case .detail(let model):
               title = model.name
               addContactFormView.nameTextField.text = model.name
               addContactFormView.numberTextField.text = model.phoneNumber
            if let image = model.image {
                addContactFormView.randomImageView.image = UIImage(data: image)
            }
           }
    }
    
    private func configureUI() {
        [addContactFormView].forEach { view.addSubview($0) }
        
        view.backgroundColor = .systemBackground
        
        title = "연락처 추가"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "적용",
            style: .done,
            target: self,
            action: #selector(didTapApply)
        )
        
        addContactFormView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func didTapApply() {
        guard let name = addContactFormView.nameTextField.text, !name.isEmpty, let phoneNumber = addContactFormView.numberTextField.text, !phoneNumber.isEmpty else {
            print("이름과 전화번호를 입력해주세요")
            return
        }
        guard let imageData = addContactFormView.randomImageView.image?.pngData() else {
            print("랜덤 포켓몬 이미지가 없습니다.")
            return
        }
        addContactViewModel.saveContact(image: imageData, name: name, phoneNumber: phoneNumber)
        
        navigationController?.popViewController(animated: true)
    }
}
//MARK: - View Delegate
extension AddContactViewController: AddContactFormViewDelegate {
    func didTapGenerateRandomImageButton() {
        addContactViewModel.fetchRandomPokemonImage()
    }
}

//MARK: - ViewModel Delegate
extension AddContactViewController: AddContactViewModelDelegate {
    
    func didFetchPokemonImage(_ data: Data) {
        if let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.addContactFormView.randomImageView.image = image
            }
        }
    }
    
}
