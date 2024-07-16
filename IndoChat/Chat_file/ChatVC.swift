//
//  ChatVC.swift
//  IndoChat
//
//  Created by Apple on 19/01/23.

// 13 = rt.iot   12 = rohit1000 11 = raj 8 = jugalsir
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class ChatVC: UIViewController {

    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var chatTable: UITableView!
    var bothChaterName = [String()]
    
    private let F_DB_Refrence = Database.database().reference()
    var messages = [ChatModel]()
    var chatUser = FireBaseUser(jsonSnapshot: [:], messageKey: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
      registerTableViewCells()
        chatTable.dataSource = self
        chatTable.delegate = self
        bothChaterName.append(chatUser.Chat_userName!)
        bothChaterName.append(Constant.Current_User.Chat_userName!)
        self.navigationItem.title = chatUser.Chat_userName!
       
        observeMessage()
    }
   
    @IBAction func btnActionSendMessage(_ sender: Any) {
        sentTo_FDB()
    }
}
// mark: for firebase realtimeDB
extension ChatVC{
    func sentTo_FDB() {
        let userPath = chatChanelFor()
        let messageRef = F_DB_Refrence.child(Constant.MAIN_NODE).child(Constant.CHATS).child("ChatChanels").child(userPath).child("MESSAGESS")
        let childRef = messageRef.childByAutoId()
        
        var message: [String : Any] = [:]
        guard let msg = txtMessage.text else {
            return
        }
        txtMessage.text = ""
        message =  ["message":msg,
                    "senderName":Constant.MY_NAME,
                    "timestamp": formatOfDate(forServer: Date()) ?? "",
                    "uid":Constant.Current_User.Chat_userUID]
        childRef.updateChildValues(message) { (error, ref) in
            if error != nil {
                print(error!)
                return
            } else {
                print(ref)}
        }
    }
    
    func observeMessage() {
        let userPath = chatChanelFor()
       
        if Auth.auth().currentUser != nil {
            let messageRef = F_DB_Refrence.child(Constant.MAIN_NODE).child(Constant.CHATS).child("ChatChanels").child(userPath).child("MESSAGESS")
            /////
            messages.removeAll()
            messageRef.observe(.childAdded, with: { (snapshot) in
                guard let dic = snapshot.value as? [String: Any] else { return }
                let message = ChatModel(jsonSnapshot: dic, messageKey: snapshot.key)
                self.messages.append(message)
                self.chatTable.reloadData()
            }, withCancel: nil)
        }
    }
    // mark creating four chanels
    func chatChanelFor() -> String {var chanel = ""
        if bothChaterName.contains("rd") && bothChaterName.contains("rohit1000") {
            chanel = "rd_rohit1000"
        }else if bothChaterName.contains("rd") && bothChaterName.contains("raj") {
            chanel = "rd_raj"
        }else if bothChaterName.contains("rd") && bothChaterName.contains("JugalSir") {
            chanel = "rd_JugalSir"
        }else if bothChaterName.contains("rohit1000") && bothChaterName.contains("raj") {
            chanel = "rohit1000_raj"
        }else if bothChaterName.contains("rohit1000") && bothChaterName.contains("JugalSir") {
            chanel = "rohit1000_JugalSir"
        }else if bothChaterName.contains("raj") && bothChaterName.contains("JugalSir") {
            chanel = "raj_JugalSir"
        }
        return chanel
    }
}

// mark for local methods
extension ChatVC{
    func formatOfDate(forServer date: Date?) -> String? {
        if let date = date {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            dateFormat.timeZone = NSTimeZone(name: "UTC")! as TimeZone
            var dateStr: String? = nil
            dateStr = dateFormat.string(from: date)
            return dateStr
        } else {
            return "No time available"
        }
    }
    private func registerTableViewCells() {
        let cell = UINib(nibName: "ChatTblCell",
                                  bundle: nil)
        self.chatTable.register(cell,
                                forCellReuseIdentifier: "ChatTblCell")
    }
}
// mark tableview
extension ChatVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTable.dequeueReusableCell(withIdentifier: "ChatTblCell") as! ChatTblCell
        cell.displayCell(chatModel: messages[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    
}
