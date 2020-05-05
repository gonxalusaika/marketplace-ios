//
//  DetailViewController.swift
//  teamsearchapp
//
//  Created by Gonzalo Lema on 4/21/20.
//  Copyright © 2020 Gonzalo Lema. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgItemImage: UIImageView!
    var item : ItemModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let uItem = item {
            lblName.text = uItem.name
            lblPrice.text = "\(uItem.currency) \(uItem.price)"
            
            AF.request(uItem.thumbnail, method: .get)
            .responseImage{ response in
                if case .success(let image) = response.result {
                    self.imgItemImage.image = image
                }
            }
        }
    }
    
}
