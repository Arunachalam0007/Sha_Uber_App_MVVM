//
//  LocationCell.swift
//  Sha_Uber_App_MVVM
//
//  Created by ArunSha on 03/06/21.
//

import UIKit

class LocationCell: UITableViewCell {

    
    // MARK: - Properties
    
//    var placemark: MKPlacemark? {
//        didSet {
//            titleLabel.text = placemark?.name
//            addressLabel.text = placemark?.address
//        }
//    }
//
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Chennai"
        return label
    }()
    
    var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "11,KamachiNager,Gunidy"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, addressLabel])
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 8)    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
