//
//  MovieTableViewCell.swift
//  SomeFiction
//
//  Created by 장기화 on 2022/05/20.
//

import UIKit
import SnapKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    
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
    
    private lazy var starLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, directorLabel, actorLabel, starLabel])
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [movieImageView,// titleLabel, directorLabel, actorLabel, starLabel
        stackView]
            .forEach { addSubview($0) }
        
        movieImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(8)
            $0.height.equalTo(100)
            $0.width.equalTo(60)
        }
        
//        titleLabel.snp.makeConstraints {
//            $0.top.equalTo(movieImageView)
//            $0.leading.equalTo(movieImageView.snp.trailing)
//            $0.trailing.equalToSuperview()
//        }
//
//        directorLabel.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom)
//            $0.leading.equalTo(titleLabel)
//            $0.trailing.equalToSuperview()
//        }
//
//        actorLabel.snp.makeConstraints {
//            $0.top.equalTo(directorLabel.snp.bottom)
//            $0.leading.equalTo(titleLabel)
//            $0.trailing.equalToSuperview()
//        }
//
//        starLabel.snp.makeConstraints {
//            $0.top.equalTo(actorLabel.snp.bottom)
//            $0.leading.equalTo(titleLabel)
//            $0.trailing.equalToSuperview()
//            $0.bottom.equalTo(movieImageView)
//        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(movieImageView)
            $0.leading.equalTo(movieImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(movieImageView)
        }
    }
    
    func update(_ movie: Movie) {
        let imageURL = URL(string: movie.image)
        movieImageView.kf.setImage(with: imageURL)
        titleLabel.text = movie.newTitle
        directorLabel.text = "감독: \(movie.newDirector)"
        actorLabel.text = "출연: \(movie.newActor)"
        starLabel.text = "평점: \(movie.userRating)"
    }
}
