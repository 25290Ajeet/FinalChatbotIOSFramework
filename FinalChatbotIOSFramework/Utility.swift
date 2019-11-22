//
//  Utility.swift
//  CrazyMessages
//
//  Created by Lekhnish on 03/01/18.
//  Copyright © 2018 Erlang Solutions. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func parseJosonResponse() -> MessageData {
        var messageData:MessageData = MessageData(mesageData: [:])
       // var responseList:[Response] = []
        if let data = self.data(using: .utf8) {
                        do {
                            if let jsonDict = try? (JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [String : Any]){
                                if let content = jsonDict["content"] as? [String : Any] as NSDictionary? as? [AnyHashable: Any]{
                                    print(jsonDict)
                                    messageData = MessageData(mesageData: content as NSDictionary)
                                    print(messageData as Any)
                                    return messageData
                                }
                            }
                        } 
//            do{
//                let messageData = try JSONDecoder().decode(MessageData.self, from: data)
//                if let messageDataContent = messageData.content{
//                      print(messageData.content?.response_list)
//
//                    return messageDataContent.response_list!
//                }
//            }catch{
//                print(error)
//            }
        }
        return messageData
    }
    
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        return attributedString.string
    }
    


}


//extension URL{
//    func getImageData(from url: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        
//        URLSession.shared.dataTask(with: URL(string: url), completionHandler: completion).resume()
//    }
//}

extension UIColor {
    
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

