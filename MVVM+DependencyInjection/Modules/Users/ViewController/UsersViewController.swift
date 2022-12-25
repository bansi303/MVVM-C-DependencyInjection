//
//  ViewController.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-06-04.
//

import UIKit

class UsersViewController: UIViewController {
    
    var viewModel: UserViewModel!
    
    @IBOutlet weak var tblViewUsers: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpViewModel()
    }
    
    func setUpViewModel() {
        viewModel = UserViewModel(userService: UserServiceObject())
        viewModel.getUsers() { resStatus, error in
            if resStatus {
                self.tblViewUsers.reloadData()
            }
        }
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as! UsersTableViewCell
        let singleData = viewModel.userList?[indexPath.row]
        cell.cellData = singleData
        return cell
    }
}

class UsersTableViewCell: UITableViewCell {
    @IBOutlet weak var imgViewUserProfilePic: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    var cellData: UserModel? {
        didSet {
            if let strURL = cellData?.picture?.medium, let url = URL(string: strURL) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.imgViewUserProfilePic.image = UIImage(data: data!)
                    }
                }
            }
            lblUserName.text = (cellData?.name?.first ?? " ") + " " + (cellData?.name?.last ?? " ")
        }
    }
}

