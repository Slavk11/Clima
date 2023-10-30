//
//  ViewController.swift
//  Clima
//
//  Created by Сазонов Станислав on 30.10.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: Constants.background)
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setupConstraints()

    }
    
    private func setView() {
        view.addSubview(backgroundImageView)
    }
}

extension ViewController {
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}
