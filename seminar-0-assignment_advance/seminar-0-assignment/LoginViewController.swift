//
//  ViewController.swift
//  seminar-0-assignment
//
//  Created by 사공훈 on 2022/09/07.
//

import UIKit

class LoginViewController: UIViewController {
        
    
    
        let nameLabel = UILabel()
        let emailLabel = UILabel()
        let passwordLabel = UILabel()
    
        let nameField = UITextField()
        let emailField = UITextField()
        let passwordField = UITextField()
        let loginButton = UIButton()
    
        
    
        
    
    
        override func viewDidLoad() {
            self.view = UIView()
            super.viewDidLoad()
            self.view.backgroundColor = .white
            self.title = "로그인"
        
            self.view.addSubview(nameLabel)
            self.view.addSubview(emailLabel)
            self.view.addSubview(passwordLabel)
            
            self.view.addSubview(nameField)
            self.view.addSubview(emailField)
            self.view.addSubview(passwordField)
            self.view.addSubview(loginButton)

            
          
            
            
         
            
            self.nameLabelLayout()
            self.nameFieldLayout()
            self.emailLabelLayout()
            self.emailFieldLayout()
            self.passwordLabelLayout()
            self.passwordFieldLayout()
            self.loginButtonLayout()
            
            
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
    
    func passwordLabelLayout() {
        passwordLabel.text = "비밀번호"
        passwordLabel.font = .systemFont(ofSize: 18)
        passwordLabel.textColor = UIColor.gray
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            passwordLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 50)])

    }
    
    func nameFieldLayout() {
        nameField.borderStyle = .roundedRect
        nameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 140),
            nameField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            nameField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)])
    }
    
    func emailFieldLayout() {
        emailField.borderStyle = .roundedRect
        emailField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            emailField.centerYAnchor.constraint(equalTo: emailLabel.centerYAnchor)])
    }
   
    func passwordFieldLayout() {
        passwordField.borderStyle = .roundedRect
        passwordField.isSecureTextEntry = true
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            passwordField.centerYAnchor.constraint(equalTo: passwordLabel.centerYAnchor)])
    }
    
    func loginButtonLayout() {
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .gray
        loginButton.layer.cornerRadius = 10
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            loginButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 60),
            loginButton.bottomAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 100)])
        
        loginButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)
    
    }
    
    @objc func login() {
        guard let userName = nameField.text else {return}
        guard let emailText = emailField.text else {return}
        
        if userName.count <= 2 {
            let alert = UIAlertController(title: nil, message: "username은 두 글자 이상이어야 합니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let UserInfoViewController = UserInfoViewController()
        UserInfoViewController.emailText = emailText
        UserInfoViewController.name = userName
        self.navigationController?.pushViewController(UserInfoViewController, animated: true)
        
        
    }

}

