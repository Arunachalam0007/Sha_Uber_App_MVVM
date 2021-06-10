//
//  HomeViewController.swift
//  Sha_Uber_App_MVVM
//
//  Created by ArunSha on 02/06/21.
//

import UIKit
import MapKit

private let reuseIdentifier = "LocationCell"


class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private let mapKit = MKMapView()
    private let locationManager = LocationHandler.shared.locationManager

    private let inputActivationView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    
    private final let locationInputViewHeight: CGFloat = 200
    
    private let tableView = UITableView()

    private  let userVM = UserViewModel()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        userVM.fetchUser(){
            self.locationInputView.titleLabel.text = self.userVM.userName
        }
        configureUI()
    }
    
    // MARK: - Helpers Function
    func configureUI()  {
        view.addSubview(mapKit)
        mapKit.frame = view.frame
        mapKit.showsUserLocation = true
        mapKit.userTrackingMode = .follow
        setupUI()
    }
    
    func setupUI() {
        configureLocationInputActivationView()
        configureTableView()
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
    
    func configureLocationInputView() {
        locationInputView.delegate = self
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor,
                                 right: view.rightAnchor, height: 200)
        locationInputView.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.locationInputView.alpha = 1
        }) { _ in
            print("DEBUG: LocationInputView Showed")
            UIView.animate(withDuration: 0.3) {
                self.tableView.frame.origin.y = self.locationInputViewHeight
            }
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
        
        let height = view.frame.height - locationInputViewHeight
        tableView.frame = CGRect(x: 0, y: view.frame.height,
                                 width: view.frame.width, height: height)
        
        view.addSubview(tableView)
        
    }
    
}

// MARK: - LocationInputActivationViewDelegate

extension HomeViewController: LocationInputActivationViewDelegate{
    func presentLocationInputView() {
        configureLocationInputView()
    }
}


// MARK: - LocationInputViewDelegate

extension HomeViewController: LocationInputViewDelegate{
    func dismissLocationInputView() {
        UIView.animate(withDuration: 0.3) {
            self.locationInputView.alpha = 0
            self.locationInputView.removeFromSuperview()
            self.tableView.frame.origin.y = self.view.frame.height
        } completion: { _ in
            UIView.animate(withDuration: 20, animations: {
                self.inputActivationView.alpha = 1
            })
        }
    }
}


// MARK: - Location Service

extension HomeViewController{
    

    // Not needed this for Find Authorized status of location manger
    func enableLocationServices(){
        switch locationManager?.authorizationStatus{
        case .notDetermined:
            print("DEBUG: Authorization status is Not Determined")
            locationManager?.requestWhenInUseAuthorization()
        case .restricted:
            print("DEBUG: Authorization status is  Restricted")

        case .denied:
            print("DEBUG: Authorization status is Denied")

        case .authorizedAlways:
            print("DEBUG:  Authorized Always")
            // This will update the location
            locationManager?.startUpdatingLocation()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("DEBUG: Authorization status is Authorized When In Use?")
            locationManager?.requestAlwaysAuthorization()
        @unknown default:
            break
        }
        
    }
}

// MARK: - CommentsUITableViewDelegate UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Saved Locations" : "Results"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LocationCell
        
//        if indexPath.section == 0 {
//            cell.placemark = savedLocations[indexPath.row]
//        }
//
//        if indexPath.section == 1 {
//            cell.placemark = searchResults[indexPath.row]
//        }
        
        return cell
    }
    
}
