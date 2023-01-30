//
//  AppCoordinator.swift
//  TrendingMoviesApp
//
//  Created by Igor Czarev on 27.12.2022.
//

import UIKit
import MovieNetworking

final class AppCoordinator {
    
    private let window: UIWindow
    private var router: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        guard let vc = UIStoryboard.loadMovieListVC() else { return }
        vc.title = "Trending Movies"
        router = UINavigationController()
        router?.setViewControllers([vc], animated: true)
        window.rootViewController = router
        vc.onShowDetails = { [weak self] model in
            self?.showDetails(model)
        }
        window.makeKeyAndVisible()
    }
    
    private func showDetails(_ model: MovieModel) {
        guard let vc = UIStoryboard.loadMovieDeatailsVC() else { return }
        vc.loadViewIfNeeded()
        vc.model = model
        router?.pushViewController(vc, animated: true)
    }
}
