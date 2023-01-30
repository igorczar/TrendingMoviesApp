//
//  AppDelegate.swift
//  TrendingMoviesApp
//
//  Created by Igor Czarev on 27.12.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var appCoordinator: AppCoordinator!
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else { return true}
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        return true
    }
}

extension UIStoryboard {
    static func loadViewController(_ storyboardName: String, _ viewControllerId: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: viewControllerId)
    }
    
    static func loadMovieListVC() -> MovieListViewController? {
        loadViewController("Main", "MovieList") as? MovieListViewController
    }
    
    static func loadMovieDeatailsVC() -> MovieDetailsViewController? {
        loadViewController("Main", "MovieDetails") as? MovieDetailsViewController
    }
}
