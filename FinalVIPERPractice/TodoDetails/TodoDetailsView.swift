//
//  TodoDetailsView.swift
//  FinalVIPERPractice
//
//  Created by Berkay Dişli on 21.11.2023.
//

import Foundation
import UIKit

protocol TodoDetailsViewProtocol {
    var presenter: TodoDetailsPresenterProtocol? { get set }
    
    func update(with todo: Todo)
    func presentError(_ error: String)
}

class TodoDetailsViewController: UIViewController, TodoDetailsViewProtocol {
    var presenter: TodoDetailsPresenterProtocol?
    
    private var todo: Todo?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let isCompletedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }

    
    private func style() {
        view.backgroundColor = .systemBackground
        title = "Details"

        view.addSubview(titleLabel)
        view.addSubview(isCompletedLabel)
    }
    
    private func layout() {
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        isCompletedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        isCompletedLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        
        print("DEBUG layout?")
    }
}

extension TodoDetailsViewController {
    func update(with todo: Todo) {
        print("DEBUG inside update")
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = todo.title
            self?.isCompletedLabel.text = todo.completed ? "Completed!":"Not completed yet :)"
        }
    }
    
    func presentError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
