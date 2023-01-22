//
//  UserDetailsViewModal.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2023-01-21.
//

import Foundation
import RxSwift

protocol UserDetailsViewModal {
    var userData: UserModel! { get }
    
    var name: BehaviorSubject<String> { get }
    var email: BehaviorSubject<String> { get }
    var phone: BehaviorSubject<String> { get }
}

class UserDetailsViewModalImp: UserDetailsViewModal {
    var userData: UserModel!

    var name = BehaviorSubject<String>(value: "")
    var email = BehaviorSubject<String>(value: "")
    var phone = BehaviorSubject<String>(value: "")
    
    init(userData: UserModel) {
        self.userData = userData
        setupObserver()
    }
    
    func setupObserver() {
        name.onNext((userData.name?.first ?? "") + " " + (userData.name?.last ?? ""))
        email.onNext(userData.email ?? "")
        phone.onNext(userData.phone ?? "")
    }
}
