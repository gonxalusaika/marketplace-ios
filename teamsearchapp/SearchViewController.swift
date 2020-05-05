//
//  SearchViewController.swift
//  teamsearchapp
//
//  Created by Gonzalo Lema on 4/27/20.
//  Copyright © 2020 Gonzalo Lema. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let sites = ["MLA", "MLB", "MLU", "MLC"]
    
    @IBOutlet weak var sitePicker: UITextField!
    @IBOutlet weak var searchTextField: UITextField!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sites.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sites[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sitePicker.text = sites[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pickerView = UIPickerView()
        pickerView.delegate = self
        sitePicker.inputView = pickerView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let listView = segue.destination as? ListViewController else {
            return
        }
        listView.searchText = searchTextField.text
        listView.site = sitePicker.text
    }
    

}
