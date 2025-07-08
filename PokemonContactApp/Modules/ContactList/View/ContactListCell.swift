//
//  ContactListCell.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/8/25.
//

import UIKit

final class ContactListCell: UITableViewCell {
    
    static let id = "ContactListCell"
    
    private let contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
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
            $0.size.equalTo(50)
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
    
    public func configureCell() {
        nameLabel.text = "김이든"
        numberLabel.text = "010-0000-0000"
    }
}
