//
//  LoginViewController.swift
//  CrazyMessages
//
//  Created by Andres on 7/21/16.
//  Copyright © 2016 Andres. All rights reserved.
//

import UIKit
import XMPPFramework
import MBProgressHUD

class LogInViewController: UIViewController {

	@IBOutlet weak var userJIDLabel: UITextField!
	@IBOutlet weak var userPasswordLabel: UITextField!
	@IBOutlet weak var serverLabel: UITextField!
	@IBOutlet weak var errorLabel: UILabel!

	weak var delegate:LogInViewControllerDelegate?
	var hud: MBProgressHUD!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.sharedInstance.getConfiguration(url: "", successBlock: { (data) in
          //  print(data)
        }) { (error) in
            print(error)
        }
	}

	@IBAction func logInAction(sender: AnyObject) {
        let serverEndPoint = "bot.rblr.in"
		if self.userJIDLabel.text?.count == 0
		  || self.userPasswordLabel.text?.count == 0
		  || serverEndPoint.count == 0 {
			self.errorLabel.text = "Something is missing or wrong!"
			return
		}
        guard let _ = XMPPJID(string: self.userJIDLabel.text!) else {
			self.errorLabel.text = "Username is not a jid!"
			return
		}

        self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
		self.hud.label.text = "Signing in..."
        self.delegate?.didTouchLogIn(sender: self, userJID: self.userJIDLabel.text!, userPassword: self.userPasswordLabel.text!, server: serverEndPoint)
	}
	
	func showErrorMessage(message: String) {
		hud.mode = .text
		hud.label.text = message
		hud.hide(animated: true, afterDelay: 1.5)
	}
}

protocol LogInViewControllerDelegate: class {
	func didTouchLogIn(sender: LogInViewController, userJID: String, userPassword: String, server: String)
}
