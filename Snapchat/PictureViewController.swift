//
//  PictureViewController.swift
//  Snapchat
//
//  Created by Pujita Tipnis on 3/12/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var uuid = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
        nextButton.isEnabled = false
        
    }

    // function to display the selected image in the Image view on screen and dismiss the open ViewController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        
        imageView.backgroundColor = UIColor.clear
        
        imagePicker.dismiss(animated: true, completion: nil)
        self.nextButton.isEnabled = true
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        // indicates the source from where the photo will be selected
        //imagePicker.sourceType = .camera
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
        // present() allows another ViewController to show up on top of the existing ViewController
        present(imagePicker, animated: true, completion: nil)
        
    }
    @IBAction func nextTapped(_ sender: Any) {
        
        self.nextButton.isEnabled = false
        let imagesFolder = FIRStorage.storage().reference().child("images")
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        imagesFolder.child("\(uuid).jpg").put(imageData, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload")
            if error != nil {
                print("We have an error: \(error)")
            } else {
                //print(metadata?.downloadURL())
                self.performSegue(withIdentifier: "selectUserSegue", sender: metadata?.downloadURL()!.absoluteString)
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SelectUserViewController
        nextVC.imageURL = sender as! String
        nextVC.desc = descriptionTextField.text!
        nextVC.uuid = uuid
        //nextVC.fromEmail = FIRAuth.auth()!.currentUser!.email!
    }
}
