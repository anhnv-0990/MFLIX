//
//  AppNavigator.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Then

protocol AppNavigatorType {
    func toMainTabBar()
}

struct AppNavigator: AppNavigatorType {
    unowned let window: UIWindow
    
    func toMainTabBar() {
        //MARK: - Watch Now
        let watchNowViewController = WatchNowViewController.instantiate()
        let watchNowNavigationController = UINavigationController(rootViewController: watchNowViewController).then {
            $0.tabBarItem = UITabBarItem(title: Constants.watchNowString,
                                         image: Constants.watchNowIcon,
                                         selectedImage: Constants.watchNowFilled)
        }
        let watchNowNavigator = WatchNowNavigator(navigationController: watchNowNavigationController)
        let watchNowUseCase = WatchNowUseCase()
        let watchNowViewModel = WatchNowViewModel(navigator: watchNowNavigator, useCase: watchNowUseCase)
        watchNowViewController.bindViewModel(to: watchNowViewModel)
        
        //MARK: - Favorite
        let favoriteViewController = FavoriteViewController.instantiate()
        let favoriteNavigationController = UINavigationController(rootViewController: favoriteViewController).then {
            $0.tabBarItem = UITabBarItem(title: Constants.favoriteString,
                                         image: Constants.favoriteIcon,
                                         selectedImage: Constants.favoriteFilled)
        }
        let favoriteNavigator = FavoriteNavigator(navigationController: favoriteNavigationController)
        let favoriteUseCase = FavoriteUseCase()
        let favoriteViewModel = FavoriteViewModel(navigator: favoriteNavigator, useCase: favoriteUseCase)
        favoriteViewController.bindViewModel(to: favoriteViewModel)
        
        //MARK: - Search
        let searchViewController = SearchViewController.instantiate()
        let searchNavigationController = UINavigationController(rootViewController: searchViewController).then {
            $0.tabBarItem = UITabBarItem(title: Constants.searchString,
                                         image: Constants.searchIcon,
                                         selectedImage: Constants.searchFilled)
        }
        let searchNavigator = SearchNavigator(navigationController: searchNavigationController)
        let searchUseCase = SearchUseCase()
        let searchViewModel = SearchViewModel(navigator: searchNavigator, useCase: searchUseCase)
        searchViewController.bindViewModel(to: searchViewModel)
        
        //MARK: - TabBar
        let mainTabBarController = UITabBarController().then {
            $0.viewControllers = [watchNowNavigationController,
                                  favoriteNavigationController,
                                  searchNavigationController]
        }
        
        window.rootViewController = mainTabBarController
        window.makeKeyAndVisible()
    }
}
