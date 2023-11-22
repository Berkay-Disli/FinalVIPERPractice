//
//  TodoPresenter.swift
//  FinalVIPERPractice
//
//  Created by Berkay Dişli on 21.11.2023.
//

import Foundation

protocol AnyPresenter {
    var view: AnyView? { get set }
    var interactor: AnyInteractor? { get set }
    var router: AnyRouter? { get set }
    
    func interactorDidFetchTodos(result: Result<[Todo], Error>)
    
    func didTapTodoDetails(todo: Todo)
}

class TodoPresenter: AnyPresenter {
    
    var view: AnyView?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.fetchTodos()
        }
    }
    
    var router: AnyRouter?
    
    func interactorDidFetchTodos(result: Result<[Todo], Error>) {
        switch result {
        case .success(let todos):
            view?.update(with: todos)
        case .failure(let error):
            view?.presentError(error)
        }
    }
    
    func didTapTodoDetails(todo: Todo) {
        router?.openTodoDetails(todo: todo)
    }
    
}
