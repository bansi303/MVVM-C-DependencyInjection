//
//  ViewController.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-06-04.
//

import UIKit

class UsersViewController: UIViewController {
    
    var viewModel: UserViewModel!
    var tableViewCellMake: DependencyRegister.UserTableViewCellMaker!
    var detailsVcMaker: DependencyRegister.UserDetailViewControllerMaker!
    var appCoordinator: UsersCoordinator!
    
    @IBOutlet weak var tblViewUsers: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.getUsers() { resStatus, error in
            if resStatus {
                self.tblViewUsers.reloadData()
            }
        }
    }
    
    func configure(with userViewModal: UserViewModel, tableViewCellMake: @escaping DependencyRegister.UserTableViewCellMaker, detailsVcMaker: @escaping DependencyRegister.UserDetailViewControllerMaker) {
        self.viewModel = userViewModal
        self.tableViewCellMake = tableViewCellMake
        self.detailsVcMaker = detailsVcMaker
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singleData = viewModel.userList[indexPath.row]
        let cell = tableViewCellMake(tableView, indexPath, singleData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let singleData = viewModel.userList[indexPath.row]
        let detailViewController = detailsVcMaker(singleData)
        navigationController?.pushViewController(detailViewController, animated: true)
//        appCoordinator.goToUserDetailsViewController(userData: singleData)
    }
}

class UsersTableViewCell: UITableViewCell {
    @IBOutlet weak var imgViewUserProfilePic: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    func configure(with userModal: UserModel) {
        if let strURL = userModal.picture?.medium, let url = URL(string: strURL) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.imgViewUserProfilePic.image = UIImage(data: data!)
                }
            }
        }
        lblUserName.text = (userModal.name?.first ?? " ") + " " + (userModal.name?.last ?? " ")
    }
}

