//
//  Api.swift
//  teamsearchapp
//
//  Created by Gonzalo Lema on 5/5/20.
//  Copyright © 2020 Gonzalo Lema. All rights reserved.
//

import Foundation
import Alamofire

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

struct ItemDetails : Codable {
    let title: String
    let id: String
    let price: Double
    let currency_id: String
    let pictures: [PictureDetails]
    let geolocation: Geolocation?
}

struct ItemDescription : Codable {
    let plain_text: String
}

struct Geolocation : Codable {
    let longitude: Double
    let latitude: Double
}

struct PictureDetails : Codable {
    let secure_url: String
}

struct SearchResultModel : Codable {
    let results: [ItemModel]?
}

func searchItems(searchText : String, site : String, callback : @escaping([ItemModel]) -> ()) -> Void {
    AF.request("https://api.mercadolibre.com/sites/\(site)/search?q=\(searchText)", method: .get)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseDecodable(of: SearchResultModel.self) { response in
            if let searchResults = response.value?.results {
                callback(searchResults)
            }
            else {
                print(response)
            }
        }
}

func fetchItemDetails(itemId : String, callback : @escaping(ItemDetails) -> ()) -> Void {
    AF.request("https://api.mercadolibre.com/items/\(itemId)", method: .get)
    .validate(statusCode: 200..<300)
    .validate(contentType: ["application/json"])
        .responseJSON() { response in
            print(response)
    }
    .responseDecodable(of: ItemDetails.self) { response in
        if case .success(let searchResults) = response.result {
            callback(searchResults)
        }
        else {
            print(response)
        }
    }
}

func fetchItemDescription(itemId : String, callback : @escaping(ItemDescription) -> ()) -> Void {
    AF.request("https://api.mercadolibre.com/items/\(itemId)/description", method: .get)
    .validate(statusCode: 200..<300)
    .validate(contentType: ["application/json"])
        .responseJSON() { response in
            print(response)
    }
    .responseDecodable(of: ItemDescription.self) { response in
        if case .success(let descriptionResult) = response.result {
            callback(descriptionResult)
        }
        else {
            print(response)
        }
    }
}

func fetchImage(url : String, callback: @escaping(UIImage) -> ()) -> Void {
    AF.request(url, method: .get)
    .responseImage{ response in
        if case .success(let image) = response.result {
            callback(image)
        }
    }
}
