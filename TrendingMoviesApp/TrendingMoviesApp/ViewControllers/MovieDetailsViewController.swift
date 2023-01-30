//
//  MovieDetailsViewController.swift
//  TrendingMoviesApp
//
//  Created by Igor Czarev on 27.12.2022.
//

import UIKit
import MovieNetworking

final class MovieDetailsViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    
    var model: MovieModel? {
        didSet {
            if isViewLoaded {
                titleLabel.text = model?.title
                dateLabel.text = dateFormatter.string(from: model?.releaseDate ?? Date())
                overviewLabel.text = model?.overview
            }
        }
    }
}
