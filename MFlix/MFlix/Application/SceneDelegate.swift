//
//  SceneDelegate.swift
//  MFlix
//
//  Created by Viet Anh on 5/5/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private let disposeBag = DisposeBag()
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        bindViewModel()
    }
    
    private func bindViewModel() {
        guard let window = window else { return }
        let navigator = AppNavigator(window: window)
        let useCase = AppUseCase()
        let viewModel = AppViewModel(navigator: navigator, useCase: useCase)
        
        let input = AppViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input)
        output.toMainTabBar
            .drive()
            .disposed(by: disposeBag)
    }
    
}
