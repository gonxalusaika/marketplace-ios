//
//  ListViewController.swift
//  teamsearchapp
//
//  Created by Gonzalo Lema on 4/18/20.
//  Copyright © 2020 Gonzalo Lema. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

struct ItemModel : Codable {
    let name: String
    let price: Double
    let id: String
    let thumbnail: String
    let currency : String
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case price
        case id
        case thumbnail
        case currency = "currency_id"
    }
}

struct SearchResultModel : Codable {
    let results: [ItemModel]?
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var items : [ItemModel] = []
    var selectedRow: Int?
    var site : String?
    var searchText : String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        AF.request("https://api.mercadolibre.com/sites/\(site!)/search?q=\(searchText!)", method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: SearchResultModel.self) { response in
                if let searchResults = response.value?.results {
                    self.items = searchResults
                    self.tableView.reloadData()
                }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let selected = selectedRow, let detailVC = segue.destination as? DetailViewController else {
            return
        }
        detailVC.item = items[selected]
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
        
        AF.request(item.thumbnail, method: .get)
            .responseImage{ response in
                if case .success(let image) = response.result {
                    cell.imgItem.image = image
                }
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        self.performSegue(withIdentifier: "detalle", sender: self)
    }
}
