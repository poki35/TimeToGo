//
//  WayView.swift
//  TimeToGo
//
//  Created by Кирилл Пономаренко on 29.07.2022.
//

import UIKit

protocol ViewButtons: AnyObject {
    
    func goBut()
    
    func reset()
    
    func typeRoad()
    
}

class WayView: UIView {
    
    weak var delegate: ViewButtons?
    
    lazy var counterDistance: UILabel = {
        let counter = UILabel()
        counter.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.0)
        counter.textAlignment = .center
        return counter
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.layer.borderWidth = 0.5
        button.backgroundColor = .init(red: 169 / 255, green: 169 / 255, blue: 169 / 255, alpha: 0.90)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var selectTypeRoad: UIButton = {
        let button = UIButton()
        button.setTitle("Транспорт", for: .normal)
        button.layer.borderWidth = 0.5
        button.backgroundColor = .init(red: 169 / 255, green: 169 / 255, blue: 169 / 255, alpha: 0.90)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(typeMapButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var counterKm: UILabel = {
        let counter = UILabel()
        counter.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.0)
        counter.textAlignment = .center
        return counter
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.7)
        view.layer.cornerRadius = 25
        return view
    }()
    
    lazy var goButton: UIButton = {
        let button = UIButton()
        button.setTitle("Поехали", for: .normal)
        button.layer.borderWidth = 0.5
        button.backgroundColor = .init(red: 32 / 255, green: 178 / 255, blue: 170 / 255, alpha: 0.90)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(delegate: ViewButtons?) {
        
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func typeMapButtonTapped() {
        delegate?.typeRoad()
        
        print("type road tapped")
        
    }
    
    @objc func goButtonTapped() {
        delegate?.goBut()
        
        print("go button tapped")
    }
    
    @objc func resetButtonTapped() {
        delegate?.reset()
        
        print("reset")
    }
    
}

extension WayView {
    
    private func setConstraints() {
        
        addSubviews(backView, goButton, counterDistance, counterKm, resetButton, selectTypeRoad)
        
        counterDistance.translatesAutoresizingMaskIntoConstraints = false
        counterKm.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        goButton.translatesAutoresizingMaskIntoConstraints = false
        backView.translatesAutoresizingMaskIntoConstraints = false
        selectTypeRoad.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            backView.widthAnchor.constraint(equalToConstant: 414),
            
            goButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 70),
            goButton.widthAnchor.constraint(equalToConstant: 200),
            goButton.heightAnchor.constraint(equalToConstant: 60),
            goButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 107),
            
            selectTypeRoad.topAnchor.constraint(equalTo: backView.topAnchor, constant: 75),
            selectTypeRoad.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12),
            selectTypeRoad.heightAnchor.constraint(equalToConstant: 55),
            selectTypeRoad.widthAnchor.constraint(equalToConstant: 90),
            
            counterDistance.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            counterDistance.widthAnchor.constraint(equalToConstant: 300),
            counterDistance.heightAnchor.constraint(equalToConstant: 25),
            counterDistance.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 55),
            
            counterKm.topAnchor.constraint(equalTo: backView.topAnchor, constant: 35),
            counterKm.widthAnchor.constraint(equalToConstant: 300),
            counterKm.heightAnchor.constraint(equalToConstant: 25),
            counterKm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 55),
            
            resetButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 75),
            resetButton.heightAnchor.constraint(equalToConstant: 55),
            resetButton.widthAnchor.constraint(equalToConstant: 90),
            resetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
            
        ])
    }
}

