//
//  AppCoordinator.swift
//  Flickr
//
//  Created by Erdi Tunçalp on 25.03.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import XCoordinator

enum AppRoute: Route {
    case home
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    
    private var home: Presentable?
    
    init() {
        super.init(initialRoute: .home)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .home:
            let home = HomeViewController()
            home.bind(to: HomeViewModelImpl(router: anyRouter))
            return .present(home)
        }
    }
    
}
