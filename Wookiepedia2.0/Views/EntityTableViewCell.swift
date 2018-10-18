//
//  EntityTableViewCell.swift
//  Wookiepedia2.0
//
//  Created by DevMountain on 9/26/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

class EntityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var entityImageView: UIImageView!
    @IBOutlet weak var entityNameLabel: UILabel!
    
    var entity: Entity?{
        didSet{
            self.updateViews()
        }
    }
    
    override func prepareForReuse() {
        entityImageView.image = nil
        entityNameLabel.text = ""
        activityIndicator.startAnimating()
    }

    func updateViews(){
        guard let name = entity?.name else {return}
        
        entityNameLabel.text = name
        if let icon = UIImage(named: name.lowercased()){
            entityImageView.image = icon
        } else {
            entityImageView.image = nil
        }
    }

}
