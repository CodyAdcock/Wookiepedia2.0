//
//  EntityTableViewController.swift
//  Wookiepedia2.0
//
//  Created by DevMountain on 9/26/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

class EntityTableViewController: UITableViewController {
    
    var isFetching: Bool = false
    
    var entities: [Entity] = []
    
    var categoryContainer: CategoryContainer?{
        didSet{
            fetchEntities()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SwapiClient.shared.nextPageUrlString = nil
        SwapiClient.shared.previousPageUrlString = nil
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SwapiClient.shared.resultCount ?? 0
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entityCell", for: indexPath) as? EntityTableViewCell
        
        if isLoadingCell(for: indexPath){
            cell?.activityIndicator.startAnimating()
        }else {
            cell?.activityIndicator.stopAnimating()
            let entity = entities[indexPath.row]
            cell?.entity = entity
        }
        
        return cell ?? UITableViewCell()
    }
    
    func reloadNecessaryIndexPaths(with newIndexPathsToReload: [IndexPath]?){
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            tableView.reloadData()
            return
        }
        // 2
        DispatchQueue.main.async {
            let indexPathsToReload = self.visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
            self.tableView.reloadRows(at: indexPathsToReload, with: .automatic)
        }
    }
    
    func fetchEntities(){
        
        guard !isFetching, let category = categoryContainer else {
            return
        }
        
        isFetching = true
        
        if SwapiClient.shared.nextPageUrlString == nil && SwapiClient.shared.previousPageUrlString == nil{
            SwapiClient.shared.fetchEntities(for: category) { (entities) in
                DispatchQueue.main.async {
                    self.isFetching = false
                    if let newEntities = entities{
                        self.entities.append(contentsOf: newEntities)
                        self.reloadNecessaryIndexPaths(with: nil)
                    }
                }
            }
        }else{
            guard let nextPage = SwapiClient.shared.nextPageUrlString else {return}
            SwapiClient.shared.fetchEntityfor(urlString: nextPage, category: categoryContainer!) { (entities) in
                DispatchQueue.main.async {
                    self.isFetching = false
                    guard let entities = entities else {return}
                    self.entities.append(contentsOf: entities)
                    let indexPathsToReload = self.calculateIndexPathsToReload(from: entities)
                    self.reloadNecessaryIndexPaths(with: indexPathsToReload)
                }
            }
        }
    
    }
    
    private func calculateIndexPathsToReload(from newEntities: [Entity]) -> [IndexPath] {
        let startIndex = self.entities.count - newEntities.count
        let endIndex = startIndex + newEntities.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
//    func fetchNextPage(){
//        if let nextPageUrlString = SwapiClient.shared.nextPageUrlString{
//            SwapiClient.shared.fetchEntityfor(urlString: nextPageUrlString, category: categoryContainer!) { (entities) in
//                
//            }
//        }
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension EntityTableViewController: UITableViewDataSourcePrefetching{
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(isLoadingCell){
            fetchEntities()
        }
    }
    
    var isLoadingCell: IndexPath {
        let row = entities.count - 1
        return IndexPath(row: row, section: 0)
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= entities.count
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath]{
    
            let indexPathsForVisibleRows = self.tableView.indexPathsForVisibleRows ?? []
            let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
            let returnArray: [IndexPath] = Array(indexPathsIntersection)
            return returnArray

    }
}
