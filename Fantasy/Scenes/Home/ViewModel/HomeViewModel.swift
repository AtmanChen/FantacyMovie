//
//  HomeViewModel.swift
//  Fantasy
//
//  Created by 突突兔 on 2019/2/19.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import Domain

final class HomeViewModel: ViewModelType {
    
    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let cinemaFilm: Driver<OdeonFilmInCinema.Film>
        let newFilms: Driver<[OdeonFilm]>
        let topFilms: Driver<[OdeonFilm]>
        let recommanedFilms: Driver<[OdeonFilm]>
        let comingsoonFilms: Driver<[OdeonFilm]>
    }
    
    private let cinemaFilmCase: CinemaUseCase
    private let filmsCase: FilmsUseCase
    
    init(cinemaFilmCase: CinemaUseCase, filmsCase: FilmsUseCase) {
        self.cinemaFilmCase = cinemaFilmCase
        self.filmsCase = filmsCase
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let filmData = input.trigger
            .flatMapLatest { _ in
                return Observable.zip(self.cinemaFilmCase.cinemaFilm(),
                        self.filmsCase.newFilms(),
                        self.filmsCase.topFilms(),
                        self.filmsCase.recommendedFilms(),
                        self.filmsCase.comingSoonFilms())
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        let cinemaFilm = filmData
            .map { argu -> OdeonFilmInCinema.Film in
                let (cinema, _, _, _, _) = argu
                return cinema.first!.film
            }
        
        let newFilms = filmData
            .map { argu -> [OdeonFilm] in
                let (_, news, _, _, _) = argu
                return news
            }
            
        let topFilms = filmData
            .map { argu -> [OdeonFilm] in
                let (_, _, top, _, _) = argu
                return top
            }
        
        let recommandedFilms = filmData
            .map { argu -> [OdeonFilm] in
                let (_, _, _, recommanded, _) = argu
                return recommanded
            }

        let commingsoonFilms = filmData
            .map { argu -> [OdeonFilm] in
                let (_, _, _, _, comingsoon) = argu
                return comingsoon
            }
        
        let fetching = activityIndicator.asDriver()
        return Output(fetching: fetching,
                      cinemaFilm: cinemaFilm,
                      newFilms: newFilms,
                      topFilms: topFilms,
                      recommanedFilms: recommandedFilms,
                      comingsoonFilms: commingsoonFilms)
    }
}
