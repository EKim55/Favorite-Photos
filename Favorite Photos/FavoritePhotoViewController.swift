//
//  FavoritePhotoViewController.swift
//  Favorite Photos
//
//  Created by CSSE Department on 4/30/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class FavoritePhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var storageRef: StorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storageRef = Storage.storage().reference(withPath: "favorite")
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
    
    func uploadImage(_ data: Data?) {
        guard let data = data else { return }
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        
        progressView.isHidden = false
        progressView.progress = 0
        
        let uploadTask = storageRef.putData(data, metadata: uploadMetaData) { (metadata, error) in
            if let error = error {
                print("Error with upload \(error.localizedDescription)")
            }
        }
        uploadTask.observe(StorageTaskStatus.progress) { (snapshot) in
            guard let progress = snapshot.progress else { return }
            self.progressView.progress = Float(progress.fractionCompleted)
        }
        uploadTask.observe(StorageTaskStatus.success) { (snapshot) in
            print("Your upload is finished")
            self.progressView.isHidden = true
        }
    }
}

// MARK: UIImagePicker controller delegate methods

extension FavoritePhotoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //self.imageView.image = image
            uploadImage(UIImageJPEGRepresentation(image, 0.5))
        }
        picker.dismiss(animated: true)
    }
}
