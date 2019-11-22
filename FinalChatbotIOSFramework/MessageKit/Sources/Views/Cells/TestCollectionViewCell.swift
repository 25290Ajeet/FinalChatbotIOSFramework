//
//  TestCollectionViewCell.swift
//  ChatExample
//
//  Created by Ajeet Sharma on 18/09/19.
//  Copyright © 2019 MessageKit. All rights reserved.
//

import UIKit

 class TestCollectionViewCell: UICollectionViewCell {
    let label = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    open func setupSubviews() {
        contentView.addSubview(label)
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 13)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
    
     func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        // Do stuff
        switch message.kind {
        case .text:
            
            print("CONFIGURE SUCCCESSSSSSSFULLLY")
//            guard let systemMessage = data as? String else { return }
//            label.text = systemMessage
        default:
            break
        }
    }
}
