//
//  WatchNowUseCase.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol WatchNowUseCaseType {
    func getUpcomingMovies() -> Observable<[Movie]>
    func getTopRatedMovies() -> Observable<[Movie]>
    func getPopularMovies() -> Observable<[Movie]>
    func getNowPlayingMovies() -> Observable<[Movie]>
}

struct WatchNowUseCase: WatchNowUseCaseType {
    
    func getUpcomingMovies() -> Observable<[Movie]> {
        let request = UpcomingRequest(page: 1)
        let repository = WatchNowRepository()
        return repository.getUpcomingMovies(input: request)
    }
    
    func getTopRatedMovies() -> Observable<[Movie]> {
        let request = TopRatedRequest(page: 1)
        let repository = WatchNowRepository()
        return repository.getTopRatedMovies(input: request)
        
    }
    
    func getPopularMovies() -> Observable<[Movie]> {
        let request = PopularRequest(page: 1)
        let repository = WatchNowRepository()
        return repository.getPopularMovies(input: request)
        
    }
    
    func getNowPlayingMovies() -> Observable<[Movie]> {
        let request = NowPlayingRequest(page: 1)
        let repository = WatchNowRepository()
        return repository.getNowPlayingMovies(input: request)
        
    }
}
