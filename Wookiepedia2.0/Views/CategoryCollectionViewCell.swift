//
//  CategoryCollectionViewCell.swift
//  Wookiepedia2.0
//
//  Created by DevMountain on 9/26/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var categoryContainer: CategoryContainer?{
        didSet{
            updateViews()
        }
    }
    
    func updateViews(){
        let category = categoryContainer?.keys.first?.rawValue
        categoryLabel.text = category
        categoryImageView.image = UIImage(named: category ?? "films")!
    }
    
    
}
