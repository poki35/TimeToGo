//
//  TripView.swift
//  TimeToGo
//
//  Created by Кирилл Пономаренко on 01.08.2022.
//

import UIKit

protocol TripSet: AnyObject {
    
    func set()
    
}

class TripView: UIView {
    
    weak var delegate: TripSet?

    lazy var trip: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.7)
        view.layer.cornerRadius = 15
        return view
    }()
    
    init(delegate: TripSet?) {
        
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func set() {
        delegate?.set()
        
    }
    
}

extension TripView {
    
    private func setConstraints() {
        
        addSubviews(trip)
        
        trip.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trip.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            trip.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            trip.widthAnchor.constraint(equalToConstant: 380)])
        
    }
}
