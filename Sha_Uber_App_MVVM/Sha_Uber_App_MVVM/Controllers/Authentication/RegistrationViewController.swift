//
//  SignUpViewController.swift
//  Sha_Uber_App_MVVM
//
//  Created by ArunSha on 01/06/21.
//

import SwiftUI


class RegistrationViewController: UIViewController {
    
    // MARK: - Properties
        
    var registrationVM = RegistrationViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UBER"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().createCustomContainer(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let view = UIView().createCustomContainer(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullnameTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().createCustomContainer(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var accountTypeContainerView: UIView = {
        let view = UIView().createCustomContainer(image: #imageLiteral(resourceName: "ic_account_box_white_2x"), segmentedControl: accountTypeSegmentedControl)
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return view
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().createCustomTextField(placeHolderName: "Email", isKeyboardType: .emailAddress, isSecureTextEntry: false)
    }()
    
    private let fullnameTextField: UITextField = {
        return UITextField().createCustomTextField(placeHolderName: "Fullname", isKeyboardType: .namePhonePad, isSecureTextEntry: false)
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().createCustomTextField(placeHolderName: "Password", isKeyboardType: .namePhonePad, isSecureTextEntry: true)
    }()
    
    private let accountTypeSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Rider", "Driver"])
        sc.backgroundColor = .backgroundColor
        sc.tintColor = UIColor(white: 1, alpha: 0.87)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private let signUpButton: UIButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: - Selectors
    
    @objc func handleSignUp() {
        registrationVM.email = emailTextField.text
        registrationVM.password = passwordTextField.text
        registrationVM.fullname = fullnameTextField.text
        registrationVM.rideType = accountTypeSegmentedControl.titleForSegment(at: accountTypeSegmentedControl.selectedSegmentIndex)
        registrationVM.registerUserDetails { result in
            if let result = result {
                print("DEBUG: SignUp SuccessFUlly: ",result)
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
                
            } else {
                print("DEBUG: SignUp Error")
            }
        }
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidChanged(sender: UITextField){
        
        if sender == emailTextField {
            registrationVM.email = sender.text
        } else if sender == passwordTextField {
            registrationVM.password = sender.text
        } else if sender == fullnameTextField {
            registrationVM.fullname = sender.text
        }
        signUpButton.isEnabled = registrationVM.btnIsValid
        signUpButton.backgroundColor = registrationVM.btnBackgroundColor
    }
    
    func configureNotificationObservers(){
        emailTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    // MARK: - Helper Functions
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        
        // adding Title Lable
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        // adding email,fulname,pass,accountType containerview and singup button in to stackview
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   fullnameContainerView,
                                                   passwordContainerView,
                                                   accountTypeContainerView,
                                                   signUpButton])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 40, paddingLeft: 16,
                     paddingRight: 16)
        
        // adding AlreadyHave Account Button
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
        configureNotificationObservers()
    }
    
}

