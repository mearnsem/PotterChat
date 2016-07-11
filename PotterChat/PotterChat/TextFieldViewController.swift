//
//  TextFieldViewController.swift
//  PotterChat
//
//  Created by Emily Mearns on 7/6/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class TextFieldViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var postTextField: UITextField!
    
    weak var delegate: TextFieldViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextFieldViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextFieldViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        postTextField.autocapitalizationType = .Sentences
        postTextField.autocorrectionType = .No
    }
    
    
    // MARK: - Buttons
    
    @IBAction func addPostButton(sender: AnyObject) {
        print("Add post button pressed")
        if let text = postTextField.text {
            delegate?.postPost(text)
        }
        postTextField.text = ""
    }
    
    // MARK: - Keyboard Handling
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("Oif")
    }
    
    func resignTextFieldFirstResponder() {
        postTextField.resignFirstResponder()
    }

    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

}

protocol TextFieldViewControllerDelegate: class {
    func postPost(text: String)
}