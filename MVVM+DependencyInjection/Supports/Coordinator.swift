//
//  Coordinator.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-07-05.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var rootViewController: UIViewController { get set }
    
    func start()
}
