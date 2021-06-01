//
//  LoginViewController.swift
//  Sha_Uber_App_MVVM
//
//  Created by ArunSha on 01/06/21.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    private let titleLable: UILabel = {
        let titleLab = UILabel()
        titleLab.text = "UBER"
        titleLab.textColor = UIColor(white: 1, alpha: 0.8)
        titleLab.font =  UIFont(name: "Avenir-Light", size: 36)
        return titleLab
    }()
    
    private lazy var emailContainer:  UIView = {
        let emailContainer = UIView().createCustomContainer(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
        emailContainer.anchor(height: 50)
        return emailContainer
    }()
    
    private lazy var passwordContainer:  UIView = {
        let passwordContainer = UIView().createCustomContainer(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        passwordContainer.anchor(height: 50)
        return passwordContainer
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().createCustomTextField(placeHolderName: "Email", isKeyboardType: .emailAddress, isSecureTextEntry: false)
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().createCustomTextField(placeHolderName: "Paswword", isKeyboardType: .namePhonePad, isSecureTextEntry: true)
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor =  .mainBlueTint
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleLogin() {
        print("Login In Button Got Pressed")
    }
    
    @objc func handleShowSignUp() {
        print("Sign up Button Got Pressed")
    }
    
    
    // MARK: - Helpers Function
    
    func configureUI(){
        view.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        setupUI()
    }
    
    func setupUI() {
        
        configureNavigationBar()
        
        //add title lable
        view.addSubview(titleLable)
        titleLable.anchor(top:view.safeAreaLayoutGuide.topAnchor)
        titleLable.centerX(inView: view)
        
        // add Stack view (email and password Container)
        
        let stackView = UIStackView(arrangedSubviews: [emailContainer,
                                                       passwordContainer,
                                                       loginButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        view.addSubview(stackView)
        stackView.anchor(top: titleLable.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16 )
        
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)

    }
    
    // configure Navigation UI
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }

}
