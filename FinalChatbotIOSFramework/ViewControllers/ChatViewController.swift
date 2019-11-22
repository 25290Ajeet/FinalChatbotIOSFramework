/*
MIT License

Copyright (c) 2017-2018 MessageKit

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import UIKit
//import MessageKit
//import MessageInputBar
import XMPPFramework
import AVKit


/// A base class for the example controllers
class ChatViewController: MessagesViewController, MessagesDataSource {
    
   //007
    var isDisplayed = false
    var buttonsIndexPath : IndexPath?
   // var message:Array = [JSQMessage]()
    var userId:String?
    weak var logInViewController: LogInViewController?
    var logInPresented = false
    var xmppController: XMPPController!
    let xmppRosterStorage = XMPPRosterCoreDataStorage()
    var xmppRoster: XMPPRoster!
    var messageData:MessageData?
    
    let clientToken = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiI4NmMyOGMyYTYzOWQ1MmFhZTUxOGExNjU2ZDA5MDlhYTRkOTdjMmJjMjc1MGExMDlkYmZhNTRlNWRlZjc5MjcwfGNyZWF0ZWRfYXQ9MjAxOC0wMS0yMlQxMDo0OTo1Ny4zMzMyNTQ3NTArMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJjaGFsbGVuZ2VzIjpbXSwiZW52aXJvbm1lbnQiOiJzYW5kYm94IiwiY2xpZW50QXBpVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzLzM0OHBrOWNnZjNiZ3l3MmIvY2xpZW50X2FwaSIsImFzc2V0c1VybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXV0aFVybCI6Imh0dHBzOi8vYXV0aC52ZW5tby5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIiwiYW5hbHl0aWNzIjp7InVybCI6Imh0dHBzOi8vY2xpZW50LWFuYWx5dGljcy5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0="
    
    
    var contentStruct : ContentStruct?
    //007
    
  
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var messageList: [MockMessage] = []
    
    let refreshControl = UIRefreshControl()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMessageCollectionView()
        configureMessageInputBar()
        updateTitleView(title: "ChatBot", subtitle: "")
       // loadFirstMessages()
       // title = "MessageKit"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //007
        if !self.logInPresented {
            self.logInPresented = true
            self.performSegue(withIdentifier: "LogInViewController", sender: nil)
        }
        //007
        
//        MockSocket.shared.connect(with: [SampleData.shared.steven, SampleData.shared.wu])
//            .onNewMessage { [weak self] message in
//                self?.insertMessage(message)
//        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LogInViewController" {
            let viewController = segue.destination as! LogInViewController
            viewController.delegate = self
        }
    }
 
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        MockSocket.shared.disconnect()
    }
    
    func loadFirstMessages() {
//        DispatchQueue.global(qos: .userInitiated).async {
//            let count = UserDefaults.standard.mockMessagesCount()
//            SampleData.shared.getMessages(count: count) { messages in
//                DispatchQueue.main.async {
//                    self.messageList = messages
        defer{
            updateTitleView(title: "ChatBot", subtitle: "")
        }
        updateTitleView(title: "ChatBot", subtitle: "Typing...")

                    self.messagesCollectionView.reloadData()
                    self.messagesCollectionView.scrollToBottom()

    }
    
    @objc
    func loadMoreMessages() {
//        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1) {
//            SampleData.shared.getMessages(count: 20) { messages in
//                DispatchQueue.main.async {
//                    self.messageList.insert(contentsOf: messages, at: 0)
                    self.messagesCollectionView.reloadDataAndKeepOffset()
                    self.refreshControl.endRefreshing()
//                }
//            }
//        }
    }
    
    func configureMessageCollectionView() {
        
      //  messagesCollectionView = MessagesCollectionView(frame: .zero, collectionViewLayout: CustomMessagesFlowLayout())
      //  messagesCollectionView.register(QuickReplyButtonCollectionViewCell.self)
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
      
        
        scrollsToBottomOnKeyboardBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false
        
        messagesCollectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(loadMoreMessages), for: .valueChanged)
    }
    
    func configureMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.tintColor = .primaryColor
        messageInputBar.sendButton.tintColor = .primaryColor
    }
    
    // MARK: - Helpers
    
    func insertMessage(_ message: MockMessage) {
        messageList.append(message)
        // Reload last section to update header/footer labels and insert a new one
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([messageList.count - 1])
            if messageList.count >= 2 {
                messagesCollectionView.reloadSections([messageList.count - 2])
            }
        }, completion: { [weak self] _ in
            if self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToBottom(animated: true)
            }
        })
    }
    
    func isLastSectionVisible() -> Bool {
        
        guard !messageList.isEmpty else { return false }
        
        let lastIndexPath = IndexPath(item: 0, section: messageList.count - 1)
        
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
    
    
    // MARK: - UICollectionViewDataSource
    
//    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
//            fatalError("Ouch. nil data source for messages")
//        }
//
//        //        guard !isSectionReservedForTypingBubble(indexPath.section) else {
//        //            return super.collectionView(collectionView, cellForItemAt: indexPath)
//        //        }
//
//        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
//        if case .custom = message.kind {
//            let cell = messagesCollectionView.dequeueReusableCell(QuickReplyButtonCollectionViewCell.self, for: indexPath)
//            cell.configure(with: message, at: indexPath, and: messagesCollectionView)
//            return cell
//        }
//        return super.collectionView(collectionView, cellForItemAt: indexPath)
//    }
    
    
    
    // MARK: - MessagesDataSource
    func currentSender() -> Sender {
        return SampleData.shared.currentSender
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        print("messageList.count ==== \(messageList.count)")

        return messageList[indexPath.section]
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if indexPath.section % 3 == 0 {
            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        }
        return nil
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2)])
    }
    
}



// MARK: - LogInViewControllerDelegate
//AJEET
extension ChatViewController: LogInViewControllerDelegate {
    
    func didTouchLogIn(sender: LogInViewController, userJID: String, userPassword: String, server: String) {
        self.logInViewController = sender
        
        do {
            try self.xmppController = XMPPController(hostName: server,
                                                     userJIDString: userJID,
                                                     password: userPassword)
            self.xmppController.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
            self.xmppController.connect()
        }
        catch {
            sender.showErrorMessage(message: "Something went wrong")
        }
    }
}



// MARK: - ChatViewController Extension to send Data to XMPP Server

extension ChatViewController{

func sendIQ() {
    let iq = DDXMLElement.element(withName: "iq") as! DDXMLElement
    iq.addAttribute(withName: "id", stringValue: "asas213123")//UID...
    iq.addAttribute(withName: "type", stringValue: "get")
    iq.addAttribute(withName: "to", stringValue: "qamobility.telusinternational.com")//VHOST....
    iq.addAttribute(withName: "xmlns", stringValue: "jabber:client")
    
    let query = DDXMLElement.element(withName: "query") as! DDXMLElement
    query.addAttribute(withName: "xmlns", stringValue: "xavbot:simulate:create:room")
    
    iq.addChild(query)
    xmppController.xmppStream.send(iq)
    
}



func sendDataToServer(data : String){
    
    print(self.messageData as Any)
    
    let arrayOfDictionaries = ["bot_id":1,
                               "language_id":"en",
                               "context_life_span":self.messageData?.context_life_span as Any,
                               "contexts":self.messageData?.contexts as Any,
                               "user_details":self.messageData?.user_details as Any,
                               "timezoneOffset":"-339",
                               "channel":"Mobile",
                               "user_session_id": self.messageData?.user_session_id as Any,
                               "msg":data,
                               "log":"true",
                               "form_type":"click",
                               "bot_name":"null",
                               "template_id":0,
                               "context_id":self.messageData?.context_id as Any,
                               "sentiment":self.messageData?.sentiment as Any] as [String : Any]
    
    self.createRequestForServer(arrayOfDictionaries: arrayOfDictionaries, data: data)
}


    func createRequestForServer(arrayOfDictionaries:[String : Any], data:String) {
        var _ : NSError?
        let jsonData = try! JSONSerialization.data(withJSONObject: arrayOfDictionaries, options:[])
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        let str = "![CDATA[" + jsonString + "]]"
        print(str)
        //        print(arrayOfDictionaries.toJSONString())
        let body = DDXMLElement.element(withName: "body", stringValue: str) as! DDXMLElement
        _ = xmppController.xmppStream.generateUUID
        let completeMessage = DDXMLElement.element(withName: "message") as! DDXMLElement
        completeMessage.addAttribute(withName: "type", stringValue: "groupchat")
        completeMessage.addAttribute(withName: "to", stringValue: "bot_abcd@conference.qamobility.telusinternational.com")///"bot_"+username+"@conference."+VHOST
        completeMessage.addAttribute(withName: "from", stringValue: "abcd@qamobility.telusinternational.com")//username+"@"+VHOST
        completeMessage.addAttribute(withName: "subject", stringValue: "App")
        completeMessage.addAttribute(withName: "xml:lang", stringValue: "en")
        completeMessage.addChild(body)
        print(xmppController.xmppStream.isConnected)
        xmppController.xmppStream.send(completeMessage)
    }


func sendWelcomeToServer(data : String){
    print("SEND WELCOME MESSAGE")
    let arrayOfDictionaries = ["welcome_msg_check":"true","username": "Ajeet Yadav","email": "ajeet@gmail.com","phone":4545454,"log":"true","form_type":"click","timezoneOffset":"-339","msg":"GETAWELCOMEMESSAGE","bot_id":1/*bot Id*/ ,"bot_name":"null","language_id":"en","template_id":0,"context_id":0] as [String : Any]
    self.createRequestForServer(arrayOfDictionaries: arrayOfDictionaries, data: data)

}
    
    func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                    
                }
            }
        }
    }

}





// MARK: - XMPPStreamDelegate

extension ChatViewController: XMPPStreamDelegate{
    
    func xmppMessageArchiveManagement(_ xmppMessageArchiveManagement: XMPPMessageArchiveManagement, didReceiveMAMMessage message: XMPPMessage) {
        //print(message.body)
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        self.sendIQ()
        self.logInViewController?.dismiss(animated: true, completion: nil)
    }
    
    func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
        self.logInViewController?.showErrorMessage(message: "Wrong password or username")
    }
    
    //    - (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq;
    //
    //    func <#name#>(<#parameters#>) -> <#return type#> {
    //        <#function body#>
    //    }
    
    
    func xmppStream(_ sender: XMPPStream, didReceive iq: XMPPIQ) -> Bool {
        if iq.attributeStringValue(forName: "id") == "asas213123"{
            print("IQ RESPONSE ======\(iq.description)")
            self.sendWelcomeToServer(data: "")
        }
        
        return true
    }
    
    
    func xmppStream(_ sender: XMPPStream, didReceive message: XMPPMessage) {
        if let checkStr : String = message.body{
            print(checkStr)
            if(!checkStr.contains("![CDATA[")){
                return
            }
        }
        if( message.body == nil){
            return
        }
        
        let removedCDATA = message.body?.replacingOccurrences(of: "![CDATA[", with: "")
        let removedBracket = removedCDATA?.dropLast().dropLast()
        let removedBackSlash = removedBracket?.replacingOccurrences(of: "", with: "")
        guard let messageData = removedBackSlash?.parseJosonResponse() else {
            return
        }
        self.messageData = messageData
        print("RESPONE LIST ========= \(self.messageData!.responseList)")
      var timer = 0.0
        updateTitleView(title: "ChatBot", subtitle: "Typing...")
        for response in messageData.responseList as [Response] {
            print(response)
             timer = timer + 2
            DispatchQueue.main.asyncAfter(deadline: .now() + timer, execute: {

                self.messageList.append(contentsOf: self.getMessage(response: response, sender: message.from!.user!))
                 self.loadFirstMessages()
            })


        }

    }
    
//    func getThumbnailForVideo(url:String)-> UIImage{
//        DispatchQueue.global().async {
//            let asset = AVAsset(url: URL(string: url)!)
//            let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
//            assetImgGenerate.appliesPreferredTrackTransform = true
//            let time = CMTimeMake(value: 1, timescale: 2)
//            let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
//            if img != nil {
//                let frameImg  = UIImage(cgImage: img!)
//                DispatchQueue.main.async(execute: {
//                    // assign your image to UIImageView
//                    return frameImg
//                })
//            }
//        }
//        return UIImage(named: "Image")!
//    }
    
    func getImage(urlStr:String)-> UIImage{
        let url = URL(string: urlStr)
        do{
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        }catch{
            
        }
//        let task = URLSession.shared.dataTask(with: URL(string: urlStr)!) { (data, response, error) in
//            guard let data = data, error == nil else { return }
//            DispatchQueue.main.async() {
//                return UIImage(data: data)
//            }
//        }
//
//        task.resume()
        return UIImage()
    }
    
    
    func getMessage(response:Response, sender:String) -> [MockMessage] {
        let uniqueID = NSUUID().uuidString
        let sender = Sender(id: sender, displayName: sender)
        let date = Date()
        let messageType = response.responseType
        var mockMsgArray:[MockMessage] = []

        switch messageType {
//        case "quick_reply":

//            var quickReply = response.quickReplyArray[0]
//            return MockMessage(text: text ?? "", sender: sender, messageId: uniqueID, date: date)
            
        case "text":
            var text = response.stringArray?[0]
            text = text?.withoutHtml
            mockMsgArray.append(MockMessage(text: text ?? "", sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray
            
        case "AttributedText":
            var text = response.stringArray?[0]
            text = text?.withoutHtml
            mockMsgArray.append(MockMessage(text: text ?? "", sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray
            
        case "image":
            mockMsgArray.append(MockMessage(image:getImage(urlStr: response.stringArray?[0] ?? ""),sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray
            
        case "video":
            
             mockMsgArray.append(MockMessage(thumbnail:getImage(urlStr: response.stringArray?[0] ?? ""),url: URL(string: (response.stringArray?[0])!)! ,sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray

//            let randomNumberImage = Int(arc4random_uniform(UInt32(messageImages.count)))
//            let image = messageImages[randomNumberImage]
//            return MockMessage(thumbnail: image, sender: sender, messageId: uniqueID, date: date)
        case "Emoji":
            var text = response.stringArray?[0]
            text = text?.withoutHtml
            mockMsgArray.append(MockMessage(text: text ?? "", sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray
//            let randomNumberEmoji = Int(arc4random_uniform(UInt32(emojis.count)))
//            return MockMessage(emoji: emojis[randomNumberEmoji], sender: sender, messageId: uniqueID, date: date)
        case "Location":
            var text = response.stringArray?[0]
            text = text?.withoutHtml
            mockMsgArray.append(MockMessage(text: text ?? "", sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray
//            let randomNumberLocation = Int(arc4random_uniform(UInt32(locations.count)))
//            return MockMessage(location: locations[randomNumberLocation], sender: sender, messageId: uniqueID, date: date)
        case "url":
            let url = response.stringArray?[0]
            mockMsgArray.append(MockMessage(text: url!, sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray
        case "Phone":
            mockMsgArray.append(MockMessage(text: "123-456-7890", sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray
            
        case "quick_reply":
            print("MESSAGE TYPE QUICK REPLY")
            
            for qrBtton in response.quickReplyArray{
                mockMsgArray.append(MockMessage(quickReplyButton: qrBtton , sender: sender, messageId: uniqueID, date: date))
            }
            
            return mockMsgArray
            
        case "carousel":
            print("MESSAGE TYPE QUICK REPLY")
            
            for carousel in response.carousalArray{
                mockMsgArray.append(MockMessage(carousel: carousel, sender: sender, messageId: uniqueID, date: date))
            }
            
            return mockMsgArray
            
        default:
            mockMsgArray.append(MockMessage(text: "123-456-7890", sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray
        
            
        }
}
}

    


struct ContentStruct{
    var message : String?
    var link : NSDictionary?
    var buttons : NSDictionary?
    var tableCoulumns : NSArray?
    var tableRows : NSArray?
    var responseList : NSArray?
    var responseDict : NSDictionary?
    var messageArray : NSArray?
    var image : UIImage?
    
    
    init(data : NSDictionary){
        print(data)
        responseList = data["response_list"] as? NSArray
        responseDict = responseList?[1] as? NSDictionary
        messageArray = responseDict?["response"] as? NSArray
        message = (messageArray?[0] as! String)
        buttons = data["buttons"] as? NSDictionary
        link = data["link"] as? NSDictionary
        tableRows = data["table_rows"] as? NSArray
        tableCoulumns = data["table_columns"] as? NSArray
        
    }
}

//AJEET



//struct <#name#> {
//    <#fields#>
//}

// MARK: - MessageCellDelegate

extension ChatViewController: MessageCellDelegate {
    
    func didTapAvatar(in cell: MessageCollectionViewCell) {
        
        print("Avatar tapped")
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
        let indexPath = messagesCollectionView.indexPath(for: cell)
        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError("Ouch. nil data source for messages")
        }
        let message = messagesDataSource.messageForItem(at: indexPath!, in: messagesCollectionView)
        switch message.kind {
        case .video( _):
            
            let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
            //print(media.url)
            //print(media)
            
        case .photo(let media):
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
            vc.image = media.image
            self.present(vc, animated: true, completion: nil)
//            print(media.url)
//            print(media)
            
        case .location(let location):
            print(location)
            
      

            
        default:
            break
        }
        print("Message tapped")
    }
    
    func didTapCellTopLabel(in cell: MessageCollectionViewCell) {
        print("Top cell label tapped")
    }
    
    func didTapMessageTopLabel(in cell: MessageCollectionViewCell) {
        print("Top message label tapped")
    }
    
    func didTapMessageBottomLabel(in cell: MessageCollectionViewCell) {
        print("Bottom label tapped")
    }
    
    func didTapAccessoryView(in cell: MessageCollectionViewCell) {
        print("Accessory view tapped")
    }
    
}

// MARK: - MessageLabelDelegate

extension ChatViewController: MessageLabelDelegate {
    
    func didSelectAddress(_ addressComponents: [String: String]) {
        print("Address Selected: \(addressComponents)")
    }
    
    func didSelectDate(_ date: Date) {
        print("Date Selected: \(date)")
    }
    
    func didSelectPhoneNumber(_ phoneNumber: String) {
        self.callNumber(phoneNumber: phoneNumber)
        print("Phone Number Selected: \(phoneNumber)")
    }
    
    func didSelectURL(_ url: URL) {
       
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        print("URL Selected: \(url)")
    }
    
    func didSelectTransitInformation(_ transitInformation: [String: String]) {
        print("TransitInformation Selected: \(transitInformation)")
    }
    
}

// MARK: - MessageInputBarDelegate

extension ChatViewController: MessageInputBarDelegate {
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
          self.sendDataToServer(data: text)
        for component in inputBar.inputTextView.components {
            if let str = component as? String {
                let message = MockMessage(text: str, sender: currentSender(), messageId: UUID().uuidString, date: Date())
                insertMessage(message)
            } else if let img = component as? UIImage {
                let message = MockMessage(image: img, sender: currentSender(), messageId: UUID().uuidString, date: Date())
                insertMessage(message)
            }
        }
        inputBar.inputTextView.text = String()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
}
