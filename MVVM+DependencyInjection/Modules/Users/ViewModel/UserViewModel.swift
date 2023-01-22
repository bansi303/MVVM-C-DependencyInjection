//
//  UserViewModel.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-07-05.
//

import Foundation
import RxSwift
import RxDataSources

typealias BlockWithResult = (Bool, String?) -> ()

protocol UserViewModel {
    var userCustomList: PublishSubject<[TableViewCustomData]> { get }
    func getUsers(completionHandler: @escaping BlockWithResult)
}

struct TableViewCustomData: SectionModelType {
    var header: String
    var items: [Item]
}

extension TableViewCustomData {
    typealias Item = UserModel
    
    init(original: TableViewCustomData, items: [UserModel]) {
        self = original
        self.items = items
    }
}

class UserViewModelImp: UserViewModel {
    var userList = PublishSubject<[UserModel]>()
    var userCustomList = PublishSubject<[TableViewCustomData]>()
    
    private let dataProvider: DataProvider!
    fileprivate var bag = DisposeBag()
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        setupObserver()
    }
    
    func setupObserver() {
        userList.asObserver().subscribe { [weak self] userData in
            self?.updateTableView(with: userData)
        }.disposed(by: bag)
    }
    
    func updateTableView(with userModals: [UserModel]) {
        userCustomList.onNext([TableViewCustomData(header: "", items: userModals)])
    }
    
    func getUsers(completionHandler: @escaping BlockWithResult) {
        dataProvider.getUsers { [unowned self] userData, error in
            userList.onNext(userData)
            completionHandler((error == ""), error)
        }
    }
}
