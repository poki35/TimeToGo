//
//  WeatherViewController.swift
//  TimeToGo
//
//  Created by Кирилл Пономаренко on 21.07.2022.
//

import UIKit

class WeatherViewController: ViewController {
    
    private func buttons() {
        
        let weatherWidget = UIButton(frame: CGRect(x: 20, y: 100, width: 400, height: 50))
        weatherWidget.setTitle("1 кнопка", for: .normal)
        weatherWidget.layer.borderWidth = 0.5
        weatherWidget.layer.borderColor = UIColor.white.cgColor
        weatherWidget.backgroundColor = .systemBrown
        weatherWidget.layer.cornerRadius = 10
        weatherWidget.layer.masksToBounds = true
        weatherWidget.addTarget(self, action: #selector(weatherButtonTapped), for:.touchUpInside)
        view.addSubview(weatherWidget)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        buttons()
    }
    
    @objc func weatherButtonTapped() {
        print("333")
    }
    
//    private func setConstrait() {
//        
////        NSLayoutConstraint.activate([weatherWidget.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 150),
////                                     weatherWidget.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
////                                     weatherWidget.heightAnchor.constraint(equalToConstant: 45),
////                                     weatherWidget.widthAnchor.constraint(equalToConstant: 45)])
////    }
//}

}
