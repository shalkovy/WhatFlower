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
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pickedImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage]  as? UIImage {
        
            guard let ciImage = CIImage(image: userPickedImage) else {
                
                fatalError("cannot convert to CIImage.")
                
            }
            
            detect(image: ciImage)
        
        pickedImage.image = userPickedImage
        
        }
            
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            
            fatalError("Cannot import model")
            
        }
        
        let request = VNCoreMLRequest(model: model) { (reqest, error) in
            let classification = reqest.results?.first as? VNClassificationObservation
            
            self.navigationItem.title = classification?.identifier.capitalized
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
        
    }
    
    @IBAction func camButtonPressed(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
}

