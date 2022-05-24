//
//  DetailMovieViewController.swift
//  SomeFiction
//
//  Created by 장기화 on 2022/05/20.
//

import UIKit
import WebKit
import SnapKit
import Kingfisher

class DetailMovieViewController: UIViewController {
    private let movie: Movie
    
    private lazy var movieImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var actorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [directorLabel, actorLabel, ratingLabel])
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var starButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemYellow
        button.addTarget(self, action: #selector(tapLikeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.navigationDelegate = self
        return view
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemOrange
        return indicator
    }()
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    private func layout() {
        title = movie.newTitle
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        
        [movieImageView, stackView, webView, indicator]
            .forEach { view.addSubview($0) }
        
        movieImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(8)
            $0.height.equalTo(100)
            $0.width.equalTo(70)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(movieImageView)
            $0.leading.equalTo(movieImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(movieImageView)
        }
        
        stackView.addSubview(starButton)
        starButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(8)
        }
        
        webView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        indicator.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        let imageURL = URL(string: movie.image)
        movieImageView.kf.setImage(with: imageURL)
        directorLabel.text = "감독: \(movie.newDirector)"
        actorLabel.text = "출연: \(movie.newActor)"
        ratingLabel.text = "평점: \(movie.userRating)"
        
        let imageName = movie.isLiked ? "star.fill" : "star"
        starButton.setImage(UIImage(systemName: imageName), for: .normal)
        
        guard let url = URL(string: movie.link) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @objc private func tapLikeButton() {
    }
}

extension DetailMovieViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}
