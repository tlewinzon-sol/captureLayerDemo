//
//  ScreenshotViewController.swift
//  CaptureLayerSpike
//
//  Created by Tobias Lewinzon on 27/05/2020.
//  Copyright © 2020 tobiaslewinzon. All rights reserved.
//

import UIKit

class ScreenshotViewController: UIViewController {

    @IBOutlet weak var screenshotImageView: UIImageView!
    
    var passedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        screenshotImageView.image = passedImage
        
        screenshotImageView.layer.borderColor = CGColor(srgbRed: 100/255, green: 255/255, blue: 0, alpha: 1)
        screenshotImageView.layer.borderWidth = 3
    }
    
    @IBAction func saveToCameraRoll(_ sender: Any) {
        guard let imageToSave = passedImage else { return }
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
    }
    
}
