//
//  SignUpViewController.swift
//  PotterChat
//
//  Created by Emily Mearns on 6/24/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var houseTextField: UITextField!
    @IBOutlet weak var housePicker: UIPickerView!
    
    var houses = ["Gryffindor", "Hufflepuff", "Ravenclaw", "Slytherin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.houseTextField.inputView = housePicker
        housePicker.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pottermoreLinkBtn(sender: AnyObject) {
        if let url = NSURL(string: "https://www.pottermore.com/") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func submitBtn(sender: AnyObject) {
        
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
        housePicker.hidden = true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        housePicker.hidden = false
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
