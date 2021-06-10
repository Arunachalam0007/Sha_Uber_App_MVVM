//
//  FetchProfile.swift
//  Sha_Uber_App_MVVM
//
//  Created by ArunSha on 09/06/21.
//

import Firebase

struct ProfileService {
    
    static var shared = ProfileService()
    
    func fetchProfileData(completion: @escaping (Any?)->()) {
        Firestore.firestore().collection("users").document(Auth.auth().currentUser!.uid).getDocument { documentSnapshot, error in
            documentSnapshot?.data()
            guard let data =  documentSnapshot?.data() else { return }
            print(data)
            completion(data)
        }

    }
}
