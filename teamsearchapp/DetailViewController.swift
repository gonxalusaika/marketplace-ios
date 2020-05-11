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
import Auk

class DetailViewController: UIViewController {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var carrouselImages: UIScrollView!
    var item : ItemModel?
    var detailedItem : ItemDetails?
    var imageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let uItem = item {
            
            fetchItemDetails(itemId: uItem.id) { response in
                self.detailedItem = response
                
                self.lblName.text = response.title
                self.lblPrice.text = "\(response.currency_id) \(response.price)"
                
                response.pictures.forEach() { picture in
                    self.carrouselImages.auk.show(url: picture.secure_url)
                }
            }
            
            fetchItemDescription(itemId: uItem.id) { response in
                self.lblDescription.text = response.plain_text
            }
        }
    }
    
}
