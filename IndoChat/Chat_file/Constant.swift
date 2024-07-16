//
//  Constant.swift
//  IndoChat
//
//  Created by Apple on 24/01/23.
//

import Foundation
import UIKit



class Constant {
    static var Enabled: Bool {
        return true
    }
    // For Firebase chat -
    static let MY_NAME = "ROHIT"
    static let MAIN_NODE = "INDOCHAT"
    static let OTHER_NAME = "RAJ"
    static let CHATS = "CHATS"
    static var Current_User = FireBaseUser(jsonSnapshot: [:], messageKey: "")
    
    

}

