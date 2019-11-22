//
//  QuickReplyButtonCollectionViewCell.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 01/10/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

import UIKit


protocol QuickReplyButtonCollectionViewCellDelegate {
    func didTappedQuickReplyButton(type:String, text:String)
}

 class QuickReplyButtonCollectionViewCell: UICollectionViewCell {
    
    let button = UIButton()
    var buttonTag = 0
    var delegate:QuickReplyButtonCollectionViewCellDelegate?
    var messageList:[MockMessage]?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    open func setupSubviews() {
        
        button.frame = CGRect(x: 10, y: 10, width: 200, height: 40)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 77/255.0, green: 41/255.0, blue: 108/255.0, alpha: 1).cgColor
        button.backgroundColor = .white
        button.setTitleColor(UIColor(red: 77/255.0, green: 41/255.0, blue: 108/255.0, alpha: 1), for: .normal)
        button.addTarget(self, action:#selector(self.didTappedButton), for: .touchUpInside)
        contentView.addSubview(button)
        contentView.backgroundColor = UIColor.clear
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    @objc func didTappedButton() {
        switch messageList![button.tag].kind {
        case .quickReplyButton(let butn):
            delegate?.didTappedQuickReplyButton(type: butn.quickReplyButton!.type, text: butn.quickReplyButton!.text)
            
        default:
            break
        }
    }
    
    

    
     func configure(with messageList: [MockMessage], at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        
        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError("Ouch. nil data source for messages")
        }
        self.messageList = messageList
        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        switch message.kind {
        case .quickReplyButton(let butn):
            button.setTitle((butn.quickReplyButton?.text)?.capitalized, for: .normal)
            button.tag = indexPath.section
            
        default:
            break
        }
    }
    
}
