//
//  LikeTableViewCell.swift
//  SomeFiction
//
//  Created by 장기화 on 2022/05/23.
//

import UIKit

class LikeTableViewCell: UITableViewCell {
    static let identifier = "LikeTableViewCell"
    
    private lazy var movieImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
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
        let view = UIStackView(arrangedSubviews: [titleLabel, directorLabel, actorLabel, ratingLabel])
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [movieImageView, stackView]
            .forEach { addSubview($0) }
        
        movieImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(8)
            $0.height.equalToSuperview().inset(8)
            $0.width.equalTo(60)
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
    }
    
    func update(_ movie: Movie) {
        let imageURL = URL(string: movie.image)
        movieImageView.kf.setImage(with: imageURL)
        titleLabel.text = movie.newTitle
        directorLabel.text = "감독: \(movie.newDirector)"
        actorLabel.text = "출연: \(movie.newActor)"
        ratingLabel.text = "평점: \(movie.userRating)"
        
        let defaults = UserDefaults.standard.bool(forKey: movie.newTitle)
        let imageName = defaults ? "star.fill" : "star"
        starButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc private func tapLikeButton() {
    }
}
