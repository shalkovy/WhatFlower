//
//  ViewController.swift
//  WhatFlower
//
//  Created by Dima Shelkov on 3/25/19.
//  Copyright © 2019 Dima Shelkov. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pickedImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let userPickedImage = info[UIImagePickerController.InfoKey.editedImage]
        
        pickedImage.image = userPickedImage as? UIImage
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func camButtonPressed(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
}

