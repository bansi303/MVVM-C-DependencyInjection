//
//  UserDetailViewController.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2023-01-15.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    var userDetailsViewModal: UserDetailsViewModal!
    
    func configure(with userDetailsViewModal: UserDetailsViewModal) {
        self.userDetailsViewModal = userDetailsViewModal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblName.text = userDetailsViewModal.name
        lblEmail.text = userDetailsViewModal.email
        lblPhone.text = userDetailsViewModal.phone
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
