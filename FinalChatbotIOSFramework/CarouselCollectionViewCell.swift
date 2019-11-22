//
//  CarouselCollectionViewCell.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 02/10/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    var caraouselObjArray:[CarousalObject]?
    var messageList:[MockMessage]?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        containerView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        self.collectionView.layer.cornerRadius = 10
        self.collectionView.clipsToBounds = true
    //  self.collectionView.backgroundColor = .clear
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

     // self.collectionView.register(UINib.init(nibName: “CollectionViewCell”, bundle: nil), forCellWithReuseIdentifier: “collectionViewID”)
        self.collectionView.register(UINib(nibName:"CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
       
        // Initialization code
    }
    
    func configure(with messageList: [MockMessage], at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        
        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError("Ouch. nil data source for messages")
        }
        self.messageList = messageList
        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        switch message.kind {
        case .carousel(let carousel):
            self.caraouselObjArray = carousel.carousel?.carouselObjects
            self.pageControll.numberOfPages = self.caraouselObjArray!.count
            self.collectionView.reloadData()
           // print(carousel.carousel)
        default:
            break
        }
    }
}


extension CarouselCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.caraouselObjArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        //in this example I added a label named "title" into the MyCollectionCell class
        print(self.caraouselObjArray![indexPath.item].text)
      //  cell.titleLbl.text = self.caraouselObjArray![indexPath.item].text
        cell.configureCell(carouselObj: self.caraouselObjArray![indexPath.item])
       // cell.carouselObj = self.caraouselObjArray![indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth = scrollView.frame.size.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        self.pageControll.currentPage = currentPage
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 250, height: 300)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameSize = collectionView.frame.size
        print(300 + (50*(self.caraouselObjArray![indexPath.item].options.count)))
        return CGSize(width: frameSize.width - 10, height: CGFloat(370))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}
