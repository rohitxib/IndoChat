//
//  ChatTblCell.swift
//  IndoChat
//
//  Created by Apple on 19/01/23.
//

import UIKit

class ChatTblCell: UITableViewCell {

    @IBOutlet weak var leadConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var trailConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func displayCell(chatModel:ChatModel) {
        lblMessage.text = chatModel.message
        if chatModel.uid == Constant.Current_User.Chat_userUID {
            leadConstraint.constant = 100
            trailConstraint.constant = 0

            lblMessage.textAlignment = .right
           // lblMessage.backgroundColor = UIColor.blue
        }else{
            trailConstraint.constant = 100
            leadConstraint.constant = 0
            lblMessage.backgroundColor = UIColor.lightGray
            lblMessage.textAlignment = .left
        }
    }
}
