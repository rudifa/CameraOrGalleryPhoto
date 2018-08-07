//
//  SimpleImagePicker.swift
//  CameraOrGalleryPhoto
//
//  Created by Rudolf Farkas on 07.08.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import UIKit

protocol SimpleImagePickerDelegate {
    func selected(image: UIImage)
}

class SimpleImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // adapted from https://stackoverflow.com/questions/26502931/how-to-get-the-edited-image-from-uiimagepickercontroller-in-swift

    private var imagePicker = UIImagePickerController()

    private weak var owner: UIViewController?

    private(set) var delegate: SimpleImagePickerDelegate?

    var hasCamera: Bool {
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    init(owner: UIViewController, delegate: SimpleImagePickerDelegate) {
        super.init()
        imagePicker.delegate = self
        self.owner = owner
        self.delegate = delegate
    }

    func openCamera()
    {
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            owner?.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            owner?.present(alert, animated: true, completion: nil)
        }
    }

    func openGallery()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        owner?.present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        //You will get cropped image here..
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            delegate?.selected(image: image)
        }
    }
}
