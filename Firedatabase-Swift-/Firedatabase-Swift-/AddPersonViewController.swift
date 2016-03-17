//
//  AddPersonViewController.swift
//  Firedatabase-Swift-
//
//  Created by Ethan Hess on 3/17/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
//    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var photoButton: UIButton!
    
    var dateOfBirthTimeInterval: NSTimeInterval = 0
    
    var imagePicker = UIImagePickerController()
    var chosenImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        applyStyle()
    }
    
    @IBAction func save(sender: AnyObject) {
        
        let name = nameTextField.text
        var data = NSData()
        
        if let profileImage = chosenImage {
            data = UIImageJPEGRepresentation(profileImage, 0.1)!
        }
        
        let base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        //TODO: make user subclass with init method
        let user : NSDictionary = [nameKey: name!, DOBKey: dateOfBirthTimeInterval, base64Key: base64String]
        
        //add child
        let profile = firebase.ref.childByAppendingPath(name!)
        
        //write data
        profile.setValue(user)
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func datePicked(sender: AnyObject) {
    
        dateOfBirthTimeInterval = datePicker.date.timeIntervalSinceNow
        dateOfBirthTextField.text = formatDate(datePicker.date)
    }
    
    func applyStyle() {
        
        view.backgroundColor = backgroundColor
        
        nameTextField.font = standardTextFont
        nameTextField.textColor = UIColor.whiteColor()
        
        dateOfBirthTextField.font = standardTextFont
        dateOfBirthTextField.textColor = UIColor.whiteColor()
        
        datePicker.backgroundColor = backgroundColor
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

}

extension AddPersonViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        self.chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.photoButton.setBackgroundImage(self.chosenImage, forState: UIControlState.Normal)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addPicture(sender: AnyObject) {
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera
            
            presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.delegate = self
            presentViewController(imagePicker, animated: true, completion:nil)
        }
    }
}
