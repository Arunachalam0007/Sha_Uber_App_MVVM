//
//  LocationInputActivationView.swift
//  Sha_Uber_App_MVVM
//
//  Created by ArunSha on 02/06/21.
//

import UIKit

class LocationInputActivationView: UIView {
    
    // MARK: - Properties

    let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Where to?"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    
    // MARK: - LifeCycles

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers  Function

    func configureUI(){
        backgroundColor = .white
        addShadow()
        setupUI()
    }
    
    func setupUI() {
        addSubview(indicatorView)
        indicatorView.centerY(inView: self)
        indicatorView.anchor(left:leftAnchor,paddingLeft: 16)
        indicatorView.setDimensions(height: 6, width: 6)
        
        addSubview(placeholderLabel)
        placeholderLabel.centerY(inView: self)
        placeholderLabel.anchor(left:indicatorView.rightAnchor,paddingLeft: 20)
    }
    
}
