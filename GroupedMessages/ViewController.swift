//
//  ViewController.swift
//  GroupedMessages
//
//  Created by Pavlos Nicolaou on 21/04/2019.
//  Copyright © 2019 Pavlos Nicolaou. All rights reserved.
//

import UIKit

struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}

extension Date {
    static func dateFromCustomString(customString: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
}

class ViewController: UITableViewController {
    
    fileprivate let cellId = "id123"

//    let chatMessages = [
//        [
//            ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "03/08/2018")),
//            ChatMessage(text: "I'm going to message another long message that will word wrap.I'm going to message another long message that will word wrap.I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "03/08/2018"))
//        ],
//        [
//            ChatMessage(text: "Here's my very first message", isIncoming: false, date: Date.dateFromCustomString(customString: "04/03/2019")),
//            ChatMessage(text: "I'm going to message another long message that will word wrap.I'm going to message another long message that will word wrap.I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "04/03/2019")),
//            ChatMessage(text: "Yo, dawg, Whaddup?", isIncoming: true, date: Date.dateFromCustomString(customString: "04/03/2019"))
//        ],
//        [
//            ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "10/04/2019"))
//        ],
//    ]
    
    let messagesFromServer = [
        ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "03/08/2018")),
        ChatMessage(text: "I'm going to message another long message that will word wrap.I'm going to message another long message that will word wrap.I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "03/08/2018")),
        ChatMessage(text: "Here's my very first message", isIncoming: false, date: Date.dateFromCustomString(customString: "04/03/2019")),
        ChatMessage(text: "I'm going to message another long message that will word wrap.I'm going to message another long message that will word wrap.I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "04/03/2019")),
        ChatMessage(text: "Yo, dawg, Whaddup?", isIncoming: true, date: Date.dateFromCustomString(customString: "04/03/2019")),
        ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "10/04/2019"))
    ]
    
    fileprivate func attemptToAssembleGroupedMessages() {
        print("Attempt to group our message together based on the Date property")
        
        let groupedMessages = Dictionary(grouping: messagesFromServer) { (element) -> Date in
            return element.date
        }
        
        //provide a sorting for your keys somehow
        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach { (key) in
            let values = groupedMessages[key]
            chatMessages.append(values ?? [])
        }
    }
    
    var chatMessages = [[ChatMessage]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptToAssembleGroupedMessages()
        
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    class DateHeaderLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = .black
            textColor = .white
            textAlignment = .center
            translatesAutoresizingMaskIntoConstraints = false //enables auto layout
            font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize {
            let originalContentSize = super.intrinsicContentSize
            let height = originalContentSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            return CGSize(width: originalContentSize.width + 20, height: height)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let firstMessageInSection = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateFormatter.string(from: firstMessageInSection.date)
            
            let label = DateHeaderLabel()
            label.text = dateString
            
            let containerView = UIView()
            
            containerView.addSubview(label)
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
        }
        
       return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if let firstMessageInSection = chatMessages[section].first {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd/MM/yyyy"
//            let dateString = dateFormatter.string(from: firstMessageInSection.date)
//            return dateString
//        }
//        return "Section: \(Date())"
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
//        let chatMessage = chatMessages[indexPath.row]

        let chatMessage = chatMessages[indexPath.section][indexPath.row]
        
        cell.chatMessage = chatMessage
        
//        cell.isIncoming = indexPath.row % 2 == 0 //checks for odd/even
        
        return cell
    }

}

