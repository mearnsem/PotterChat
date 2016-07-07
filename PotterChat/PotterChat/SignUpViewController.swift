//
//  SignUpViewController.swift
//  PotterChat
//
//  Created by Emily Mearns on 6/24/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var houseTextField: UITextField!
    @IBOutlet weak var housePicker: UIPickerView!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    var houses = ["Gryffindor", "Hufflepuff", "Ravenclaw", "Slytherin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(tapGesture)
        
        let view = UIView(frame: self.view.bounds)
        let blurEffect = UIBlurEffect(style: .ExtraLight)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.view.bounds
        let imageView = UIImageView(frame: view.frame)
        imageView.image = UIImage(named: "bigben")
        imageView.contentMode = .ScaleAspectFill
        view.addSubview(imageView)
        view.addSubview(visualEffectView)
        
        self.view.addSubview(view)
        self.view.sendSubviewToBack(view)
        
        let housePicker = UIPickerView()
        housePicker.delegate = self
        housePicker.dataSource = self
        self.houseTextField.inputView = housePicker
    }
    
    @IBAction func pottermoreLinkBtn(sender: AnyObject) {
        if let url = NSURL(string: "https://www.pottermore.com/") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func viewTapped(sender: UITapGestureRecognizer) {
        houseTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
    }
    
    @IBAction func submitBtn(sender: AnyObject) {
        if let username = usernameTextField.text, houseString = houseTextField.text {
            
            var userHouse: House?

            
            for house in HouseController.sharedHouseController.housesArray {
                if house.name == houseString {
                    userHouse = house
                }
            }

            
            if let house = userHouse {
                _ = UserController.sharedUserController.createUser(username, house: house)
            }
        }
        
        if UserController.sharedUserController.currentUser != nil {
            self.performSegueWithIdentifier("pageVC", sender: nil)
        }
    }
    
    // MARK: - Picker Delegate
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return houses.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return houses[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        houseTextField.text = houses[row]
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        houseTextField.resignFirstResponder()
        return false
    }
    
}
