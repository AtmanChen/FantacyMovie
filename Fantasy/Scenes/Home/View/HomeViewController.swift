//
//  HomeViewController.swift
//  Fantasy
//
//  Created by 突突兔 on 2019/2/19.
//  Copyright © 2019 突突兔. All rights reserved.
//

import UIKit
import NetworkPlatform
import RxSwift
import RxNuke
import Nuke

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let headerView = UIImageView()
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    fileprivate func configureTableView() {
        tableView.addSubview(refreshControl)
        tableView.addSubview(headerView)
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 300)
        tableView.tableFooterView = UIView()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc
    fileprivate func refresh() {
        let cinemaNetwork = NetworkProvider().makeCinemaFilmNetwork()
        cinemaNetwork
            .getCinemaFilm()
            .observeOn(MainScheduler.instance)
            .do(onNext: { _ in
                self.refreshControl.endRefreshing()
            })
            .flatMap { Nuke.ImagePipeline.shared.rx.loadImage(with: $0.first!.film.imageURL) }
            .map { $0.image }
            .bind(to: headerView.rx.image)
            .disposed(by: disposeBag)
        
    }
}
