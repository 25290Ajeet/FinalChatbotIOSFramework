//
//  APIManager.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 30/10/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

import Foundation

class APIManager{
    
    static let sharedInstance = APIManager()
    private init() {
    }
    
    func postAction(_ sender: Any) {
        
    }
    
    func getConfiguration(url:String ,successBlock:@escaping (_ response:ConfigData?) -> Void, failureBlock:@escaping (_ error : String)->Void)
{
    let url = URL(string: "https://qakbbot.xavlab.xyz/api/v2/config/bot/1")
    URLSession.shared.dataTask(with: url!, completionHandler: {
        (data, response, error) in
        if(error != nil){
            print("error")
        }else{
            do{
                let configData = try JSONDecoder().decode(ConfigData.self, from: data!)
                if configData.status == "ok"{
                    successBlock(configData)
                }
                else{
                    failureBlock("Failure")
                }
            }catch let error as NSError{
                failureBlock(error.description)
            }
        }
    }).resume()
    
}
}
