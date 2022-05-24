//
//  MainViewController.swift
//  SomeFiction
//
//  Created by 장기화 on 2022/05/19.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    private let shared = MovieManager.shared
    let networkManager = NetworkManager()
    var searchText = "국가"
    
    private lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.text = "네이버 영화 검색"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setTitle(" ⭐️ 즐겨찾기 ", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(gray: 0.9, alpha: 1)
        button.addTarget(self, action: #selector(tapFavoriteButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.delegate = self
        bar.text = searchText
        bar.searchBarStyle = .minimal
        return bar
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        view.keyboardDismissMode = .onDrag
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            layout()
            await movieFetch(searchText: searchText)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func tapFavoriteButton() {
        let vc = UINavigationController(rootViewController: LikeViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func movieFetch(searchText: String) async {
        let data = await networkManager.getMovies(searchText: searchText)
        switch data {
        case .success(let result):
            shared.movieList = result.items
            tableView.reloadData()
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    private func layout() {
        title = ""
        
        [headlineLabel, likeButton, dividerView, searchBar, tableView]
            .forEach { view.addSubview($0) }
        
        headlineLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        likeButton.snp.makeConstraints {
            $0.centerY.equalTo(headlineLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(headlineLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shared.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell
        else { return UITableViewCell() }
        cell.update(shared.movieList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMovieViewController(movie: shared.movieList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Task {
            await movieFetch(searchText: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
