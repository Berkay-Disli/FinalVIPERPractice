//
//  TodoView.swift
//  FinalVIPERPractice
//
//  Created by Berkay Dişli on 21.11.2023.
//

import Foundation
import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with todos: [Todo])
    func presentError(_ error: Error)
}

class TodoViewController: UIViewController, AnyView {
    // MARK: - Properties
    var presenter: AnyPresenter?
    
    var todos: [Todo] = []
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        style()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

    // MARK: - UI
    private func style() {
        view.backgroundColor = .systemBackground
        
        title = "My Todo's"
        
        view.addSubview(mainTableView)
    }
    
    private func layout() {
        mainTableView.frame = view.bounds
    }
}

extension TodoViewController {
    func update(with todos: [Todo]) {
        DispatchQueue.main.async { [weak self] in
            self?.todos = todos
            self?.mainTableView.reloadData()
        }
    }
    
    func presentError(_ error: Error) {
        print("DEBUG error fetching todos: \(error)")
    }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didTapTodoDetails(todo: todos[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = todos[indexPath.row].title
        config.secondaryText = todos[indexPath.row].completed ? "Done":"In Progress"
        cell.contentConfiguration = config
        return cell
    }
}
