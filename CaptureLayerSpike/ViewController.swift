//
//  ViewController.swift
//  CaptureLayerSpike
//
//  Created by Tobias Lewinzon on 27/05/2020.
//  Copyright © 2020 tobiaslewinzon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer.borderWidth = 3
        containerView.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
    }
    
    var screenShot = UIImage()
    
    @IBOutlet weak var containerView: UIView!
    

    @IBAction func takeScreenshot(_ sender: Any) {
        fullScreenShotMethod()
        performSegue(withIdentifier: "navigate", sender: self)
    }
    
    @IBAction func takeSectionScreenshot(_ sender: Any) {
        sectionScreenshotMethod(view: containerView)
        performSegue(withIdentifier: "navigate", sender: self)
    }
    
    @IBAction func anotherSimilarApproach(_ sender: Any) {
        anotherSimilarApproach()
        performSegue(withIdentifier: "navigate", sender: self)
    }
    
    // From https://stackoverflow.com/questions/25448879/how-do-i-take-a-full-screen-screenshot-in-swift
    /// Full screenshot
    func fullScreenShotMethod() {
        // Create image context with desired view's frame (size and position).
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
        // Draw view and subviews into the context created above.
        guard let createdImageContext = UIGraphicsGetCurrentContext() else { return }
        view.layer.render(in: createdImageContext)
        // Store image from context.
        guard let renderedImage =  UIGraphicsGetImageFromCurrentImageContext() else { return }
        screenShot = renderedImage
        // On this point onwards the screenshot is stored in this variable as UIImage and it is ready to use.
        // End image context
        UIGraphicsEndImageContext()
    }
    
    /// Captures only passed view.
    func sectionScreenshotMethod(view: UIView) {
        // Create image context with desired view's frame (size and position).
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
        // Draw view and subviews into the context created above.
        guard let createdImageContext = UIGraphicsGetCurrentContext() else { return }
        view.layer.render(in: createdImageContext)
        // Store image from context.
        guard let renderedImage =  UIGraphicsGetImageFromCurrentImageContext() else { return }
        screenShot = renderedImage
        // On this point onwards the screenshot is stored in this variable as UIImage and it is ready to use.
        // End image context
        UIGraphicsEndImageContext()
    }
    
    func anotherSimilarApproach() {
        var screenshotImage: UIImage {
            guard let viewToCapture = containerView else { return UIImage() }
            return UIImage.init(view: viewToCapture)
        }
        
        screenShot = screenshotImage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let screenshotVC = segue.destination as? ScreenshotViewController {
                screenshotVC.passedImage = screenShot
        }
    }
    
}

extension UIImage {
    
    convenience init(view: UIView) {
        // Create image context with desired view's frame (size and position).
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        // Call drawHeriarchy on view. This method renders the view content into the current image context.
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = image?.cgImage {
            self.init(cgImage: image)
        } else {
            self.init()
        }
    }
}
