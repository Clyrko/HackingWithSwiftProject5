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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
        if let startWords = try? String(contentsOf: startWordsURL) {
            
            allWords = startWords.components(separatedBy: "\n")
            
            }
        }
        
        if allWords.isEmpty {
            
            allWords = ["silkworm"]
            
        }
        
        startGame()
        
    }
    
    @objc func promptForAnswer() {
        
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
            
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }

    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usedWords.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
        
    }
    
    // Checks if the word can be made
    func isPossible(word: String) -> Bool {
        
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            
            if let position = tempWord.firstIndex(of: letter) {
                
                tempWord.remove(at: position)
                
            } else {
                
                return false
                
            }
            
        }
        
        return true
        
    }

    // Checks if the word is a duplicate
    func isOriginal(word: String) -> Bool {
        
        return !usedWords.contains(word)
        
    }

    // Check if the word is a valid english word
    func isReal(word: String) -> Bool {
        
        return true
        
    }
    
    func submit(_ answer: String) {
        
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) {
            
            if isOriginal(word: lowerAnswer) {
                
                if isReal(word: lowerAnswer) {
                    
                    // If all 3 statements are true, insert word into array. Makes new word appear on top of list
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                }
                
            }
            
        }
        
    }
    
}

