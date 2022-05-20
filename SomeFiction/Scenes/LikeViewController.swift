//
//  LikeViewController.swift
//  SomeFiction
//
//  Created by 장기화 on 2022/05/19.
//

import UIKit
import SnapKit

class LikeViewController: UIViewController {
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
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    @objc func tapCloseButton() {
        dismiss(animated: true)
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
        
        [closeButton, headlineLabel]
            .forEach { view.addSubview($0) }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        headlineLabel.snp.makeConstraints {
            $0.centerY.equalTo(closeButton)
            $0.centerX.equalToSuperview()
        }
    }
}
