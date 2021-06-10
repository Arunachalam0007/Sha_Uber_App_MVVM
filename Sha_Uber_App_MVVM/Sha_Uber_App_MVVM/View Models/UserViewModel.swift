//
//  UserViewModel.swift
//  Sha_Uber_App_MVVM
//
//  Created by ArunSha on 09/06/21.
//

import Foundation

class UserViewModel {
    var userModel: UserModel?
    var userName: String {
        return userModel?.fullname ?? ""
    }
    
    func fetchUser(completion: @escaping ()-> ()){
        ProfileService.shared.fetchProfileData { data in
            guard let data = data as? [String:String] else { return }
            self.userModel = UserModel(email: data["email"], fullname: data["fullname"] , rideType: data["rideType"], userId: data["userId"])
            completion()
        }
    }
}
