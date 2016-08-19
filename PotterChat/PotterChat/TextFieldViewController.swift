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
    var keyboardShown = false
    var keyboardHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboard()
    }
    
    // MARK: - Buttons
    
    @IBAction func addPostButton(sender: AnyObject) {
        print("Add post button pressed")
        if let text = postTextField.text where postTextField.text?.characters.count > 0 {
            delegate?.postPost(text)
        }
        postTextField.text = ""
    }
    
    // MARK: - Keyboard Handling
    
    func setupKeyboard() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextFieldViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextFieldViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        postTextField.autocorrectionType = .Yes
        postTextField.autocapitalizationType = .Sentences
    }
    
    func raiseView(height: CGFloat) {
        if !keyboardShown {
            view.frame.origin.y -= height
            keyboardShown = true
        } else {
            guard let keyboardHeight = keyboardHeight else {return}
            if keyboardHeight > height {
                let difHeight = keyboardHeight - height
                view.frame.origin.y += difHeight
            } else {
                let difHeight = height - keyboardHeight
                view.frame.origin.y -= difHeight
            }
        }
        keyboardHeight = height
    }
    
    func resignTextFieldFirstResponder() {
        postTextField.resignFirstResponder()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
            raiseView(keyboardSize.height)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
                keyboardShown = false
            }
        }
    }
    
}

protocol TextFieldViewControllerDelegate: class {
    func postPost(text: String)
}