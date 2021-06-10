//
//  AuthService.swift
//  Sha_Uber_App_MVVM
//
//  Created by ArunSha on 01/06/21.
//

import Firebase
import GeoFire

struct AuthenticationCredentials{
    var email:String
    var password:String
    var fullname:String
    var type:String
    var userLocation: CLLocation?
}

struct AuthService {
    
    func userLogIn(email:String, password:String, completion: @escaping (AuthDataResult?)-> () ) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                print("DEBUG: Unable To SignIn: \(error)")
                completion(nil)
            }
            completion(authDataResult)
        }
    }
    
    func userLogOut(completion: @escaping (String?)->()) {
        do {
            try Auth.auth().signOut()
            completion("SignOut SuccessFully")
        } catch {
            print("DEBUG: Unable to SignOut")
            completion(nil)
        }
    }
    
    func getCurrentUser(completion: @escaping (String?)->() ) {
        let currentUser = Auth.auth().currentUser?.email
        completion(currentUser)
    }
    
    func registerUser(authCredentials: AuthenticationCredentials, completion: @escaping (String?)-> () ){

            // Creating Auth User
            Auth.auth().createUser(withEmail: authCredentials.email, password: authCredentials.password) { authResult, error in
                if let error = error {
                    print("DEBUG: Unable to Set Authentication: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                                
                // Get Authenticated UserID
                guard let userId = authResult?.user.uid else {
                    print("DEBUG: Authenticated UserId is Empty")
                    completion(nil)
                    return
                }
                
                let userData: [String:Any] = ["email":authCredentials.email,
                                              "fullname":authCredentials.fullname,
                                              "rideType":authCredentials.type,
                                              "userID":userId]

                // Stroe
                if (authCredentials.type == "Driver"){
                    let driveDocumentRef = Database.database().reference().child("driver-locations")
//                        Firestore.firestore().collection("driver-locations").document()
                    let geoFire =  GeoFire(firebaseRef: driveDocumentRef)
                    geoFire.setLocation(authCredentials.userLocation!, forKey: userId) { error in
                        print("DEBUG GEOFIRE ERROR: ", error)
                    }
     
                }
                
                // Store UserData in Firebase database with documentId as userId
                Firestore.firestore().collection("users").document(userId).setData(userData, merge: false) { error in
                    if let error = error {
                        print("DEBUG: Unable to Add User Data in Users Database: \(error.localizedDescription)")
                        completion(nil)
                        return
                    }
                    completion("Success Registered User Ready to Login")
                }
                
            }
    }
}
