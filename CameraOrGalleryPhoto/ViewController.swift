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

    @IBOutlet var imageView: UIImageView!

    @IBAction func pickaPicture(_: UIButton) {
        selectImageSource()
    }

    @IBAction func saveToDefaults(_: Any) {
        if let image = imageView.image {
            var resourceData = ResourceData()
            resourceData.calendarTitle = "TEST"
            resourceData.image = image
            LocalUserDefaults.update(from: resourceData, for: resourceData.calendarTitle)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = SimpleImagePicker(owner: self, delegate: self)
    }

    func imageFromDefaults() {
        if let image = LocalUserDefaults.resourceData(for: "TEST")?.image {
            imageView.image = image
            printClassAndFunc(info: "image.size= \(image.size)")
        } else {
            printClassAndFunc(info: "image= nil")
        }
    }

    func selectImageSource() {
        let alert = UIAlertController(title: "Select Image Source", message: nil, preferredStyle: .actionSheet)

        if imagePicker.hasCamera {
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.imagePicker?.openCamera()
            }))
        }

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.imagePicker?.openGallery()

        }))

        alert.addAction(UIAlertAction(title: "Defaults", style: .default, handler: { _ in self.imageFromDefaults()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: SimpleImagePickerDelegate {
    func selected(image: UIImage) {
        imageView.image = image
    }
}
