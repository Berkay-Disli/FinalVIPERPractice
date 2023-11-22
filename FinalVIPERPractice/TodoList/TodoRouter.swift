//
//  TodoRouter.swift
//  FinalVIPERPractice
//
//  Created by Berkay Dişli on 21.11.2023.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }
    static func startExecution() -> AnyRouter
    
    func openTodoDetails(todo: Todo)
}

class TodoRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        let router = TodoRouter()
        let view = TodoViewController()
        let interactor = TodoInteractor()
        let presenter = TodoPresenter()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view
        
        return router
        
    }
    
    func openTodoDetails(todo: Todo) {
        let detailsRouter = TodoDetailsRouter.createDetailView(with: todo)
        guard let detailsVC = detailsRouter.entry else { return }
        guard let viewController = self.entry else { return }
        
        viewController.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
