//
//  UserModel.swift
//  Sha_Uber_App_MVVM
//
//  Created by ArunSha on 09/06/21.
//

import Foundation

class  UserModel{
    var email: String
    var fullname: String
    var rideType: String
    var userId: String
    
    init(email:String?, fullname:String?, rideType:String?, userId: String?) {
        self.email =  email ?? ""
        self.fullname =  fullname ?? ""
        self.rideType =  rideType ?? ""
        self.userId =  userId ?? ""
    }
    
}
