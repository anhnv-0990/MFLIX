//
//  SearchViewModel.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

struct SearchViewModel {
    let navigator: SearchNavigatorType
    let useCase: SearchUseCaseType
}

extension SearchViewModel: ViewModelType {
    struct Input {
        let textSearch: Driver<String>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let selectMovieTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let movies: Driver<[Movie]>
        let error: Driver<Error>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let isLoadingMore: Driver<Bool>
        let isEmpty: Driver<Bool>
        let movieSelected: Driver<Movie>
    }
    
    func transform(_ input: Input) -> Output {
        
        let loadTrigger = input.textSearch
            .distinctUntilChanged()
            .asDriver()
        
        let reloadTrigger = input.reloadTrigger
            .withLatestFrom(loadTrigger)
        
        let loadMoreTrigger = input.loadMoreTrigger
            .withLatestFrom(loadTrigger)
        
        let searchItems = getPage(loadTrigger: loadTrigger,
                                  reloadTrigger: reloadTrigger,
                                  loadMoreTrigger: loadMoreTrigger) { (query, page) in
                                    self.useCase.loadMoreMovie(query: query, page: page)
                                    
        }
        
        let (page, error, isLoading, isReloading, isLoadingMore) = searchItems.destructured
        
        let movies = page
            .map { $0.items }
        
        let movieSelected = input.selectMovieTrigger
            .withLatestFrom(movies) { $1[$0.row] }
            .do(onNext: {
                self.navigator.toMovieDetailScreen(movie: $0)
            })
        
        let isEmpty = movies
            .map{ $0.isEmpty }
            .distinctUntilChanged()
            
        return Output(movies: movies,
                      error: error,
                      isLoading: isLoading,
                      isReloading: isReloading,
                      isLoadingMore: isLoadingMore,
                      isEmpty: isEmpty,
                      movieSelected: movieSelected)
    }
}
