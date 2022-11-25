//
//  UserInfoViewController.swift
//  seminar-0-assignment
//
//  Created by 사공훈 on 2022/09/09.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    
    let nameInput = UILabel()
    let emailInput = UILabel()
    
    let logoutButton = UIButton()
    
    var emailText: String?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        self.title = "유저 정보"
        
        self.view.addSubview(nameLabel)
        self.view.addSubview(emailLabel)
        self.view.addSubview(nameInput)
        self.view.addSubview(emailInput)
        self.view.addSubview(logoutButton)
        
        self.nameLabelLayout()
        self.emailLabelLayout()
        self.nameInputLayout()
        self.emailInputLayout()
        self.logoutButtonLayout()
        
    }
    
    func nameLabelLayout() {
        nameLabel.text = "유저 이름"
        nameLabel.font = .systemFont(ofSize: 18)
        nameLabel.textColor = UIColor.gray
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40)])

    }
    
    func emailLabelLayout() {
        emailLabel.text = "이메일"
        emailLabel.font = .systemFont(ofSize: 18)
        emailLabel.textColor = UIColor.gray
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50)])

    }
    
    func nameInputLayout() {
        nameInput.text = name
        nameInput.font = .systemFont(ofSize: 18)
        nameInput.textColor = UIColor.black
        nameInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameInput.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 140),
            nameInput.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)])

    }
    
    func emailInputLayout() {
        emailInput.text = emailText
        emailInput.font = .systemFont(ofSize: 18)
        emailInput.textColor = UIColor.black
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailInput.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 140),
            emailInput.centerYAnchor.constraint(equalTo: emailLabel.centerYAnchor)])

    }
    
    func logoutButtonLayout() {
        logoutButton.setTitle("로그아웃", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.backgroundColor = .gray
        logoutButton.layer.cornerRadius = 10
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            logoutButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            logoutButton.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 60),
            logoutButton.bottomAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 100)])
        
        logoutButton.addTarget(self, action: #selector(self.logout), for: .touchUpInside)
    
    }
    
    @objc func logout() {
    
        self.navigationController?.popViewController(animated: true)
        
        
    }
}
