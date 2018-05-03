//
//  ImagePickerViewController.swift
//  Favorite Photos
//
//  Created by CSSE Department on 5/3/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit

class ImagePickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func takePhoto(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        present(imagePicker, animated: true)
    }
    
    func uploadImage(_ image: UIImage) {
        print("super class does nothing, no need to even call super")
    }
    
}

extension ImagePickerViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //self.imageView.image = image
            uploadImage(image)
        }
        picker.dismiss(animated: true)
    }
}
