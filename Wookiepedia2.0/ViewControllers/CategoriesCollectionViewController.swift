//
//  CategoriesCollectionViewController.swift
//  Wookiepedia2.0
//
//  Created by DevMountain on 9/26/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

private let reuseIdentifier = "categoryCell"
typealias CategoryContainer = [Category : String]

class CategoriesCollectionViewController: UICollectionViewController {
    
    var categoryContainers: [CategoryContainer]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwapiClient.shared.fetchAllCategories { (categories) in
            self.categoryContainers = categories
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? EntityTableViewController
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        let categoryContainer = categoryContainers?[indexPath.row]
        destination?.categoryContainer = categoryContainer
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categoryContainers?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CategoryCollectionViewCell
        let categoryContainer = categoryContainers?[indexPath.row]
        cell?.categoryContainer = categoryContainer
        return cell ?? UICollectionViewCell()
    }
}
