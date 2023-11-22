//
//  TodoInteractor.swift
//  FinalVIPERPractice
//
//  Created by Berkay Dişli on 21.11.2023.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func fetchTodos()
}

class TodoInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func fetchTodos() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                self?.presenter?.interactorDidFetchTodos(result: .failure(error))
            } else {
                guard let data = data else { return }
                do {
                    let todos = try JSONDecoder().decode([Todo].self, from: data)
                    let prefixedTodos = Array(todos.prefix(20))
                    self?.presenter?.interactorDidFetchTodos(result: .success(prefixedTodos))
                } catch {
                    self?.presenter?.interactorDidFetchTodos(result: .failure(error))
                }
            }
        }
        
        task.resume()
        
    }
}
