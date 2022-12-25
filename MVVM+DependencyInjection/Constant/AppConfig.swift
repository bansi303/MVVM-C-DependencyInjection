//
//  AppConfig.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-06-07.
//

import Foundation

enum AppEnvironment {
    case development
    case production
}

struct AppConfig {
#if DEBUG
    static let environment = AppEnvironment.development
#else
    static let environment = AppEnvironment.production
#endif
}

