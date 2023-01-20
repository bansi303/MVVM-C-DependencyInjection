//
//  UserDetailViewController.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2023-01-15.
//

import UIKit

class UserDetailViewController: UIViewController {

    var userData: UserModel?
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblName.text = (userData?.name?.first ?? "John") + " " + (userData?.name?.last ?? "Doe")
        lblEmail.text = userData?.email
        lblPhone.text = userData?.phone
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
