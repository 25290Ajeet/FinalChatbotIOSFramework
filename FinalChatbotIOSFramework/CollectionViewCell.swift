//
//  CollectionViewCell.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 17/10/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var optionsArray:[Option]?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.optionsCollectionView.delegate = self
        self.optionsCollectionView.dataSource = self
        
        // self.collectionView.register(UINib.init(nibName: “CollectionViewCell”, bundle: nil), forCellWithReuseIdentifier: “collectionViewID”)
        self.optionsCollectionView.register(UINib(nibName:"OptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OptionCollectionViewCell")
        // Initialization code
    }
    
    func configureCell(carouselObj:CarousalObject) {
        print(carouselObj.text)
        print("\(carouselObj.text)===\(carouselObj.options.count)")
        self.optionsArray = carouselObj.options
       // print("\( self.optionsArray?.count)====\(carouselObj.options.count)")

        
        self.titleLbl.text = carouselObj.text
        downloadImage(from: URL(string: carouselObj.image)!)
    }
    
//    var carouselObj:CarousalObject!{
//        didSet{
//            
//        }
//    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imgView.image = UIImage(data: data)
            }
        }
    }

}

extension CollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.optionsArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionCollectionViewCell", for: indexPath) as! OptionCollectionViewCell
        
        //in this example I added a label named "title" into the MyCollectionCell class
        print(self.optionsArray![indexPath.item].label)
        //  cell.titleLbl.text = self.caraouselObjArray![indexPath.item].text
        cell.configureCell(option: self.optionsArray![indexPath.item])
        // cell.carouselObj = self.caraouselObjArray![indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: 250, height: 300)
    //    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        print(frameSize.height)
        return CGSize(width: frameSize.width - 10, height: frameSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}
