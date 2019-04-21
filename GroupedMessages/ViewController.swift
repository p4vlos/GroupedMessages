//
//  ViewController.swift
//  GroupedMessages
//
//  Created by Pavlos Nicolaou on 21/04/2019.
//  Copyright © 2019 Pavlos Nicolaou. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    fileprivate let cellId = "id123"
    
    let textMessages = [
    "Here's my very first message",
    "I'm going to message another long message that will word wrap",
    "I'm going to message another long message that will word wrap.I'm going to message another long message that will word wrap.I'm going to message another long message that will word wrap"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textMessages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        
//        cell.textLabel?.text = "We want to provide a longer string that is actually going to wrap into the next line and maybe even a third line."

//        cell.textLabel?.numberOfLines = 0
        
        cell.messageLabel.text = textMessages[indexPath.row]
        return cell
    }

}

