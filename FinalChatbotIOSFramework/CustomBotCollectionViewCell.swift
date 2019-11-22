//
//  CustomBotCollectionViewCell.swift
//  CrazyMessages
//
//  Created by Lekhnish on 05/01/18.
//  Copyright © 2018 Erlang Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol CustomBotDelegate : class{
    func setSecetdBotOption(choiceOption : String)
    func setPaymentOptionSelected()
    
}

class CustomBotCollectionViewCell: UICollectionViewCell {
    weak var delegate: CustomBotDelegate?
    var topSpace = 0
    var yFactor = 0
    var linkUrl : URL?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onSelectedBotOption(button : UIButton){
        delegate?.setSecetdBotOption(choiceOption: (button.titleLabel?.text)!)
    }
    
 
    func createHyperlinkWithText(link : [String : String]){
    
        let index = link.startIndex
        let linkText = link.keys[index]
        let linkURL = link[linkText]
        
       let styledText = NSMutableAttributedString(string: linkText)
//        // Set Attribuets for Color, HyperLink and Font Size
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.link:NSURL(string: linkURL!)!, NSAttributedString.Key.foregroundColor: UIColor.blue]
        styledText.setAttributes(attributes, range: NSMakeRange(0, linkText.count))
        let linkLabel = UILabel(frame: CGRect(x: 0, y: yFactor, width: Int(self.frame.width-40), height: 60))

        linkLabel.attributedText = styledText
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CustomBotCollectionViewCell.tapResponse(recognizer:)))
            
        tapGesture.numberOfTapsRequired = 1
        linkLabel.isUserInteractionEnabled =  true
        linkLabel.addGestureRecognizer(tapGesture)

        linkUrl = URL(string: linkURL!)
         self.contentView.addSubview(linkLabel)
        print(linkLabel.frame)
        yFactor = yFactor + 60
    }

    @objc func tapResponse(recognizer: UITapGestureRecognizer) {
        print("tap")
        
        UIApplication.shared.open(linkUrl!, options: [:])
    }
    func createDyanamicButtons(data : ContentStruct) {
        yFactor = 0
        let optionsButtonArray = data.buttons
        var tagIndex = 0
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
       
        let colCount : Int = (data.tableCoulumns?.count)!
        if(colCount >= 1){
            
            print(self.frame.width-40)
            var labelWidth = 0
            if(colCount < 3){
                labelWidth = Int(self.frame.width-40) / colCount
            }else{
                labelWidth = Int(self.frame.width-40) / 3
            }
            
            let scrollView = UIScrollView(frame: CGRect(x: 30, y: 0, width: self.frame.width-40, height: 400))
            scrollView.contentSize.width = CGFloat(labelWidth * colCount)
            self.contentView.addSubview(scrollView)
            var xAxix = 0
            for data in data.tableCoulumns!{
                let label = UILabel(frame: CGRect(x: xAxix, y: 0 , width: labelWidth, height: 45))
                label.text = data as? String
                label.textAlignment = .center
                label.textColor = UIColor.darkGray
                label.backgroundColor =  UIColor(red: 201/255, green: 222/255, blue: 242/255, alpha: 0.35)
                label.numberOfLines = 2
                label.font = UIFont.boldSystemFont(ofSize: 16)
            
                label.layer.borderWidth = 1
                label.layer.cornerRadius = 5
                label.layer.borderColor =  UIColor(red: 201/255, green: 222/255, blue: 242/255, alpha: 0.6).cgColor
                scrollView.addSubview(label)
                xAxix = xAxix + labelWidth
            }
            
            let rowCount : Int = (data.tableRows?.count)!
            if(rowCount >= 1){
                var labelWidth = 0
                if(colCount < 3){
                    labelWidth = Int(self.frame.width-40) / colCount
                }else{
                    labelWidth = Int(self.frame.width-40) / 3
                }
                var yAxix = 45
                for data in data.tableRows!{
                    xAxix = 0
                    let dataArry = data as! NSArray
                    for rowData in dataArry{
                        let label = UILabel(frame: CGRect(x: xAxix, y: yAxix , width: labelWidth, height: 40))
                        if rowData is NSNumber {
                            label.text = (rowData as AnyObject).stringValue
                        }else{
                            label.font = UIFont.systemFont(ofSize: 12)
                            label.text = rowData as? String
                        }
                        label.textColor = UIColor.darkGray
                        label.textAlignment = .center
                        label.numberOfLines = 2
                        label.layer.borderWidth = 1
                        label.layer.cornerRadius = 5
                        label.layer.borderColor = UIColor(red: 201/255, green: 222/255, blue: 242/255, alpha: 0.6).cgColor
                        label.backgroundColor =  UIColor(red: 201/255, green: 222/255, blue: 242/255, alpha: 0.35)
                        scrollView.addSubview(label)
                        xAxix = xAxix + labelWidth
                        print(label.frame)
                    }
                    yAxix = yAxix + 42
                    yFactor = yAxix
                }
                
                scrollView.frame = CGRect(x: 30, y: 0, width: Int(self.frame.width-40), height: yFactor)
            }
        }
        for (key, _) in optionsButtonArray!{
            tagIndex = tagIndex + 1
            let buttonBack = self.makeButtonWithText(text: key as! String, withTag: tagIndex)
            self.contentView.addSubview(buttonBack)
        }
        if data.link != nil && data.link?.count != 0{
            createHyperlinkWithText(link: data.link as! [String : String] )
        }
    }

    func makeButtonWithText(text:String, withTag:Int) -> UIButton {
        _ = withTag-1
        yFactor = yFactor + 2
        let myButton = UIButton(type: .custom)
        myButton.frame = CGRect(x: 33, y: yFactor, width: Int(self.frame.width-40), height: 30)
         topSpace = 0
        print(myButton.frame)
        myButton.setTitle(text, for: .normal)
        myButton.layer.borderColor = UIColor(red: 201/255, green: 222/255, blue: 242/255, alpha: 0.6).cgColor
        myButton.backgroundColor = UIColor(red: 201/255, green: 222/255, blue: 242/255, alpha: 0.35)
        if(text == "Yes" || text == "No"){
            myButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            myButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
             myButton.setTitleColor(UIColor.darkGray, for: .normal)
        }else{
            myButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
             myButton.setTitleColor(UIColor.darkGray, for: .normal)
        }
           
        myButton.layer.borderWidth = 1
        myButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0);
        myButton.layer.cornerRadius = 5
        if(myButton.titleLabel?.text == "Proceed Payment"){
            myButton.addTarget(self, action: #selector(CustomBotCollectionViewCell.onPaymentSelection(button:)), for: UIControl.Event.touchUpInside)
        }
        myButton.addTarget(self, action: #selector(CustomBotCollectionViewCell.onSelectedBotOption(button:)), for: UIControl.Event.touchUpInside)
         yFactor = yFactor + 32
        return myButton
    }
    
    @objc func onPaymentSelection(button : UIButton){
        delegate?.setPaymentOptionSelected()
    }
    
}
