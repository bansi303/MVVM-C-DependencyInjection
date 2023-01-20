//
//  MVVM_DependencyInjectionTests.swift
//  MVVM+DependencyInjectionTests
//
//  Created by Bansi Hirpara on 2022-07-10.
//

import XCTest
@testable import MVVM_DependencyInjection

class MVVM_DependencyInjectionTests: XCTestCase {
    
    var userViewModel: UserViewModel?
    var dataProvider: DataProviderImp?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataProvider = DataProviderImp(userService: UserServiceMockObject())
        userViewModel = UserViewModel.init(dataProvider: dataProvider!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        userViewModel = nil
        dataProvider = nil
    }
    
    func testUserServiceMock() {
        dataProvider!.getUsers { userDatas, err in
            let firstObject = userDatas.first
            XCTAssertEqual(firstObject?.email, "jivan.arendse@example.com")
        }
    }
    
    func testUserViewControllerTableData() {
        let expectation = expectation(description: "Fetch data from service and set tableview")
        userViewModel!.getUsers { userDatas, err in
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertEqual(userViewModel!.userList?.count, 1)
        XCTAssertEqual(userViewModel!.userList?.first?.name?.first, "Jivan")
    }
}

class UserServiceMockObject: UserService, Mockable  {
    func getAllUsers(completionHnadler: @escaping (UserDatas?, String) -> ()) {
        let userDatas = loadJSON(filename: "user_data_response", type: UserDatas.self)
        completionHnadler(userDatas, "")
    }
}
