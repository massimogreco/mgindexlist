//
//  ViewController.swift
//  MGIndexListContainer
//
//  Created by Massimo Greco on 04/07/16.
//  Copyright © 2016 Massimo Greco. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MGIndexListDelegate {

    @IBOutlet var indexList : MGIndexListView!
    @IBOutlet weak var indexListHorizontal: MGIndexListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sections = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","z"]
        
        indexList.delegate = self
        indexList.sections = sections
        indexList.buildStackView()
        
        let sectionsH = ["S","A","M","P","L","E"]
        indexListHorizontal.delegate = self
        indexListHorizontal.sections = sectionsH
        indexListHorizontal.stackView?.axis = .Horizontal
        
        indexListHorizontal.buildStackView()
    }
    
    func didSelectItem(itemSelected: String, sectionNumber: Int) {
        print("Item \(itemSelected) pressed - Section \(sectionNumber)")
    }
    
}

