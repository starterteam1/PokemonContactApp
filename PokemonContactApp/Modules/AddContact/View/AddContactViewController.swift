//
//  AddContactViewController.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/8/25.
//

import UIKit

class AddContactViewController: UIViewController {
    
    private let addContactFormView = AddContactFormView()
    private let imageService = ImageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addContactFormView.delegate = self
        bindViewModel()
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
    
    private func bindViewModel() {
        imageService.onImageFetched = { [weak self] image in
            DispatchQueue.main.async {
                self?.addContactFormView.setImage(image)
            }
        }
    }
    
    @objc private func didTapApply() {
        
    }
}

extension AddContactViewController: AddContactFormViewDelegate {
    func didTapGenerateRandomImageButton() {
        imageService.fetchRandomPokemonImage()
    }
}
