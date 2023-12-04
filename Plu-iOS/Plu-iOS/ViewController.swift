//
//  ViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/11/26.
//

import UIKit

class ViewController: UIViewController {
    
    private let testLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트라벨의텍스트입니다"
        label.font = .suite(.head1)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(testLabel)
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        testLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        testLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

