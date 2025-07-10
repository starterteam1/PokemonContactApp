//
//  AddContactFormView.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/8/25.
//

import UIKit

protocol AddContactFormViewDelegate: AnyObject {
    func didTapGenerateRandomImageButton()
}

final class AddContactFormView: UIView {
    
    weak var delegate: AddContactFormViewDelegate?
    
    let randomImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.borderWidth = 4
        $0.layer.borderColor = UIColor.systemGray.cgColor
        $0.layer.masksToBounds = true
    }
    
    private let generateRandomImageButton = UIButton(type: .system).then {
        $0.setTitle("랜덤 이미지 생성", for: .normal)
    }
    
    private let nameTextField = UITextField().then {
        $0.placeholder = "이름"
        $0.borderStyle = .roundedRect
    }
    
    private let numberTextField = UITextField().then {
        $0.placeholder = "전화번호"
        $0.borderStyle = .roundedRect
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        backgroundColor = .systemBackground
        
        [randomImageView,
         generateRandomImageButton,
         nameTextField,
         numberTextField
        ].forEach { addSubview($0) }
        
        randomImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(randomImageView.snp.width)
        }
        
        generateRandomImageButton.snp.makeConstraints {
            $0.top.equalTo(randomImageView.snp.bottom).offset(16)
            $0.width.equalTo(randomImageView).multipliedBy(0.8)
            $0.centerX.equalTo(randomImageView)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(generateRandomImageButton.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        numberTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        generateRandomImageButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        delegate?.didTapGenerateRandomImageButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        randomImageView.layer.cornerRadius = randomImageView.bounds.width / 2
    }
    
}
