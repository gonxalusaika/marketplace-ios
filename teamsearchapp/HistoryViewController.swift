//
//  HistoryViewController.swift
//  teamsearchapp
//
//  Created by Gonzalo Lema on 5/9/20.
//  Copyright © 2020 Gonzalo Lema. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableHistory: UITableView!
    var history : [HistoryItem] = []
    var selectedRow : Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        history = fetchHistory()
        
        tableHistory.delegate = self
        tableHistory.dataSource = self
        tableHistory.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        
        populateCell(cell: cell, item: history[indexPath.row])
        return cell
    }
    
    func populateCell(cell : HistoryTableViewCell, item : HistoryItem) {
        cell.lblTerm.text = item.term
        cell.lblSite.text = item.site
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        self.performSegue(withIdentifier: "list", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let selected = selectedRow, let listVC = segue.destination as? ListViewController else {
            return
        }
        
        let selectedHistory = history[selected]
        
        listVC.searchText = selectedHistory.term
        listVC.site = selectedHistory.site
    }

}
