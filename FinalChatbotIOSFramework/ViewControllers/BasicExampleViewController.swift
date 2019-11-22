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
import MapKit
//import MessageKit
//import MessageInputBar

final class BasicExampleViewController: ChatViewController {
  
    override func configureMessageCollectionView() {
        super.configureMessageCollectionView()
        
        
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    override func viewDidLoad() {
        messagesCollectionView = MessagesCollectionView(frame: .zero, collectionViewLayout: CustomMessagesFlowLayout())
        messagesCollectionView.register(QuickReplyButtonCollectionViewCell.self)
        messagesCollectionView.register(UINib(nibName: "CarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        super.viewDidLoad()
        
        updateTitleView(title: "MessageKit", subtitle: "2 Online")
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.carauselOptionButtonClicked(notification:)),
            name: Notification.Name("CarauselOptionButtonTapped"),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.carauselImageClicked(notification:)),
            name: Notification.Name("CarauselImageTapped"),
            object: nil)
        
        // Customize the typing bubble! These are the default values
        //        typingBubbleBackgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        //        typingBubbleDotColor = .lightGray
    }
    
    @objc func carauselOptionButtonClicked(notification:NSNotification) {
            let option = notification.userInfo?["option"] as! Option
        print(option.label)
        print(option.data)

        if option.type == "url"{
            if #available(iOS 10.0, *) {
                if let url = URL(string: "Google.com") {
                    UIApplication.shared.open(url)
                }
               // UIApplication.shared.open(URL(string: "Google.com")!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: option.data)!)
            }
            return
        }
        self.sendDataToServer(data: option.data)
        let message = MockMessage(text: option.data, sender: currentSender(), messageId: UUID().uuidString, date: Date())
            insertMessage(message)
            messagesCollectionView.scrollToBottom(animated: true)
        
    }
    
    @objc func carauselImageClicked(notification:NSNotification) {
        
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
        //            .onTypingStatus { [weak self] in
        //                self?.setTypingIndicatorHidden(false)
        //            }.onNewMessage { [weak self] message in
        //                self?.setTypingIndicatorHidden(true, performUpdates: {
        //                    //                    self?.insertMessage(message)
        //                })
        //                self?.insertMessage(message)
        //        }
    }
    
    override func loadFirstMessages() {
        
        
        defer{
            updateTitleView(title: "ChatBot", subtitle: "")
        }
        updateTitleView(title: "ChatBot", subtitle: "Typing...")
        
        self.messagesCollectionView.reloadData()
        self.messagesCollectionView.scrollToBottom()
        
        
        //        DispatchQueue.global(qos: .userInitiated).async {
        //            let count = UserDefaults.standard.mockMessagesCount()
        //            SampleData.shared.getAdvancedMessages(count: count) { messages in
        //                DispatchQueue.main.async {
        //                    self.messageList = messages
        //                    self.messagesCollectionView.reloadData()
        //                    self.messagesCollectionView.scrollToBottom()
        //                }
        //            }
        //        }
    }
    
    override func loadMoreMessages() {
        
        self.messagesCollectionView.reloadDataAndKeepOffset()
        self.refreshControl.endRefreshing()
        //        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1) {
        //            SampleData.shared.getAdvancedMessages(count: 20) { messages in
        //                DispatchQueue.main.async {
        //                    self.messageList.insert(contentsOf: messages, at: 0)
        //                    self.messagesCollectionView.reloadDataAndKeepOffset()
        //                    self.refreshControl.endRefreshing()
        //                }
        //            }
        //        }
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError("Ouch. nil data source for messages")
        }
        
        //        guard !isSectionReservedForTypingBubble(indexPath.section) else {
        //            return super.collectionView(collectionView, cellForItemAt: indexPath)
        //        }
        
        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        print(message.kind)
        print(message)

        if case .quickReplyButton = message.kind {
            let cell = messagesCollectionView.dequeueReusableCell(QuickReplyButtonCollectionViewCell.self, for: indexPath)
            print("IndexPath...\(indexPath.section)")
            print(self.messageList[indexPath.section].kind)
            cell.delegate = self
            cell.configure(with: self.messageList, at: indexPath, and: messagesCollectionView)
            return cell
        }
        else if case .carousel = message.kind {
            let cell = messagesCollectionView.dequeueReusableCell(CarouselCollectionViewCell.self, for: indexPath)
//            print("IndexPath...\(indexPath.section)")
//            print(self.messageList[indexPath.section].kind)
//            cell.delegate = self
           cell.configure(with: self.messageList, at: indexPath, and: messagesCollectionView)
            return cell
        }
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}


extension BasicExampleViewController: QuickReplyButtonCollectionViewCellDelegate {
    func didTappedQuickReplyButton(type:String, text:String){
        
        self.sendDataToServer(data: text)
        let message = MockMessage(text: text, sender: currentSender(), messageId: UUID().uuidString, date: Date())
        insertMessage(message)
        messagesCollectionView.scrollToBottom(animated: true)

        print(type)
        print(text)
    }
}

// MARK: - MessagesDisplayDelegate

extension BasicExampleViewController: MessagesDisplayDelegate {
    
    // MARK: - Text Messages
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .darkText
    }
    
    
    func detectorAttributes(for detector: DetectorType, and message: MessageType, at indexPath: IndexPath) -> [NSAttributedString.Key: Any] {
        return MessageLabel.defaultAttributes
    }
    
    func enabledDetectors(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> [DetectorType] {
        return [.url, .address, .phoneNumber, .date, .transitInformation]
    }
    
    
    
    
    
    // MARK: - All Messages
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .purpleColor : UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(tail, .curved)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let avatar = SampleData.shared.getAvatarFor(sender: message.sender)
        avatarView.set(avatar: avatar)
    }
    
    
    
    
    
    
    
    
    // MARK: - Location Messages
    
    func annotationViewForLocation(message: MessageType, at indexPath: IndexPath, in messageCollectionView: MessagesCollectionView) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: nil, reuseIdentifier: nil)
        let pinImage = #imageLiteral(resourceName: "user3")
        annotationView.image = pinImage
        annotationView.centerOffset = CGPoint(x: 0, y: -pinImage.size.height / 2)
        return annotationView
    }
    
    func animationBlockForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> ((UIImageView) -> Void)? {
        return { view in
            view.layer.transform = CATransform3DMakeScale(2, 2, 2)
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [], animations: {
                view.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }
    
    func snapshotOptionsForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LocationMessageSnapshotOptions {
        
        return LocationMessageSnapshotOptions(showsBuildings: true, showsPointsOfInterest: true, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    }
    
}




// MARK: - MessagesLayoutDelegate

extension BasicExampleViewController: MessagesLayoutDelegate {
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 18
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 16
    }
    
}

