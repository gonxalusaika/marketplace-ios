//
//  ListViewController.swift
//  teamsearchapp
//
//  Created by Gonzalo Lema on 4/18/20.
//  Copyright © 2020 Gonzalo Lema. All rights reserved.
//

import UIKit
import AlamofireImage

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var items : [ItemModel] = []
    var selectedRow: Int?
    var site : String?
    var searchText : String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        searchItems(searchText: searchText!, site: site!) { searchResults in
            self.items = searchResults
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? ItemTableViewCell else {
            return UITableViewCell()
        }
        
        populateCell(cell: cell, item: items[indexPath.row])
        return cell
    }

    func populateCell(cell: ItemTableViewCell, item: ItemModel) {
        cell.lblName.text = item.name
        cell.lblPrice.text = "\(item.currency) \(item.price)"
        
        fetchImage(url: item.thumbnail) { response in
            cell.imgItem.image = response
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        self.performSegue(withIdentifier: "detalle", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let selected = selectedRow, let detailVC = segue.destination as? DetailViewController else {
            return
        }
        detailVC.item = items[selected]
    }
    
}
