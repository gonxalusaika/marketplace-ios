//
//  History.swift
//  teamsearchapp
//
//  Created by Gonzalo Lema on 5/9/20.
//  Copyright © 2020 Gonzalo Lema. All rights reserved.
//

import Foundation

struct HistoryItem : Codable {
    let term: String
    let site: String
}

let history_key = "history"

func saveToHistory(term: String, site: String) {
    var history = fetchHistory()
    
    history.insert(HistoryItem(term: term, site: site), at: 0)
    
    UserDefaults.standard.set(try? PropertyListEncoder().encode(history), forKey: history_key)
}

func fetchHistory() -> [HistoryItem] {
    
    let storage = UserDefaults.standard
    
    if let currentHistory = storage.value(forKey: history_key) as? Data {
        return try! PropertyListDecoder().decode([HistoryItem].self, from: currentHistory)
    }
    return [HistoryItem]()
}
