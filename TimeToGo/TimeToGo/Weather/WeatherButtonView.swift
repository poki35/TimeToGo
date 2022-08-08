//
//  WeatherViewController.swift
//  TimeToGo
//
//  Created by Кирилл Пономаренко on 21.07.2022.
//

import UIKit
// MARK: - Protocol's
protocol Weather: AnyObject {
    
    func weatherTap()
}

class WeatherButtonView: UIView {
    // MARK: - Add constants
    weak var delegate: Weather?
    
    lazy var weatherBut: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "wea"), for: .normal)
        button.addTarget(self, action: #selector(weatherButtonTapped), for: .touchUpInside)
        return button
    }()
    // MARK: - Init
    init(delegate: Weather?) {
        
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Obj-C function's
    @objc func weatherButtonTapped() {
        
        delegate?.weatherTap()
        
        print("weather tapped")
    }
    
}
// MARK: - Extension's
extension WeatherButtonView {
    
    private func setConstraints() {
        
        addSubviews(weatherBut)
        
        weatherBut.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherBut.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            weatherBut.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            weatherBut.heightAnchor.constraint(equalToConstant: 55),
            weatherBut.widthAnchor.constraint(equalToConstant: 55),
            
            leadingAnchor.constraint(equalTo: weatherBut .leadingAnchor, constant: 0),
            bottomAnchor.constraint(equalTo: weatherBut.bottomAnchor, constant: 0)])
    }
}
