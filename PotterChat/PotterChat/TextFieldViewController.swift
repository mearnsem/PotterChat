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
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    weak var delegate: TextFieldViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(tapGesture)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextFieldViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextFieldViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("Oif")
    }
    
    @IBAction func addPostButton(sender: AnyObject) {
        print("Add post button pressed")
        if let text = postTextField.text {
            delegate?.postPost(text)
        }
    }
    
    @IBAction func viewTapped(sender: UITapGestureRecognizer) {
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