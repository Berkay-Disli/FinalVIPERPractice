//
//  TodoDetailsPresenter.swift
//  FinalVIPERPractice
//
//  Created by Berkay Dişli on 21.11.2023.
//

import Foundation

protocol TodoDetailsPresenterProtocol {
    var view: TodoDetailsViewProtocol? { get set }
    var interactor: TodoDetailsInteractorProtocol? { get set }
    var router: TodoDetailsRouterProtocol? { get set }
    
    func interactorDidUpdateData(todo: Todo?)
}

class TodoDetailsPresenter: TodoDetailsPresenterProtocol {
    var view: TodoDetailsViewProtocol?
    
    var interactor: TodoDetailsInteractorProtocol? {
        didSet {
            interactor?.getTodoData()
        }
    }
    
    var router: TodoDetailsRouterProtocol?
    
    func interactorDidUpdateData(todo: Todo?) {
        if let todo = todo {
            view?.update(with: todo)
        } else {
            view?.presentError("DEBUG todo is nil")
        }
    }
}
