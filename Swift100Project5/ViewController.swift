//
//  ViewController.swift
//  Swift100Project5
//
//  Created by Jay A. on 4/6/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
        if let startWords = try? String(contentsOf: startWordsURL) {
            
            allWords = startWords.components(separatedBy: "/n")
            
            }
        }
        
        if allWords.isEmpty {
            
            allWords = ["silkworm"]
            
        }
        
        startGame()
        
    }

    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
}

