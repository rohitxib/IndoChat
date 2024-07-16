//
//  ChatModel.swift
//  IndoChat
//
//  Created by Apple on 24/01/23.
//

import Foundation

struct ChatModel {
    var messageKey:String?
    var message : String?
    var senderName : String?
    var timestamp : String?
    var uid : String?
    
    init(jsonSnapshot:[String:Any],messageKey:String){
        message = jsonSnapshot["message"] as? String
        senderName = jsonSnapshot["senderName"] as? String
        uid = jsonSnapshot["uid"] as? String
        timestamp = jsonSnapshot["timestamp"] as? String
        self.messageKey = messageKey
    }
}

struct FireBaseUser {
    var Chat_userName:String?
    var Chat_userUID : String?
    var user_snapshot_ID : String?
    
    
    init(jsonSnapshot:[String:Any],messageKey:String){
        Chat_userName = jsonSnapshot["Chat_userName"] as? String
        Chat_userUID = jsonSnapshot["Chat_userUID"] as? String
        user_snapshot_ID = messageKey
    }
}


