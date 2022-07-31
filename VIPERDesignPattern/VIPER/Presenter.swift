//
//  Presenter.swift
//  VIPERDesignPattern
//
//  Created by Le Tong Minh Hieu on 30/07/2022.
//

import Foundation

// Object
// protocol
// ref to interactor, router, view

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    
    var view: AnyView?

    func interactorDidFetchUsers(with result: Result<[User], Error>)  {
        switch result  {
        case .success(let users):
            view?.update(with: users)
        case .failure(let error):
            view?.update(with: "Something went wrong")
        }
    }
}
