//
//  OptionCollectionViewCell.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 18/10/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

import UIKit

class OptionCollectionViewCell: UICollectionViewCell {

     @IBOutlet weak var optionBtn: UIButton!
    var option:Option?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        optionBtn.layer.borderColor = UIColor.darkGray.cgColor
        optionBtn.layer.borderWidth = 1
        optionBtn.layer.cornerRadius = 5

        

        
        // Initialization code
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        let info:[String: Option] = ["option": self.option!]

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CarauselOptionButtonTapped"), object: nil, userInfo: info)
    }
    func configureCell(option:Option) {
        self.option = option
        optionBtn.setTitle(option.label, for: .normal)
    }

}
