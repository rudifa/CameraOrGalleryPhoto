//
//  CodableImage.swift
//  CameraOrGalleryPhoto
//
//  Created by Rudolf Farkas on 27.07.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import UIKit

struct CodableImage_UNUSED: Codable {
    let imageData: Data?

    init(withImage image: UIImage) {
        imageData = image.pngData()
    }

    init(withData data: Data) {
        if UIImage(data: data) != nil {
            imageData = data
        } else {
            imageData = nil
        }
    }

    var uiImage: UIImage? {
        if imageData != nil {
            return UIImage(data: imageData!)
        }
        return nil
    }

    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)

        return image
    }
}
