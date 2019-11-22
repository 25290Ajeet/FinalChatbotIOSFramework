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

import Foundation
import UIKit
//import MessageKit

 class CustomMessagesFlowLayout: MessagesCollectionViewFlowLayout {
    
    open lazy var customMessageSizeCalculator = CustomMessageSizeCalculator(layout: self)
    
    open override func cellSizeCalculatorForItem(at indexPath: IndexPath) -> CellSizeCalculator {
//        if isSectionReservedForTypingBubble(indexPath.section) {
//            return typingMessageSizeCalculator
//        }
        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        if case .quickReplyButton = message.kind {
            return customMessageSizeCalculator
        }
        else if case .carousel = message.kind {
            return customMessageSizeCalculator
        }
        return super.cellSizeCalculatorForItem(at: indexPath)
    }
    
    open override func messageSizeCalculators() -> [MessageSizeCalculator] {
        var superCalculators = super.messageSizeCalculators()
        // Append any of your custom `MessageSizeCalculator` if you wish for the convenience
        // functions to work such as `setMessageIncoming...` or `setMessageOutgoing...`
        superCalculators.append(customMessageSizeCalculator)
        return superCalculators
    }
}

 class CustomMessageSizeCalculator: MessageSizeCalculator {
    
    public override init(layout: MessagesCollectionViewFlowLayout? = nil) {
        super.init()
        self.layout = layout
    }
    
    open override func sizeForItem(at indexPath: IndexPath) -> CGSize {
        
        guard let layout = layout else { return .zero }
        let collectionViewWidth = layout.collectionView?.bounds.width ?? 0
        let contentInset = layout.collectionView?.contentInset ?? .zero
        let inset = layout.sectionInset.left + layout.sectionInset.right + contentInset.left + contentInset.right
        
        let message =  messagesLayout.messagesDataSource.messageForItem(at: indexPath, in: messagesLayout.messagesCollectionView)
        
        switch message.kind {
        case .quickReplyButton:
            return CGSize(width: collectionViewWidth - inset, height: 40 + inset)
            
        case .carousel:
         //  for carousel.carousel?.carouselObjects
            return CGSize(width:collectionViewWidth - inset , height: 400)
            
        default:
            break
        }
//        if case .quickReplyButton = message.kind {
//               return CGSize(width: collectionViewWidth - inset, height: 40 + inset)
//        }
//        else if case .carousel = message.kind {
//               return CGSize(width:collectionViewWidth - inset , height: 345 + inset)
//        }
//
       
        return CGSize(width: collectionViewWidth - inset, height: 40)
    }
  
}
