//
//  ContactListViewController.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/8/25.
//

import UIKit
import SnapKit

class ContactListViewController: UIViewController {
    
    private let friendListLabel: UILabel = {
        let label = UILabel()
        label.text = "친구 목록"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추가", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.titleLabel?.textColor = .white
        return button
    }()
    
    private lazy var contactListTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactListCell.self, forCellReuseIdentifier: ContactListCell.id)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .systemBackground
        [
            friendListLabel,
            addButton,
            contactListTableView
        ].forEach { view.addSubview($0) }
        
        friendListLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.centerY.equalTo(friendListLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        contactListTableView.snp.makeConstraints {
            $0.top.equalTo(friendListLabel.snp.bottom).offset(40)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactListCell.id) as? ContactListCell else { return UITableViewCell() }
        cell.configureCell()
        return cell
    }
}

