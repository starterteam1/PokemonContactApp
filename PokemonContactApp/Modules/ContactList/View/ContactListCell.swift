//
//  ContactListCell.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/8/25.
//

import UIKit

final class ContactListCell: UITableViewCell {
    
    static let id = "ContactListCell"
    
    private let contactImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.systemGray.cgColor
        $0.layer.masksToBounds = true
    }
    
    private let nameLabel = UILabel().then { _ in }
    
    private let numberLabel = UILabel().then { _ in }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [   contactImageView,
            nameLabel,
            numberLabel
        ].forEach { contentView.addSubview($0)}
        
        contactImageView.snp.makeConstraints {
            $0.size.equalTo(contentView.snp.height).multipliedBy(0.7)
            $0.leading.equalToSuperview().inset(40)
            $0.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(contactImageView.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
        }
        
        numberLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(40)
            $0.centerY.equalToSuperview()
        }
    }
    
    public func configureCell(with model: ContactModel) {
        if let image = model.image {
            contactImageView.image = UIImage(data: image)
        }
        nameLabel.text = model.name
        numberLabel.text = model.phoneNumber
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contactImageView.layer.cornerRadius = contactImageView.bounds.width / 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contactImageView.image = nil
    }
}
