//
//  ContactListViewController.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/8/25.
//

import UIKit
import SnapKit
import Then

class ContactListViewController: UIViewController {
    
    private let viewModel = ContactListViewModel()
    
    private lazy var contactListTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(ContactListCell.self, forCellReuseIdentifier: ContactListCell.id)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.reloadCell()
        contactListTableView.reloadData()
    }

    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        title = "친구 목록"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "추가",
            style: .done,
            target: self,
            action: #selector(didTapAdd)
        )
        
        navigationItem.backButtonTitle = "Back"
        
        [
            contactListTableView
        ].forEach { view.addSubview($0) }
        
        contactListTableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func didTapAdd() {
        let vm = AddContactViewModel(mode: .create)
        let vc = AddContactViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contact = viewModel.contact(at: indexPath.row)
        let vm = AddContactViewModel(mode: .detail(model: contact))
        let vc = AddContactViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactListCell.id) as? ContactListCell else { return UITableViewCell() }
        let contact = viewModel.contact(at: indexPath.row)
        cell.configureCell(with: contact)
        return cell
    }
}

