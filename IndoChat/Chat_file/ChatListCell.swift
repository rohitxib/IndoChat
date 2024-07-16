//
//  ChatListCell.swift
//  IndoChat
//
//  Created by Apple on 25/01/23.
//

import UIKit

class ChatListCell: UITableViewCell {
    @IBOutlet weak var lblUser: UILabel!
    
    @IBOutlet weak var imgUser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
