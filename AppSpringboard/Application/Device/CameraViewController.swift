//
//  CameraViewController.swift
//  AppSpringboard
//
//  Created by Joseph Bergen on 7/16/18.
//  Copyright © 2018 Joseph Bergen. All rights reserved.
//

import UIKit

/**

 Camera Demo

 This demo shows a very simple implementation of the camera feature. Tapping the camera icon in the
 upper right hand corner launches the camera as a modal. Once a photo is taken and the camera is
 dismissed, then the image is returned and displayed in the view controller

 DOCS
 ====
 UIImagePickerController: https://developer.apple.com/documentation/uikit/uiimagepickercontroller
 UIImagePickerControllerDelegate: https://developer.apple.com/documentation/uikit/uiimagepickercontrollerdelegate
 UINavigationControllerDelegate: https://developer.apple.com/documentation/uikit/uinavigationcontrollerdelegate

 **/

// We need to conform to `UIImagePickerControllerDelegate` & `UINavigationControllerDelegate` to respond to the camera events
class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // this is the view that the resulting image will be shown in
    private let photoView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Camera"
        view.backgroundColor = .white

        // set the right navigation bar button to be a camera button that will call `showCamera` when tapped
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(showCamera))

        // set up and add the image view for the photo
        photoView.contentMode = .scaleAspectFit
        photoView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: view.bounds.width - 40)
        photoView.center = view.center
        view.addSubview(photoView)
    }

    /**
     When the camera button is tapped, this function is called which takes care of prompting the user for permissions
     and presenting the camera controller
    **/
    @objc func showCamera() {
        // check for permissions and hardware availability
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        let cameraController = UIImagePickerController()
        // set the delegate to self to handle the results
        cameraController.delegate = self
        cameraController.sourceType = .camera
        // present the picker modally
        present(cameraController, animated: true, completion: nil)
    }

    // MARK: UIImagePickerControllerDelegate

    /**
     Called when a photo is taken and approved
    **/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Dismiss the picker modal
        picker.dismiss(animated: true, completion: nil)
        // check for an image in the response
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        // set the image to our photo view
        photoView.image = image
    }
}
