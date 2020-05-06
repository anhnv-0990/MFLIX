//
//  AppViewModel.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MGArchitecture

struct AppViewModel {
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType
}

extension AppViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let toMainTabBar: Driver<Void>
    }
    
    func transform(_ input: AppViewModel.Input) -> AppViewModel.Output {
        let toMainTabBar = input.loadTrigger
            .do(onNext: { _ in
                self.navigator.toMainTabBar()
            })
        
        return Output(
            toMainTabBar: toMainTabBar
        )
    }
}
