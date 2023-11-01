//
//  ViewController.swift
//  Clima
//
//  Created by Сазонов Станислав on 30.10.2023.
//

import UIKit
import SnapKit
import CoreLocation

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
        element.addTarget(self, action: #selector(locationPressed), for: .touchUpInside)
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
        element.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
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
    
    // MARK: - Private Properties
    
    private var weatherManager = WeatherManager()
    private let locationManager = CLLocationManager()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setupConstraints()
        setDelegates()
        setupLocationSettings()
    }
    
    // MARK: - Private Methods
    
    private func setDelegates() {
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
    }
    
    private func setupLocationSettings() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    // MARK: - Actions
    
    @objc func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    @objc func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
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

// MARK: - CLLocationMangerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation()
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        weatherManager.fetchWeather(latitude: lat, longitude: lon)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLabel.text = weather.temperatureString
            self.tempTypeLabel.text = Constants.celsius
            self.coditionalImageView.image = UIImage(systemName: weather.getConditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if !textField.text!.isEmpty {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
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
