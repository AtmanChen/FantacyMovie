//
//  HomeViewController.swift
//  Fantasy
//
//  Created by 突突兔 on 2019/2/19.
//  Copyright © 2019 突突兔. All rights reserved.
//

import UIKit
import NetworkPlatform
import RxCocoa
import RxSwift
import RxNuke
import Nuke
import RxDataSources
import Domain


class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let headerView = UINib(nibName: "HomeHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil).first! as! HomeHeaderView
    fileprivate let disposeBag = DisposeBag()
    fileprivate var viewModel: HomeViewModel!
    
    fileprivate lazy var dataSource: RxTableViewSectionedReloadDataSource<HomeFilmSectionModelType> = {
        return RxTableViewSectionedReloadDataSource<HomeFilmSectionModelType>(
            configureCell: { (ds, tb, indexPath, item) -> UITableViewCell in
                let now = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "d MMM yyyy"
                let filmToViewModelMapping: (OdeonFilm) -> ScrollerImageViewModel = { film -> ScrollerImageViewModel in
                    var description: String?
                    
                    if film.releaseDate.date > now {
                        description = "OUT " + dateFormatter.string(from: film.releaseDate.date).uppercased()
                    }
                    
                    return ScrollerImageViewModel(
                        title: film.title,
                        imageURL: film.posterImageUrl,
                        aspectRatio: .poster,
//                        tapAction: .openFilmDetails(film: film),
                        secondaryText: description,
                        halfRating: film.rating,
                        certificate: film.certificate
                    )
                }
                switch ds[indexPath] {
                case let .filmItem(films):
                    let largeItemWidth = UIScreen.main.bounds.width * 0.6
                    var largeItemSize = CGSize(width: largeItemWidth, aspectRatio: .poster)
                    largeItemSize.height += 90
                    let cell = tb.dequeueReusableNibCell(with: HorizonScrollerTableViewCell.self, for: indexPath)
                    let cellViewModel = HorizontalScrollerViewModel(itemSize: largeItemSize, contents: films.map(filmToViewModelMapping))
                    cell.configure(with: cellViewModel)
                    return cell
                case let .titleItem(title):
                    let cell = tb.dequeueReusableNibCell(with: TitleTableViewCell.self, for: indexPath)
                    cell.configure(with: title)
                    return cell
                case .copyRightItem:
                    let cell = tb.dequeueReusableNibCell(with: CopyTableViewCell.self, for: indexPath)
                    return cell
                }
            },
            titleForHeaderInSection: { ds, index in
                return ""
            }
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cinemaUseCase = UseCaseProvider().makeCinemaUseCase()
        let films = UseCaseProvider().makeFilmsUseCase()
        viewModel = HomeViewModel(cinemaFilmCase: cinemaUseCase, filmsCase: films)
        configureTableView()
        configureNavigation()
        bindViewModel()
    }

    fileprivate func configureTableView() {
        tableView.register(cellType: HorizonScrollerTableViewCell.self)
        tableView.register(cellType: TitleTableViewCell.self)
        tableView.register(cellType: CopyTableViewCell.self)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.refreshControl = {
            let refresh = UIRefreshControl()
            refresh.tintColor = UIColor(named: "PrimaryText")
            return refresh
        }()
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func configureNavigation() {
        
        // TODO: configure transparent navigation bar
        title = "Fantasy Movie"
    }
    
    fileprivate func bindViewModel() {
        
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let pull = tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let input = HomeViewModel.Input(trigger: Driver.merge(viewWillAppear, pull))
        let output = viewModel.transform(input: input)
        
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        output.cinemaFilm
            .drive(onNext: { film in
                print(film)
            })
            .disposed(by: disposeBag)
        
        let newFilmsSection = output.newFilms
            .asObservable()
            .map { SectionItem.filmItem(films: $0) }
            .map { [HomeFilmSectionModelType.filmSection(title: "New Films", film: [$0])] }
        
        let topFilmSection = output.topFilms
            .asObservable()
            .map { SectionItem.filmItem(films: $0) }
            .map { [HomeFilmSectionModelType.filmSection(title: "Top Films", film: [$0])] }
        
        let recommandedSection = output.recommanedFilms
            .asObservable()
            .map { SectionItem.filmItem(films: $0) }
            .map { [HomeFilmSectionModelType.filmSection(title: "Recommanded Films", film: [$0])] }
        
        let comingsoonSection = output.comingsoonFilms
            .asObservable()
            .map { SectionItem.filmItem(films: $0) }
            .map { [HomeFilmSectionModelType.filmSection(title: "Coming Soon Films", film: [$0])] }
        
        let films = Observable.concat(
            titleSectionMaker(title: "New Films"),
            newFilmsSection,
            titleSectionMaker(title: "Top Films"),
            topFilmSection,
            titleSectionMaker(title: "Recommanded Films"),
            recommandedSection,
            titleSectionMaker(title: "Comming soon Films"),
            comingsoonSection,
            copyRightSectionMaker()
            )
        
        films
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    private func titleSectionMaker(title: String) -> Observable<[HomeFilmSectionModelType]> {
        return Observable.just([.titleSection(title: .titleItem(title: title))])
    }
    
    private func copyRightSectionMaker() -> Observable<[HomeFilmSectionModelType]> {
        return Observable.just([.copyRightSection])
    }
}

extension HomeViewController: StoryboadLoadable {
    static var storyboardName: String {
        return "Home"
    }
}

enum HomeFilmSectionModelType {
    case filmSection(title: String, film: [SectionItem])
    case titleSection(title: SectionItem)
    case copyRightSection
}

enum SectionItem {
    case filmItem(films: [OdeonFilm])
    case titleItem(title: String)
    case copyRightItem
}

extension HomeFilmSectionModelType: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch self {
        case let .filmSection(_, items):
            return items
        case let .titleSection(titleItem):
            return [titleItem]
        default: return [.copyRightItem]
        }
    }
    
    init(original: HomeFilmSectionModelType, items: [Item]) {
        switch original {
        case let .filmSection(title, items):
            self = .filmSection(title: title, film: items)
        case let .titleSection(item):
            self = .titleSection(title: item)
        case .copyRightSection:
            self = .copyRightSection
        }
    }
}
