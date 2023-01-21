//
//  DependencyRegister.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2023-01-21.
//

import Foundation
import UIKit
import Swinject

protocol DependencyRegister {
    var container: Container { get }
    
    typealias UserTableViewCellMaker = (UITableView, IndexPath, UserModel) -> UsersTableViewCell
    func makeUserTableViewCell(for tableView: UITableView, at indexPath: IndexPath, userModal: UserModel) -> UsersTableViewCell
    
    typealias UserDetailViewControllerMaker = (UserModel) -> UserDetailViewController
    func makeUserDetailViewController(with userModal: UserModel) -> UserDetailViewController
    
}

class DependencyRegisterImp: DependencyRegister {
    var container: Container
    
    init(container: Container) {
        Container.loggingFunction = nil
        self.container = container
        
        registerDepencies()
        registerModals()
        registerViewControllers()
    }
    
    func registerDepencies() {
        container.register(UserService.self) { _ in UserServiceObject() }.inObjectScope(.container)
        container.register(CoreDataHelper.self) { _ in CoreDataHelperImp() }.inObjectScope(.container)
        container.register(UserTranslator.self) { _ in UserTranslatorImp() }.inObjectScope(.container)
        
        container.register(Transalation.self) { r in
            TransalationImp(userTranslator: r.resolve(UserTranslator.self)!)
        }.inObjectScope(.container)
        
        container.register(DataProvider.self) { r in
            DataProviderImp(userService: r.resolve(UserService.self)!, coreDataHelper: r.resolve(CoreDataHelper.self)!, translation: r.resolve(Transalation.self)!)
        }
    }
    
    func registerModals() {
        container.register(UserViewModel.self) { r in UserViewModelImp(dataProvider: r.resolve(DataProvider.self)!) }
        container.register(UserDetailsViewModal.self) { (r, user: UserModel) in UserDetailsViewModalImp(userData: user) }
        container.register(UserTableViewCellViewModal.self) { (r, user: UserModel) in UserTableViewCellViewModalImp(userData: user) }
    }
    
    func registerViewControllers() {
        container.register(UserDetailViewController.self) { (r, user: UserModel) in
            let viewModal = r.resolve(UserDetailsViewModal.self, argument: user)!
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
            vc.configure(with: viewModal)
            return vc
        }
    }
    
    func makeUserTableViewCell(for tableView: UITableView, at indexPath: IndexPath, userModal: UserModel) -> UsersTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as! UsersTableViewCell
        cell.configure(with: userModal)
        return cell
    }
    
    func makeUserDetailViewController(with userModal: UserModel) -> UserDetailViewController {
        return container.resolve(UserDetailViewController.self, argument: userModal)!
    }
}
