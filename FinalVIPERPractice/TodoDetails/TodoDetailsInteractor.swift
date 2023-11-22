//
//  TodoDetailsInteractor.swift
//  FinalVIPERPractice
//
//  Created by Berkay Dişli on 21.11.2023.
//

import Foundation

protocol TodoDetailsInteractorProtocol {
    var presenter: TodoDetailsPresenterProtocol? { get set }

    var todo: Todo? { get set }
    
    func getTodoData()
}

class TodoDetailsInteractor: TodoDetailsInteractorProtocol {
    var presenter: TodoDetailsPresenterProtocol?
    
    var todo: Todo?
    
    func getTodoData() {
        presenter?.interactorDidUpdateData(todo: todo)
    }
}
