//
//  ResponseMessage.swift
//  ChatBoatDemoApp
//
//  Created by Ajeet Sharma on 20/05/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

import Foundation




//struct MessageData : Codable {
//    let content:Content?
//}
//
//struct Content : Codable {
//    let response_list:[Response]?
//}
//
//struct Response {
//   let delay:Int?
//   let response:Int?
//   let response_type:String?
//}

struct MessageData {
    var botId:Int?
    var context_life_span:Int?
    var contexts:[Dictionary<String, Any>]?
    var context_id:Int?
    var is_prompt:Int?
    var sentiment:Int?
    var responseList:[Response] = []
    var user_session_id:String?
    var user_details:Dictionary<String, Any>?

    
    
    init(mesageData:NSDictionary) {
        
        print(mesageData)
      
        if mesageData["context_id"] != nil{
            context_id = (mesageData["context_id"] as! Int)
        }
        if mesageData["sentiment"] != nil{
            sentiment = (mesageData["sentiment"] as! Int)
        }
        if mesageData["Bot_Id"] != nil{
            botId = (mesageData["Bot_Id"] as! Int)
        }
        if mesageData["context_life_span"] != nil{
            context_life_span = (mesageData["context_life_span"] as! Int)
        }
        if mesageData["contexts"] != nil{
            contexts = (mesageData["contexts"] as! [Dictionary<String, Any>])
        }
        if mesageData["is_prompt"] != nil{
            is_prompt = (mesageData["is_prompt"] as! Int)
        }
        if mesageData["user_session_id"] != nil{
            user_session_id = mesageData["user_session_id"] as? String
        }
        if mesageData["response_list"] != nil{
            for response in mesageData["response_list"] as! [NSDictionary]{
                //            let res = Response(response)
                //            print(res)                //

                responseList.append(Response(response))
                print(responseList.count)
            }
        }
    }
}


struct Response {

   // let delay:Int
    var quickReplyArray:[QuickReply] = []
    var carousalArray:[Carousal] = []
    var stringArray:[String]?
    let responseType:String

    init(_ dictionary: NSDictionary) {
      //  self.delay = dictionary["delay"] as! Int
        self.responseType = dictionary["response_type"] as! String
        if self.responseType == "text" || self.responseType == "image" || self.responseType == "url" || self.responseType == "video" {
            self.stringArray = dictionary["response"] as? [String]
        }
        else if self.responseType == "quick_reply" {
            for quickReply in dictionary["response"] as! [NSDictionary]{
                self.quickReplyArray.append(QuickReply(quickReply))
            }
        }
        else if self.responseType == "carousel" {
            print(dictionary["response"] as! [NSDictionary])
            self.carousalArray.append(Carousal(dictionary["response"] as! [NSDictionary]))
            print(self.carousalArray)
        }
    }
}

struct QuickReply {
    let text:String
    let data:String
    let templateId:String
    let type:String
    init(_ dictionary: NSDictionary) {
        self.text = dictionary["button_text"] as! String
        self.data = "\(String(describing: dictionary["data"]))"
        self.templateId = "\(String(describing: dictionary["template_id"]))"
        self.type = dictionary["type"] as! String
    }
}

struct Carousal {
    var carouselObjects:[CarousalObject] = []
     init(_ carouselObjectArray: [NSDictionary]) {
        for carouselObj in carouselObjectArray{
        carouselObjects.append(CarousalObject(carouselObj))
        }
    }
}

struct CarousalObject {
    let image:String
    let text:String
    var options:[Option] = []

    init(_ dictionary: NSDictionary) {
        self.text = dictionary["text"] as! String
        self.image = dictionary["image"] as! String
        for option in dictionary["options"] as! [NSDictionary]{
            self.options.append(Option(option))
        }
    }
}



struct Option {
    let data:String
    let label:String
    let uId:String
    let type:String
    init(_ dictionary: NSDictionary) {
        self.label = String(dictionary["label"] as! String)
        self.data = "\(String(describing: dictionary["data"]))"
        self.uId = String(dictionary["uid"] as! String)
        self.type = String(dictionary["type"] as! String)
    }
}


//struct Response : Codable {
//
//    let response:[String]?
//}







