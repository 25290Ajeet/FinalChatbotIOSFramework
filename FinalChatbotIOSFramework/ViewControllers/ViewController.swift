//
//  ViewController.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 18/07/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

//import UIKit
//import XMPPFramework
//import JSQMessagesViewController
//import JSQSystemSoundPlayer
//import BraintreeDropIn
//import Braintree
//
//
//
//class ViewController: JSQMessagesViewController {
//    
//    var isDisplayed = false
//    var buttonsIndexPath : IndexPath?
//    var message:Array = [JSQMessage]()
//    var userId:String?
//    weak var logInViewController: LogInViewController?
//    var logInPresented = false
//    var xmppController: XMPPController!
//    let xmppRosterStorage = XMPPRosterCoreDataStorage()
//    var xmppRoster: XMPPRoster!
//    
//    let clientToken = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiI4NmMyOGMyYTYzOWQ1MmFhZTUxOGExNjU2ZDA5MDlhYTRkOTdjMmJjMjc1MGExMDlkYmZhNTRlNWRlZjc5MjcwfGNyZWF0ZWRfYXQ9MjAxOC0wMS0yMlQxMDo0OTo1Ny4zMzMyNTQ3NTArMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJjaGFsbGVuZ2VzIjpbXSwiZW52aXJvbm1lbnQiOiJzYW5kYm94IiwiY2xpZW50QXBpVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzLzM0OHBrOWNnZjNiZ3l3MmIvY2xpZW50X2FwaSIsImFzc2V0c1VybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXV0aFVybCI6Imh0dHBzOi8vYXV0aC52ZW5tby5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIiwiYW5hbHl0aWNzIjp7InVybCI6Imh0dHBzOi8vY2xpZW50LWFuYWx5dGljcy5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0="
//    
//    
//    var contentStruct : ContentStruct?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.automaticallyScrollsToMostRecentMessage = false
//        self.collectionView.register(CustomBotCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
//        
//        
//    }
//    
//    //MARK: Payment
//    func showDropIn(clientTokenOrTokenizationKey: String) {
//        let request =  BTDropInRequest()
//        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
//        { (controller, result, error) in
//            if (error != nil) {
//                print("ERROR")
//            } else if (result?.isCancelled == true) {
//                print("CANCELLED")
//            } else if result != nil {
//                print(result.debugDescription)
//                print(result?.description)
//            }
//            controller.dismiss(animated: true, completion: nil)
//        }
//        self.present(dropIn!, animated: true, completion: nil)
//    }
//    
//    func postNonceToServer(paymentMethodNonce: String) {
//        // Update URL with your server
//        let paymentURL = URL(string: "https://your-server.example.com/payment-methods")!
//        var request = URLRequest(url: paymentURL)
//        request.httpBody = "payment_method_nonce=\(paymentMethodNonce)".data(using: String.Encoding.utf8)
//        request.httpMethod = "POST"
//        URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
//            // TODO: Handle success or failure
//            }.resume()
//    }
//    
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//    }
//    
//    
//    func sendIQ() {
//        let iq = DDXMLElement.element(withName: "iq") as! DDXMLElement
//        iq.addAttribute(withName: "id", stringValue: "asas213123")
//        iq.addAttribute(withName: "type", stringValue: "get")
//        iq.addAttribute(withName: "to", stringValue: "mobility.telusinternational.com")
//        iq.addAttribute(withName: "xmlns", stringValue: "jabber:client")
//        
//        let query = DDXMLElement.element(withName: "query") as! DDXMLElement
//        query.addAttribute(withName: "xmlns", stringValue: "xavbot:simulate:create:room")
//        
//        iq.addChild(query)
//        xmppController.xmppStream.send(iq)
//        
//    }
//    
//    
//    
//    func sendDataToServer(data : String){
//        
//        let arrayOfDictionaries = ["log":"true","form_type":"click","timezoneOffset":"-339","msg":data,"bot_id":1,"bot_name":"null","language_id":"en","template_id":0,"context_id":1864,"sentiment":0] as [String : Any]
//        
//        var error : NSError?
//        
//        let jsonData = try! JSONSerialization.data(withJSONObject: arrayOfDictionaries, options:[])
//        
//        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
//        
//        
//        
//        let str = "![CDATA[" + jsonString + "]]"
//        print(str)
//        
//        //        print(arrayOfDictionaries.toJSONString())
//        
//        let body = DDXMLElement.element(withName: "body", stringValue: str) as! DDXMLElement
//        let messageID = xmppController.xmppStream.generateUUID
//        
//        let completeMessage = DDXMLElement.element(withName: "message") as! DDXMLElement
//        
//        // completeMessage.addAttribute(withName: "id", stringValue: messageID!)
//        completeMessage.addAttribute(withName: "type", stringValue: "groupchat")
//        completeMessage.addAttribute(withName: "to", stringValue: "bot_987099@conference.mobility.telusinternational.com")
//        completeMessage.addAttribute(withName: "from", stringValue: "987099@mobility.telusinternational.com")
//        completeMessage.addAttribute(withName: "subject", stringValue: "WEB")
//        completeMessage.addAttribute(withName: "xml:lang", stringValue: "en")
//        
//        completeMessage.addChild(body)
//        
//        //        let active = DDXMLElement.element(withName: "active", stringValue:
//        //            "http://jabber.org/protocol/chatstates") as! DDXMLElement
//        //        completeMessage.addChild(active)
//        print(   xmppController.xmppStream.isConnected)
//        
//        xmppController.xmppStream.send(completeMessage)
//        
//        message.append(JSQMessage.init(senderId: self.userId, displayName: self.userId, text: data))
//        super.collectionView.reloadData()
//        self.inputToolbar.contentView.textView.text = ""
//        super.collectionView.scrollToLastItem(at: .top, animated: false)
//        
//    }
//    
//    
//    
//    
//    func sendWelcomeToServer(data : String){
//        
//        let arrayOfDictionaries = ["welcome_msg_check":"true","username": "Ajeet Yadav","email": "ajeet@gmail.com","phone":4545454,"log":"true","form_type":"click","timezoneOffset":"-339","msg":"GETAWELCOMEMESSAGE","bot_id":1,"bot_name":"null","language_id":"en","template_id":0,"context_id":0] as [String : Any]
//        
//        var error : NSError?
//        
//        let jsonData = try! JSONSerialization.data(withJSONObject: arrayOfDictionaries, options:[])
//        
//        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
//        
//        
//        
//        let str = "![CDATA[" + jsonString + "]]"
//        print(str)
//        
//        //        print(arrayOfDictionaries.toJSONString())
//        
//        let body = DDXMLElement.element(withName: "body", stringValue: str) as! DDXMLElement
//        let messageID = xmppController.xmppStream.generateUUID
//        
//        let completeMessage = DDXMLElement.element(withName: "message") as! DDXMLElement
//        
//        // completeMessage.addAttribute(withName: "id", stringValue: messageID!)
//        completeMessage.addAttribute(withName: "type", stringValue: "groupchat")
//        completeMessage.addAttribute(withName: "to", stringValue: "bot_987099@conference.mobility.telusinternational.com")
//        completeMessage.addAttribute(withName: "from", stringValue: "987099@mobility.telusinternational.com")
//        completeMessage.addAttribute(withName: "subject", stringValue: "WEB")
//        completeMessage.addAttribute(withName: "xml:lang", stringValue: "en")
//        
//        completeMessage.addChild(body)
//        
//        //        let active = DDXMLElement.element(withName: "active", stringValue:
//        //            "http://jabber.org/protocol/chatstates") as! DDXMLElement
//        //        completeMessage.addChild(active)
//        print(xmppController.xmppStream.isConnected)
//        xmppController.xmppStream.send(completeMessage)
//        message.append(JSQMessage.init(senderId: self.userId, displayName: self.userId, text: data))
//        super.collectionView.reloadData()
//        self.inputToolbar.contentView.textView.text = ""
//        super.collectionView.scrollToLastItem(at: .top, animated: false)
//        
//    }
//    
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        if !self.logInPresented {
//            self.logInPresented = true
//            self.performSegue(withIdentifier: "LogInViewController", sender: nil)
//        }
//        
//        self.userId = (UserDefaults.standard.value(forKey: "UserId") as? String)
//        if (self.userId != nil){
//            let customView = UIView.init(frame: CGRect(x: 0, y: 0, width: 160, height: 40))
//            let avatarImage = UIImage(named: "user")
//            let avatarView = UIImageView(image:avatarImage)
//            customView.addSubview(avatarView)
//            let label = UILabel(frame: CGRect(x: 14, y: 8, width: 100, height: 21))
//            label.font.withSize(13)
//            label.textAlignment = .right
//            label.text = "XAV BOT"
//            label.textColor = UIColor.white
//            customView.addSubview(label)
//            let buttonItem = UIBarButtonItem.init(customView: customView)
//            self.navigationItem.leftBarButtonItem = buttonItem
//            self.senderId = self.userId
//        }
//        
//        // self.sendDataToServer(data: "")
//        
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "LogInViewController" {
//            let viewController = segue.destination as! LogInViewController
//            viewController.delegate = self
//        }
//    }
//}
//extension UICollectionView {
//    func scrollToLastItem(at scrollPosition: UICollectionView.ScrollPosition = .centeredHorizontally, animated: Bool = true) {
//        let lastSection = numberOfSections - 1
//        guard lastSection >= 0 else { return }
//        let lastItem = numberOfItems(inSection: lastSection) - 1
//        guard lastItem >= 0 else { return }
//        let lastItemIndexPath = IndexPath(item: lastItem, section: lastSection)
//        scrollToItem(at: lastItemIndexPath, at: scrollPosition, animated: animated)
//    }
//}
//// MARK: CustomBotDelegateni
//extension ViewController : CustomBotDelegate{
//    func setSecetdBotOption(choiceOption: String) {
//        let optionString = contentStruct?.buttons![choiceOption] as! String
//        self.message.removeLast()
//        super.collectionView.deleteItems(at: [buttonsIndexPath!])
//        sendDataToServer(data: optionString)
//        super.collectionView.scrollToLastItem(at: .top, animated: false)
//        
//        // self.showDropIn(clientTokenOrTokenizationKey: clientToken)
//        
//    }
//    func setPaymentOptionSelected(){
//        self.showDropIn(clientTokenOrTokenizationKey: clientToken)
//        super.collectionView.scrollToLastItem(at: .top, animated: false)
//    }
//    
//    
//}
//extension ViewController: LogInViewControllerDelegate {
//    
//    func didTouchLogIn(sender: LogInViewController, userJID: String, userPassword: String, server: String) {
//        self.logInViewController = sender
//        
//        do {
//            try self.xmppController = XMPPController(hostName: server,
//                                                     userJIDString: userJID,
//                                                     password: userPassword)
//            self.xmppController.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
//            self.xmppController.connect()
//        }
//        catch {
//            sender.showErrorMessage(message: "Something went wrong")
//        }
//    }
//}
//
//extension ViewController: XMPPStreamDelegate{
//    
//    func xmppMessageArchiveManagement(_ xmppMessageArchiveManagement: XMPPMessageArchiveManagement, didReceiveMAMMessage message: XMPPMessage) {
//        print(message.body)
//    }
//    
//    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
//        self.sendIQ()
//        self.logInViewController?.dismiss(animated: true, completion: nil)
//    }
//    
//    func xmppStream(_ sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
//        self.logInViewController?.showErrorMessage(message: "Wrong password or username")
//    }
//    
//    //    - (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq;
//    //
//    //    func <#name#>(<#parameters#>) -> <#return type#> {
//    //        <#function body#>
//    //    }
//    
//    
//    func xmppStream(_ sender: XMPPStream, didReceive iq: XMPPIQ) -> Bool {
//        if iq.attributeStringValue(forName: "id") == "asas213123"{
//            print(iq.description)
//            self.sendWelcomeToServer(data: "")
//        }
//        
//        return true
//    }
//    
//    
//    func xmppStream(_ sender: XMPPStream!, didReceive message: XMPPMessage!) {
//        if let checkStr : String = message.body{
//            print(checkStr)
//            if(!checkStr.contains("![CDATA[")){
//                return
//            }
//        }
//        if( message?.body == nil){
//            return
//        }
//        
//        let removedCDATA = message.body?.replacingOccurrences(of: "![CDATA[", with: "")
//        print(removedCDATA)
//        let removedBracket = removedCDATA?.dropLast().dropLast()
//        print(removedBracket)
//        let removedBackSlash = removedBracket?.replacingOccurrences(of: "/", with: "")
//        print(removedBackSlash)
//        guard let jsonDict = removedBackSlash?.convertToDictionary() else {
//            return
//        }
//        print(jsonDict)
//        if let content = jsonDict["content"] as? String {
//            self.messageDidReceived(messageText: content, senderId: message.from?.user! as! String)
//            super.collectionView.scrollToLastItem(at: .top, animated: false)
//            return
//        }
//        
//        let cont =  jsonDict["content"] as! NSDictionary? as? [AnyHashable: Any] ?? [:]
//        print(cont)
//        if cont.count > 0{
//            contentStruct = ContentStruct(data: cont as NSDictionary)
//            let userSenderId = message.from?.user! as! String
//            self.message.append(JSQMessage.init(senderId: userSenderId, displayName: userSenderId, text: contentStruct?.message))
//            // self.message.append(JSQMessage.init(senderId: userSenderId, displayName: userSenderId, text: "messageText"))
//            super.collectionView.reloadData()
//            super.collectionView.scrollToLastItem(at: .top, animated: false)
//        }
//    }
//}
//
//struct ContentStruct{
//    var message : String?
//    var link : NSDictionary?
//    var buttons : NSDictionary?
//    var tableCoulumns : NSArray?
//    var tableRows : NSArray?
//    var responseArray : NSArray?
//    var responseDict : NSDictionary?
//    var messageArray : NSArray?
//    
//    
//    init(data : NSDictionary){
//        print(data)
//        responseArray = data["response_list"] as? NSArray
//        responseDict = responseArray?[0] as? NSDictionary
//        messageArray = responseDict?["response"] as? NSArray
//        message = messageArray?[0] as! String
//        buttons = data["buttons"] as? NSDictionary
//        link = data["link"] as? NSDictionary
//        tableRows = data["table_rows"] as? NSArray
//        tableCoulumns = data["table_columns"] as? NSArray
//        
//    }
//}
//
////MARK : JSQMessageViewController
//
//extension ViewController {
//    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
//        
//        if let jsqmessage : JSQMessage = self.message.last{
//            if(jsqmessage.text == "messageText"){
//                self.message.removeLast()
//            }
//            
//        }
//        //        if text == "Hi"{
//        //            self.sendWelcomeToServer(data: text)
//        //        }
//        //        else{
//        self.sendDataToServer(data: text)
//        
//        // }
//        // self.sendDataToServer(data: text)
//        
//        
//        
//    }
//    
//    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
//        return nil
//        let bubble: JSQMessagesBubbleImageFactory = JSQMessagesBubbleImageFactory(bubble: UIImage.jsq_bubbleRegularTailless(), capInsets: .zero)
//        
//        if (message[indexPath.item].senderId != self.userId){
//            return bubble.incomingMessagesBubbleImage(with: UIColor(hexString: "#e7f0faff"))
//        } else {
//            return bubble.outgoingMessagesBubbleImage(with:UIColor(hexString: "#0697ffff"))
//        }
//    }
//    
//    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
//        if (message[indexPath.item].senderId != self.userId){
//            let image = UIImage(named:"xavbot")!
//            let avatar = JSQMessagesAvatarImage.avatar(with: image)
//            return avatar
//        } else {
//            let image = UIImage()
//            let avatar = JSQMessagesAvatarImage.avatar(with: image)
//            return avatar
//        }
//    }
//    
//    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
//        
//        let jsqMessageData: JSQMessageData = message[indexPath.row]
//        return jsqMessageData
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return message.count
//    }
//    
//    override func didPressAccessoryButton(_ sender: UIButton!) {
//        print("Camera")
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let jsqMessageData: JSQMessageData = message[indexPath.row]
//        print( message[indexPath.row])
//        let dummyText = jsqMessageData.text!()
//        print(dummyText)
//        if (dummyText == "messageText"){
//            buttonsIndexPath = indexPath
//            var cell : CustomBotCollectionViewCell?
//            if(cell == nil){
//                cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomBotCollectionViewCell
//                
//                cell?.createDyanamicButtons(data: contentStruct!)
//                
//                cell?.delegate = self
//                
//            }
//            return cell!
//        }else {
//            let cell : JSQMessagesCollectionViewCell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
//            cell.messageBubbleContainerView.layer.cornerRadius = 8.0
//            if (message[indexPath.item].senderId != self.userId){
//                cell.textView.textColor = UIColor.darkGray
//                cell.messageBubbleContainerView.backgroundColor = UIColor(red: 201/255, green: 222/255, blue: 242/255, alpha: 0.35)
//                
//            } else {
//                cell.messageBubbleContainerView.backgroundColor = UIColor(hexString: "#0697ffff")
//                cell.textView.textColor = UIColor.white
//                cell.textView.linkTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
//            }
//            return cell
//        }
//    }
//    
//    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAt indexPath: IndexPath!) -> CGFloat {
//        
//        
//        let jsqMessageData: JSQMessageData = message[indexPath.row]
//        print( message[indexPath.row])
//        let dummyText = jsqMessageData.text!()
//        print(dummyText)
//        
//        if (dummyText == "messageText"){
//            
//            var toAddComponent = 0
//            if(contentStruct?.link != nil){
//                toAddComponent = toAddComponent + 2
//            }
//            let totalCount = (contentStruct?.buttons?.count)! + (contentStruct?.tableRows?.count)! + (contentStruct?.tableCoulumns?.count)!
//            
//            return CGFloat((totalCount + toAddComponent) * 32)
//        } else{
//            return 20;
//        }
//    }
//    
//    override func scrollToBottom(animated: Bool) {
//        
//    }
//    
//    func messageDidReceived(messageText:String , senderId: String) {
//        message.append(JSQMessage.init(senderId: senderId, displayName: senderId, text: messageText))
//        super.collectionView.reloadData()
//    }
//}
//
//
//extension Collection where Iterator.Element == [String:AnyObject] {
//    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
//        if let arr = self as? [[String:AnyObject]],
//            let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
//            let str = String(data: dat, encoding: String.Encoding.utf8) {
//            return str
//        }
//        return "[]"
//    }
//}
//
//
//
