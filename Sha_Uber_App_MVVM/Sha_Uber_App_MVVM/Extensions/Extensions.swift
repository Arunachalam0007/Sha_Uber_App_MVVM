//
//  Extensions.swift
//  Sha_Uber_App_MVVM
//
//  Created by ArunSha on 01/06/21.
//

import UIKit


// MARK: - UIColor Extension

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static let backgroundColor = UIColor.rgb(red: 25, green: 25, blue: 25)
    static let mainBlueTint = UIColor.rgb(red: 17, green: 154, blue: 237)
    static let outlineStrokeColor = UIColor.rgb(red: 234, green: 46, blue: 111)
    static let trackStrokeColor = UIColor.rgb(red: 56, green: 25, blue: 49)
    static let pulsatingFillColor = UIColor.rgb(red: 86, green: 30, blue: 63)
}


// MARK: - UIView Extension

extension UIView {
    
    func createCustomContainer(image: UIImage, textField: UITextField? = nil, segmentedControl: UISegmentedControl? = nil) -> UIView {
        let containerView = UIView()
        //containerView.backgroundColor = .red
        
        let imageView = UIImageView()
        imageView.image = image
        
        containerView.addSubview(imageView)
        
        if let textField = textField {
            imageView.anchor(left: containerView.leftAnchor,width: 24, height: 24, paddingLeft: 8)
            imageView.centerY(inView: containerView)
            
            containerView.addSubview(textField)
            textField.anchor(left: imageView.rightAnchor,bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingLeft: 8, paddingBottom: 8)
            textField.centerY(inView: containerView)
        }
  
        if let segmentedControl = segmentedControl {
            imageView.anchor(top:containerView.topAnchor ,left: containerView.leftAnchor,width: 24, height: 24, paddingTop: -8, paddingLeft: 8)
            
            containerView.addSubview(segmentedControl)
            segmentedControl.anchor(left: containerView.leftAnchor, right: containerView.rightAnchor, height: 50, paddingLeft: 8)
            segmentedControl.centerY(inView: containerView)
        }
        
        let deviderView = UIView()
        deviderView.backgroundColor = .lightGray
        containerView.addSubview(deviderView)
        deviderView.anchor(left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, height: 0.75, paddingLeft: 8, paddingBottom: 2)
        return containerView
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                width: CGFloat? = nil,
                height: CGFloat? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0){
        
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view: UIView){
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView){
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.55
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.masksToBounds = false
    }
}


// MARK: - UITextField Extension

extension UITextField {
    
    func createCustomTextField(placeHolderName:String, isKeyboardType:UIKeyboardType, isSecureTextEntry: Bool) -> UITextField{
        let textField = UITextField()
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderName, attributes: [.foregroundColor : UIColor.lightGray])
        textField.keyboardType = isKeyboardType
        textField.isSecureTextEntry = isSecureTextEntry
        textField.keyboardAppearance = .dark
        return textField
    }
}

