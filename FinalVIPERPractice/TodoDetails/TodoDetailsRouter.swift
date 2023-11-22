//
//  TodoDetailsRouter.swift
//  FinalVIPERPractice
//
//  Created by Berkay Dişli on 21.11.2023.
//

import Foundation
import UIKit

typealias TodoDetailEntryPoint = TodoDetailsViewProtocol & UIViewController

protocol TodoDetailsRouterProtocol {
    var entry: TodoDetailEntryPoint? { get }
    
    static func createDetailView(with todo: Todo) -> TodoDetailsRouterProtocol
}

class TodoDetailsRouter: TodoDetailsRouterProtocol {
    var entry: TodoDetailEntryPoint?
    
    static func createDetailView(with todo: Todo) -> TodoDetailsRouterProtocol {
        let router = TodoDetailsRouter()
        let view = TodoDetailsViewController()
        let interactor = TodoDetailsInteractor()
        let presenter = TodoDetailsPresenter()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.todo = todo
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view
        
        return router
    }
    
    
}
