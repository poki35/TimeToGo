//
//  ZoomButtonsViewController.swift
//  TimeToGo
//
//  Created by Кирилл Пономаренко on 12.07.2022.
//

import UIKit
// MARK: - Protocol's
protocol ZoomButtonsDelegate: AnyObject {
    
    func zoomInTapped()
    
    func zoomOutTapped()
}

class ZoomButtonsView: UIView {
    // MARK: - Add constants
    weak var delegate: ZoomButtonsDelegate?
    
    lazy var zoomInButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.addTarget(self, action: #selector(zoomInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var zoomOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.addTarget(self, action: #selector(zoomOutButtonTapped), for: .touchUpInside)
        return button
    }()
    // MARK: - Init
    init(delegate: ZoomButtonsDelegate?) {
        
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Obj-C function's
    @objc func zoomInButtonTapped() {
        delegate?.zoomInTapped()
        
        print("zoom in")
    }
    
    @objc func zoomOutButtonTapped() {
        delegate?.zoomOutTapped()
        
        print("zoom out")
    }
    
}
// MARK: - Extension's
extension ZoomButtonsView {
    
    private func setConstraints() {
        
        addSubviews(zoomInButton, zoomOutButton)
        
        zoomInButton.translatesAutoresizingMaskIntoConstraints = false
        zoomOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            zoomInButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            zoomInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            zoomInButton.heightAnchor.constraint(equalToConstant: 55),
            zoomInButton.widthAnchor.constraint(equalToConstant: 55),
            
            zoomOutButton.topAnchor.constraint(equalTo: zoomInButton.bottomAnchor, constant: 15),
            zoomOutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            zoomOutButton.heightAnchor.constraint(equalToConstant: 55),
            zoomOutButton.widthAnchor.constraint(equalToConstant: 55),
            
            leadingAnchor.constraint(equalTo: zoomInButton.leadingAnchor, constant: 0),
            bottomAnchor.constraint(equalTo: zoomOutButton.bottomAnchor, constant: 0)])
        
    }
    
}
