//
//  ChatMessageCell.swift
//  GroupedMessages
//
//  Created by Pavlos Nicolaou on 21/04/2019.
//  Copyright © 2019 Pavlos Nicolaou. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {

    let messageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(messageLabel)
        messageLabel.backgroundColor = .green
        messageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
