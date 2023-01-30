//
//  MovieListViewController.swift
//  TrendingMoviesApp
//
//  Created by Igor Czarev on 27.12.2022.
//

import UIKit
import MovieNetworking

final class MovieListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var activityIndicatorView: UIActivityIndicatorView?
    
    var repo: MoviesRepo = MoviesRepo()
    
    var onShowDetails: ((MovieModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectionIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }
    
    private func startLoading() {
        showHud()
        repo.fetchMoviesList()
        repo.onSuccess = { [weak self] in
            self?.hideHud()
            self?.tableView.reloadData()
        }
    }
    
    private func showHud() {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.center = view.center
        tableView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        self.activityIndicatorView = activityIndicatorView
    }
    
    private func hideHud() {
        activityIndicatorView?.stopAnimating()
        activityIndicatorView?.removeFromSuperview()
    }
    
    private func showDetails(for model: MovieModel) {
        showHud()
        repo.fetchMovieDetails(with: "\(model.id)") { [weak self] result in
            self?.hideHud()
            switch result {
            case .failure(let error):
                print("Error fetching details - \(error.localizedDescription)")
            case .success(let model):
                self?.onShowDetails?(model)
            }
        }
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell" , for: indexPath)
        if let model = repo.model(for: indexPath) {
            cell.textLabel?.text = model.title
            cell.detailTextLabel?.text = dateFormatter.string(from: model.releaseDate ?? Date())
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = repo.model(for: indexPath) else { return }
        showDetails(for: model)
    }
}

let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    return dateFormatter
}()
