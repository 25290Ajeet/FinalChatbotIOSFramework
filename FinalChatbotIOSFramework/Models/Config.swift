//
//  Config.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 30/10/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

import Foundation

struct ConfigData : Codable {
    let result:Config?
    let status:String?

    
}

struct Config : Codable {
    let uid:String?
    let wlcm_msg:String?
    let life_span:String?
    let avatar:String?
    let theme_colour:String?
    let vhost:String?
    let jid:String?
    let integration:[Integration]?
}

struct Integration : Codable {
    let settings:Setting?
}

struct Setting : Codable {
    let button_colour:String = "#4B286D"
    let carousel_color:String = "#e8e8eb"
    let carousel_textcolour:String = "#000000"
    let response_bubble:String = "#e8e8eb"
    let response_text_icon:String = "#000000"
    let sender_bubble:String = "#4B286D"
    let sender_text_icon:String = "#ffffff"
    let widget_textcolour:String = "#54595f"
    let feedback_color:String = "#4B286D"
    let theme_colour:String = "#ffffff"
    let button_hover_colour:String = "#ffffff"
}
