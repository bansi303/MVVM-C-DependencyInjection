//
//  ViewController.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-06-04.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class UsersViewController: UIViewController, UITableViewDelegate {
    var viewModel: UserViewModel!
    var tableViewCellMake: DependencyRegister.UserTableViewCellMaker!
    var usersCoordinator: UsersCoordinator!
    fileprivate var dataSource: RxTableViewSectionedReloadDataSource<TableViewCustomData>!
    fileprivate var bag = DisposeBag()
    
    @IBOutlet weak var tblViewUsers: UITableView!
    
    func configure(with userViewModal: UserViewModel, tableViewCellMake: @escaping DependencyRegister.UserTableViewCellMaker, usersCoordinator: UsersCoordinator) {
        self.viewModel = userViewModal
        self.tableViewCellMake = tableViewCellMake
        self.usersCoordinator = usersCoordinator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initDataSource()
        initTableView()
        
        viewModel.getUsers() { resStatus, error in
            if resStatus {
                self.tblViewUsers.reloadData()
            }
        }
    }
    
    func initTableView() {
        viewModel.userCustomList.asObserver()
            .bind(to: tblViewUsers.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        tblViewUsers.rx.itemSelected.map { indexPath in
            return (indexPath, self.dataSource[indexPath])
        }.subscribe { [weak self] indexPath, userModal in
            self?.usersCoordinator.goToUserDetailsViewController(userData: userModal)
        }.disposed(by: bag)

        tblViewUsers.rx.setDelegate(self).disposed(by: bag)
    }
    
    func initDataSource() {
        dataSource = RxTableViewSectionedReloadDataSource<TableViewCustomData>.init(configureCell: { [unowned self] _, tableView, indexPath, userModal in
            let cell = tableViewCellMake(tableView, indexPath, userModal)
            return cell
        })
    }
}

class UsersTableViewCell: UITableViewCell {
    @IBOutlet weak var imgViewUserProfilePic: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    func configure(with userTableViewCellViewModal: UserTableViewCellViewModal) {
        if let strURL = userTableViewCellViewModal.profilePicStr, let url = URL(string: strURL) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.imgViewUserProfilePic.image = UIImage(data: data!)
                }
            }
        }
        lblUserName.text = userTableViewCellViewModal.name
    }
}
