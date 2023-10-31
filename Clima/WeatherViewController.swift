//
//  ViewController.swift
//  Clima
//
//  Created by Сазонов Станислав on 30.10.2023.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: Constants.background)
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 10
        element.alignment = .trailing
        return element
    }()
    
    private lazy var headerStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.alignment = .fill
        element.distribution = .fill
        return element
    }()
    
    private lazy var geoButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(systemName: Constants.geoSF), for: .normal)
        element.tintColor = .label
        return element
    }()
    
    private lazy var searchTextField: UITextField = {
        let element = UITextField()
        element.placeholder = Constants.search
        element.borderStyle = .roundedRect
        element.textAlignment = .right
        element.font = .systemFont(ofSize: 25)
        element.textColor = .label
        element.textColor =  .label
        element.backgroundColor = .systemFill
        return element
    }()
    
    private lazy var searchButton: UIButton = {
        let element = UIButton()
        element.setBackgroundImage(UIImage(systemName: Constants.searchSF), for: .normal)
        element.tintColor = .label
        return element
    }()
    
    private lazy var coditionalImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: Constants.coditionSF)
        element.tintColor = UIColor(named: Constants.weatherColor)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var tempStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        return element
    }()
    
    private lazy var tempLabel: UILabel = {
        let element = UILabel()
        element.tintColor = .label
        element.font = .systemFont(ofSize: 80, weight: .black)
        return element
    }()
    
    private lazy var tempTypeLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 100, weight: .light)
        element.tintColor = .label
        return element
    }()
    
    private lazy var cityLabel: UILabel = {
        let element = UILabel()
        element.tintColor = .label
        element.font = .systemFont(ofSize: 30)
        return element
    }()
    
    let emptyView = UIView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setupConstraints()

    }
    
    // MARK: - Setup Views
    
    private func setView() {
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(headerStackView)
        
        headerStackView.addArrangedSubview(geoButton)
        headerStackView.addArrangedSubview(searchTextField)
        headerStackView.addArrangedSubview(searchButton)
        
        mainStackView.addArrangedSubview(coditionalImageView)
        mainStackView.addArrangedSubview(tempStackView)
        
        tempStackView.addArrangedSubview(tempLabel)
        tempStackView.addArrangedSubview(tempTypeLabel)
        
        mainStackView.addArrangedSubview(cityLabel)
        mainStackView.addArrangedSubview(emptyView)
        
        tempLabel.text = "21"
        tempTypeLabel.text = Constants.celsius
        cityLabel.text = "London"
    }
}

// MARK: - Setup Constraints

extension WeatherViewController {
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        headerStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        geoButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        searchButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        coditionalImageView.snp.makeConstraints { make in
            make.width.height.equalTo(120)
        }
    }
    
}
