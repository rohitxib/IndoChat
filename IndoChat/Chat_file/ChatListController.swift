//
//  ChatListController.swift
//  IndoChat
//
//  Created by Apple on 25/01/23.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class ChatListController: UIViewController {

    @IBOutlet weak var tblChatList: UITableView!
    private let F_DB_Refrence = Database.database().reference()
    var firebaseUsers = [FireBaseUser]()

    override func viewDidLoad() {
        super.viewDidLoad()
registerTableViewCells()
        sign_in()
        listen_user()
        //sentTo_FDB()
        getAllFireBaseUsers()
    }
    private func registerTableViewCells() {
        tblChatList.dataSource = self
        tblChatList.delegate = self
        let cell = UINib(nibName: "ChatListCell",
                                  bundle: nil)
        self.tblChatList.register(cell,
                                forCellReuseIdentifier: "ChatListCell")
    }
}
// mark firebase_RealTmeDB
extension ChatListController{
    func sentTo_FDB() {
        let messageRef = F_DB_Refrence.child(Constant.MAIN_NODE).child(Constant.CHATS).child("Users").child("JugalSir")
        var message: [String : Any] = [:]
        message =  ["Chat_userName":"JugalSir","Chat_userUID":"kK6chOWdJ4Z7R7h0iOSH6lI8wTs1"]
        messageRef.updateChildValues(message) { (error, ref) in
            if error != nil {
                print(error!)
                return
            } else {
                print(ref)}
        }
    }
    func getAllFireBaseUsers() {//rd.iot.ios@gmail.com
        if Auth.auth().currentUser != nil {
            let userMessageRef = F_DB_Refrence.child(Constant.MAIN_NODE).child(Constant.CHATS).child("Users")
            /////
            firebaseUsers.removeAll()
            userMessageRef.observe(.childAdded, with: { (snapshot) in
                guard let dic = snapshot.value as? [String: Any] else { return }
                let message = FireBaseUser(jsonSnapshot: dic, messageKey: snapshot.key)
                if message.Chat_userUID == Constant.Current_User.Chat_userUID  { 
                    Constant.Current_User.Chat_userName = message.Chat_userName
                    self.navigationItem.title = Constant.Current_User.Chat_userName

                }else{
                    self.firebaseUsers.append(message)
                }
                self.tblChatList.reloadData()
            }, withCancel: nil)
        }
    }
    func  setCurrentUser(fireBaseUsers: [FireBaseUser]){
    }
}

// mark firebase_Auth
extension ChatListController{
    func sign_in() {//rd.iot.ios@gmail.com rohit.dwivedi1000
        Auth.auth().signIn(withEmail: "yraj72427@gmail.com@gmail.com@gmail.com", password: "123456") { [weak self] authResult, error in
          guard let strongSelf = self else { return }
        }    }
    
    func listen_user() {
        let handle = Auth.auth().addStateDidChangeListener { auth, user in
               if let user = user {
                   print("*******\(user.uid)")
                   Constant.Current_User.Chat_userUID = user.uid
                 let email = user.email
                 let photoURL = user.photoURL
                
                 var multiFactorString = "MultiFactor: "
                 for info in user.multiFactor.enrolledFactors {
                   multiFactorString += info.displayName ?? "[DispayName]"
                   multiFactorString += " "
                 }
               }
           }
    }
}
extension ChatListController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firebaseUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblChatList.dequeueReusableCell(withIdentifier: "ChatListCell") as! ChatListCell
        cell.lblUser.text = firebaseUsers[indexPath.row].Chat_userName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        vc.chatUser = firebaseUsers[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    
}
