//
//  SetViewController.swift
//  TimeToGo
//
//  Created by Кирилл Пономаренко on 21.07.2022.
//

import UIKit
import MapKit

class SettingsViewController: UIViewController {
    
    var titlePost: String = "Настройки"
    
//    lazy var firstButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("First", for: .normal)
//        button.backgroundColor = .red
//        button.layer.cornerRadius = 10
//        button.layer.masksToBounds = true
//        button.addTarget(self, action: #selector(firstButtonPressed), for:.touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    lazy var secondButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("second", for: .normal)
//        button.backgroundColor = .red
//        button.layer.cornerRadius = 10
//        button.layer.masksToBounds = true
//        button.addTarget(self, action: #selector(secondButtonPressed), for:.touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    lazy var threeButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("three", for: .normal)
//        button.backgroundColor = .red
//        button.layer.cornerRadius = 10
//        button.layer.masksToBounds = true
//        button.addTarget(self, action: #selector(threeButtonPressed), for:.touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    lazy var fourButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("four", for: .normal)
//        button.backgroundColor = .red
//        button.layer.cornerRadius = 10
//        button.layer.masksToBounds = true
//        button.addTarget(self, action: #selector(fourButtonPressed), for:.touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    lazy var fiveButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("five", for: .normal)
//        button.backgroundColor = .red
//        button.layer.cornerRadius = 10
//        button.layer.masksToBounds = true
//        button.addTarget(self, action: #selector(fiveButtonPressed), for:.touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    lazy var sixButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("six ind switch", for: .normal)
//        button.backgroundColor = .red
//        button.layer.cornerRadius = 10
//        button.layer.masksToBounds = true
//        button.addTarget(self, action: #selector(sixButtonPressed), for:.touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
        private func buttons() {
    
            let buttonOne = UIButton(frame: CGRect(x: 7, y: 100, width: 400, height: 50))
            buttonOne.setTitle("1 кнопка", for: .normal)
            buttonOne.layer.borderWidth = 0.5
            buttonOne.layer.borderColor = UIColor.white.cgColor
            buttonOne.backgroundColor = .systemBrown
            buttonOne.layer.cornerRadius = 10
    //        buttonOne.contentHorizontalAlignment = .left
            buttonOne.layer.masksToBounds = true
            buttonOne.addTarget(self, action: #selector(firstButtonPressed), for:.touchUpInside)
            view.addSubview(buttonOne)
    
            let buttonTwo = UIButton(frame: CGRect(x: 7, y: 160, width: 400, height: 50))
            buttonTwo.setTitle("2 кнопка", for: .normal)
            buttonTwo.layer.borderWidth = 0.5
            buttonTwo.layer.borderColor = UIColor.white.cgColor
            buttonTwo.backgroundColor = .systemBrown
            buttonTwo.layer.cornerRadius = 10
    //        buttonTwo.contentHorizontalAlignment = .left
            buttonTwo.layer.masksToBounds = true
            buttonTwo.addTarget(self, action: #selector(secondButtonPressed), for:.touchUpInside)
            view.addSubview(buttonTwo)
    
            let buttonThree = UIButton(frame: CGRect(x: 7, y: 220, width: 400, height: 50))
            buttonThree.setTitle("3 кнопка", for: .normal)
            buttonThree.layer.borderWidth = 0.5
            buttonThree.layer.borderColor = UIColor.white.cgColor
            buttonThree.backgroundColor = .systemBrown
            buttonThree.layer.cornerRadius = 10
    //        buttonThree.contentHorizontalAlignment = .left
            buttonThree.layer.masksToBounds = true
            buttonThree.addTarget(self, action: #selector(threeButtonPressed), for:.touchUpInside)
            view.addSubview(buttonThree)
    
            let buttonFour = UIButton(frame: CGRect(x: 7, y: 280, width: 400, height: 50))
            buttonFour.setTitle("4 кнопка", for: .normal)
            buttonFour.layer.borderWidth = 0.5
            buttonFour.layer.borderColor = UIColor.white.cgColor
            buttonFour.backgroundColor = .systemBrown
            buttonFour.layer.cornerRadius = 10
    //        buttonFour.contentHorizontalAlignment = .left
            buttonFour.layer.masksToBounds = true
            buttonFour.addTarget(self, action: #selector(fourButtonPressed), for:.touchUpInside)
            view.addSubview(buttonFour)
    
            let buttonFive = UIButton(frame: CGRect(x: 7, y: 340, width: 400, height: 50))
            buttonFive.setTitle("5 кнопка", for: .normal)
            buttonFive.layer.borderWidth = 0.5
            buttonFive.layer.borderColor = UIColor.white.cgColor
            buttonFive.backgroundColor = .systemBrown
            buttonFive.layer.cornerRadius = 10
    //        buttonFive.contentHorizontalAlignment = .left
            buttonFive.layer.masksToBounds = true
            buttonFive.addTarget(self, action: #selector(fiveButtonPressed), for:.touchUpInside)
            view.addSubview(buttonFive)
    
            let buttonSix = UILabel(frame: CGRect(x: 7, y: 400, width: 400, height: 50))
            buttonSix.text = "Включить звук?"
            buttonSix.layer.borderWidth = 0.5
            buttonSix.layer.borderColor = UIColor.white.cgColor
            buttonSix.backgroundColor = .systemBrown
            buttonSix.layer.cornerRadius = 10
            buttonSix.textAlignment = .left
            buttonSix.layer.masksToBounds = true
            view.addSubview(buttonSix)
    
            let buttonSixSwitch = UISwitch(frame: CGRect(x: 340, y: 410, width: 400, height: 50))
            buttonSixSwitch.layer.cornerRadius = 10
            buttonFive.addTarget(self, action: #selector(sixButtonPressed), for:.touchUpInside)
            view.addSubview(buttonSixSwitch)
    
    
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tap))
        self.navigationItem.title = titlePost
        
        buttons()
    }
    
    @objc func firstButtonPressed() {
        let alertVC = UIAlertController(title: "Cлышь", message: "Че заняться нечем?", preferredStyle: .alert)
        let leftAction = UIAlertAction(title: "Да", style: .default, handler: {(action:UIAlertAction!) in print("Yes")})
        let rightAction = UIAlertAction(title: "Нет", style: .destructive, handler: {(action:UIAlertAction!) in print("No")})
        alertVC.addAction(leftAction)
        alertVC.addAction(rightAction)
        
        self.present(alertVC, animated: true, completion: nil)
        
        print("1 button pressed")
    }
    
    @objc func secondButtonPressed() {
        let alertVC = UIAlertController(title: "Ты тупой?", message: "С первого раза не понял?", preferredStyle: .alert)
        let leftAction = UIAlertAction(title: "Да", style: .default, handler: {(action:UIAlertAction!) in print("Yes")})
        let rightAction = UIAlertAction(title: "Пошел нахуй", style: .destructive, handler: {(action:UIAlertAction!) in print("No")})
        alertVC.addAction(leftAction)
        alertVC.addAction(rightAction)
        
        self.present(alertVC, animated: true, completion: nil)
        
        print("2 button pressed")
    }
    
    @objc func threeButtonPressed() {
        print("3 button pressed")
    }
    
    @objc func fourButtonPressed() {
        print("4 button pressed")
    }
    
    @objc func fiveButtonPressed() {
        print("5 button pressed")
    }
    
    @objc func sixButtonPressed() {
        print("6 button pressed")
    }
    
    @objc func tap() {
        
        let alertVC = UIAlertController(title: "Скоро че то будет", message: "Или нет?", preferredStyle: .alert)
        let leftAction = UIAlertAction(title: "Да", style: .default, handler: {(action:UIAlertAction!) in print("Yes")})
        let rightAction = UIAlertAction(title: "Нет", style: .destructive, handler: {(action:UIAlertAction!) in print("No")})
        alertVC.addAction(leftAction)
        alertVC.addAction(rightAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
//    private func setUp() {
//
//        view.addSubviews(firstButton, secondButton, threeButton, fourButton, fiveButton, sixButton)
//
//        NSLayoutConstraint.activate([firstButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//                                     firstButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100),
//                                     firstButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//                                     firstButton.heightAnchor.constraint(equalToConstant: 55),
//                                     firstButton.widthAnchor.constraint(equalToConstant: 55),
//
//                                     secondButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
//                                     secondButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100),
//                                     secondButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//                                     secondButton.heightAnchor.constraint(equalToConstant: 55),
//                                     secondButton.widthAnchor.constraint(equalToConstant: 55),
//
//                                     threeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
//                                     threeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100),
//                                     threeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//                                     threeButton.heightAnchor.constraint(equalToConstant: 55),
//                                     threeButton.widthAnchor.constraint(equalToConstant: 55),
//
//                                     fourButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//                                     fourButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100),
//                                     fourButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//                                     fourButton.heightAnchor.constraint(equalToConstant: 55),
//                                     fourButton.widthAnchor.constraint(equalToConstant: 55),
//
//                                     fiveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//                                     fiveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100),
//                                     fiveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//                                     fiveButton.heightAnchor.constraint(equalToConstant: 55),
//                                     fiveButton.widthAnchor.constraint(equalToConstant: 55),
//
//                                     sixButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//                                     sixButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100),
//                                     sixButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//                                     sixButton.heightAnchor.constraint(equalToConstant: 55),
//                                     sixButton.widthAnchor.constraint(equalToConstant: 55),
//                                    ])
//    }
    
}
