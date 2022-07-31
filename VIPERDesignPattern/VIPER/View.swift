//
//  View.swift
//  VIPERDesignPattern
//
//  Created by Le Tong Minh Hieu on 30/07/2022.
//

import UIKit

// ViewController
// protocol
// reference presenter

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with users: [User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    var users: [User] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
        tableView.frame = view.bounds
    }
    
    func update(with users: [User]) {
        print("got users")
        self.users = users
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        users = []
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isHidden = true
            self?.label.isHidden = false
            self?.label.text = error
        }
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
}
