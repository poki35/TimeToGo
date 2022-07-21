//
//  SetViewController.swift
//  TimeToGo
//
//  Created by Кирилл Пономаренко on 21.07.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var titlePost: String = "Настройки"

    
//    var firstButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("First", for: .normal)
//        button.backgroundColor = .red
//        button.layer.cornerRadius = 10
//        button.layer.masksToBounds = true
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
        
        let buttonTwo = UIButton(frame: CGRect(x: 7, y: 170, width: 400, height: 50))
        buttonTwo.setTitle("2 кнопка", for: .normal)
        buttonTwo.layer.borderWidth = 0.5
        buttonTwo.layer.borderColor = UIColor.white.cgColor
        buttonTwo.backgroundColor = .systemBrown
        buttonTwo.layer.cornerRadius = 10
//        buttonTwo.contentHorizontalAlignment = .left
        buttonTwo.layer.masksToBounds = true
        buttonTwo.addTarget(self, action: #selector(secondButtonPressed), for:.touchUpInside)
        view.addSubview(buttonTwo)
        
        let buttonThree = UIButton(frame: CGRect(x: 7, y: 240, width: 400, height: 50))
        buttonThree.setTitle("3 кнопка", for: .normal)
        buttonThree.layer.borderWidth = 0.5
        buttonThree.layer.borderColor = UIColor.white.cgColor
        buttonThree.backgroundColor = .systemBrown
        buttonThree.layer.cornerRadius = 10
//        buttonThree.contentHorizontalAlignment = .left
        buttonThree.layer.masksToBounds = true
        buttonThree.addTarget(self, action: #selector(threeButtonPressed), for:.touchUpInside)
        view.addSubview(buttonThree)
        
        let buttonFour = UIButton(frame: CGRect(x: 7, y: 310, width: 400, height: 50))
        buttonFour.setTitle("4 кнопка", for: .normal)
        buttonFour.layer.borderWidth = 0.5
        buttonFour.layer.borderColor = UIColor.white.cgColor
        buttonFour.backgroundColor = .systemBrown
        buttonFour.layer.cornerRadius = 10
//        buttonFour.contentHorizontalAlignment = .left
        buttonFour.layer.masksToBounds = true
        buttonFour.addTarget(self, action: #selector(fourButtonPressed), for:.touchUpInside)
        view.addSubview(buttonFour)
        
        let buttonFive = UIButton(frame: CGRect(x: 7, y: 380, width: 400, height: 50))
        buttonFive.setTitle("5 кнопка", for: .normal)
        buttonFive.layer.borderWidth = 0.5
        buttonFive.layer.borderColor = UIColor.white.cgColor
        buttonFive.backgroundColor = .systemBrown
        buttonFive.layer.cornerRadius = 10
//        buttonFive.contentHorizontalAlignment = .left
        buttonFive.layer.masksToBounds = true
        buttonFive.addTarget(self, action: #selector(fiveButtonPressed), for:.touchUpInside)
        view.addSubview(buttonFive)
        
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
    
    @objc func tap() {
        
        let alertVC = UIAlertController(title: "Скоро че то будет", message: "Или нет?", preferredStyle: .alert)
        let leftAction = UIAlertAction(title: "Да", style: .default, handler: {(action:UIAlertAction!) in print("Yes")})
        let rightAction = UIAlertAction(title: "Нет", style: .destructive, handler: {(action:UIAlertAction!) in print("No")})
        alertVC.addAction(leftAction)
        alertVC.addAction(rightAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    private func setUp() {
        
//        view.addSubviews(firstButton)
//
//        NSLayoutConstraint.activate([firstButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//                                     firstButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100),
//                                     firstButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//                                     firstButton.heightAnchor.constraint(equalToConstant: 55),
//                                     firstButton.widthAnchor.constraint(equalToConstant: 55),
//                                    ])
    }
    
}
