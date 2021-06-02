//
//  HomeViewController.swift
//  Sha_Uber_App_MVVM
//
//  Created by ArunSha on 02/06/21.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private let mapKit = MKMapView()
    private let locationManager = CLLocationManager()

    private let inputActivationView = LocationInputActivationView()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        configureUI()
    }
    
    // MARK: - Helpers Function
    func configureUI()  {
        view.addSubview(mapKit)
        mapKit.frame = view.frame
        mapKit.showsUserLocation = true
        mapKit.userTrackingMode = .follow
        locationManager.delegate = self
        setupUI()
    }
    
    func setupUI() {
        configureLocationInputActivationView()
    }
    
    func configureLocationInputActivationView() {
        view.addSubview(inputActivationView)
        inputActivationView.centerX(inView: view)
        inputActivationView.setDimensions(height: 50, width: view.frame.width - 64)
        inputActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        inputActivationView.alpha = 0
        inputActivationView.locationInputDelegate = self
        
        //Animate show the inputActivationView after 1 sec
        UIView.animate(withDuration: 1) {
            self.inputActivationView.alpha = 1
        }
    }
}

// MARK: - Location Service

extension HomeViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
        if status == .authorizedAlways {
            print("DEBUG: Authorized Always")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
    
    // Not needed this for Find Authorized status of location manger
    func enableLocationServices(){
        switch locationManager.authorizationStatus{
        case .notDetermined:
            print("DEBUG: Authorization status is Not Determined")
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("DEBUG: Authorization status is  Restricted")

        case .denied:
            print("DEBUG: Authorization status is Denied")

        case .authorizedAlways:
            print("DEBUG:  Authorized Always")
            // This will update the location
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("DEBUG: Authorization status is Authorized When In Use")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
        
    }
}


// MARK: - LocationInputActivationViewDelegate

extension HomeViewController: LocationInputActivationViewDelegate{
    func presentLocationInputView() {
        print("DEBUG: presentLocationInputView")
    }
}


