//
//  UserModel.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-07-05.
//

import Foundation

struct UserDatas: Codable {
    var results: [UserModel]?
}

struct UserModel: Codable {
    var gender: String?
    var name: Name?
    var email: String?
    var dob: DOB?
    var phone: String?
    var picture: ProfilePicture?
    
    enum CodingKeys: String, CodingKey {
        case gender, name, email, dob, phone, picture
    }
}

struct Name: Codable {
    var title: String?
    var first: String?
    var last: String?
}

struct DOB: Codable {
    var date: String?
    var age: Int?
}

struct ProfilePicture: Codable {
    var large: String?
    var medium: String?
    var thumbnail: String?
}
