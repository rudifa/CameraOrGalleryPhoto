//
//  ViewController.swift
//  CameraOrGalleryPhoto
//
//  Created by Rudolf Farkas on 06.08.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imagePicker: SimpleImagePicker!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func pickaPicture(_ sender: UIButton) {
        selectImageSource()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = SimpleImagePicker(owner: self, delegate: self)
    }

}

extension ViewController: SimpleImagePickerDelegate {

    func selectImageSource()
    {
        if imagePicker.hasCamera {
            let alert = UIAlertController(title: "Select Image Source", message: nil, preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.imagePicker?.openCamera()
            }))

            alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                self.imagePicker?.openGallery()
            }))

            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

            self.present(alert, animated: true, completion: nil)
        } else {
            self.imagePicker?.openGallery()
        }
    }

    func selected(image: UIImage) {
        imageView.image = image
    }

}

