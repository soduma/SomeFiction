//
//  LikeViewController.swift
//  SomeFiction
//
//  Created by 장기화 on 2022/05/19.
//

import UIKit
import SnapKit

class LikeViewController: UIViewController {
    private let shared = MovieManager.shared
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 24, weight: .light), forImageIn: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.text = "즐겨찾기 목록"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(LikeTableViewCell.self, forCellReuseIdentifier: LikeTableViewCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func tapCloseButton() {
        dismiss(animated: true)
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
        
        [closeButton, headlineLabel, tableView]
            .forEach { view.addSubview($0) }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        
        headlineLabel.snp.makeConstraints {
            $0.centerY.equalTo(closeButton)
            $0.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headlineLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension LikeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shared.likeMovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        LikeTableViewCell.identifier, for: indexPath) as? LikeTableViewCell
        else { return UITableViewCell() }
        cell.update(shared.likeMovieList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMovieViewController(movie: shared.likeMovieList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
