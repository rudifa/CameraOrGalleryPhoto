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
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
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
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        owner?.present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        picker.dismiss(animated: true, completion: nil)
        //You will get cropped image here..
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage
        {
            delegate?.selected(image: image)
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
