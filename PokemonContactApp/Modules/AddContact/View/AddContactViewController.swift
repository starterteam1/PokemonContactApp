//
//  AddContactViewController.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/8/25.
//

import UIKit

class AddContactViewController: UIViewController {
    
    private let addContactFormView = AddContactFormView()
    private let addContactViewModel = AddContactViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addContactFormView.delegate = self
        addContactViewModel.delegate = self
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
