//
//  AuthenticationViewModel.swift
//  Sha_Uber_App_MVVM
//
//  Created by ArunSha on 01/06/21.
//

import UIKit

protocol FormViewModel {
    func updateFormBtn()
}

struct FeedAuthenticationViewModel {
    
    var authServie = AuthService()
    func getUserLogout(completion: @escaping (String?)->()){
        authServie.userLogOut { result in
            completion(result)
        }
    }
    func getCurrentUser(completion: @escaping (String?)->()) {
        authServie.getCurrentUser { result in
            completion(result)
        }
    }
}

struct LoginViewModel {
    var email:String?
    var password:String?
    
    var btnIsValid:Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var btnBackgroundColor: UIColor {
        return btnIsValid ? .mainBlueTint : .backgroundColor
    }
    
    func userLogin(completion: @escaping (String?)->()){
        guard let email = email, let password = password else {
            print("DEBUG: Email and Password Should Not Be Empty")
            return
        }
        AuthService().userLogIn(email: email, password: password) { authDataResult in
            guard let authDataResult = authDataResult else {
                completion(nil)
                return
            }
            completion(authDataResult.user.email)
        }
    }
}

struct RegistrationViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var rideType: String?
    
    var btnIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false
    }
    
    var btnBackgroundColor: UIColor {
        return btnIsValid ? .mainBlueTint : .backgroundColor
    }
    
    func registerUserDetails(completion:@escaping (String?)->()) {
        guard let email = email,let password = password,let fullname = fullname,let rideType = rideType else {
            print("DEBUG: please fill all your information")
            return
        }
        
        let authCredentials = AuthenticationCredentials(email: email, password: password, fullname: fullname, type: rideType)
        AuthService().registerUser(authCredentials: authCredentials) { response in
            completion(response)
        }
    }
}
