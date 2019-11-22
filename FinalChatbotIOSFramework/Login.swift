//
//  Login.swift
//  ChatbotIOSFramework
//
//  Created by Ajeet Sharma on 21/11/19.
//  Copyright © 2019 Telus. All rights reserved.
//

import Foundation
import UIKit

public class Chatbot {
    
    public static func login() -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: BasicExampleViewController.self))
        let vc = storyboard.instantiateViewController(withIdentifier: "BasicExampleViewController")
        return vc
    }
    
}
