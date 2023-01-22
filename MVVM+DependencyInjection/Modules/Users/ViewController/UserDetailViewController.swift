//
//  UserDetailViewController.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2023-01-15.
//

import UIKit
import RxSwift

class UserDetailViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    var userDetailsViewModal: UserDetailsViewModal!
    fileprivate var bag = DisposeBag()
    
    func configure(with userDetailsViewModal: UserDetailsViewModal) {
        self.userDetailsViewModal = userDetailsViewModal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDetailsViewModal.name.asObservable().bind(to: lblName.rx.text).disposed(by: bag)
        userDetailsViewModal.email.asObservable().bind(to: lblEmail.rx.text).disposed(by: bag)
        userDetailsViewModal.phone.asObservable().bind(to: lblPhone.rx.text).disposed(by: bag)
        
//        let textField = UITextField()
//        textField.rx.text.orEmpty.asObservable().bind(to: userDetailsViewModal.name).disposed(by: bag)
//        userDetailsViewModal.name.asObservable().bind(to: textField.rx.text).disposed(by: bag)
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
