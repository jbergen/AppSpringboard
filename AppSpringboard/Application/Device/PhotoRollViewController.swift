//
//  PhotoRollViewController.swift
//  AppSpringboard
//
//  Created by Joseph Bergen on 7/23/18.
//  Copyright © 2018 Joseph Bergen. All rights reserved.
//

import UIKit

/**

 Photo Roll Demo

 This demo shows a very simple implementation of the photo roll feature. Tapping the plus icon in the
 upper right hand corner launches the photo picker as a modal. Once an image is chosen, the modal is
 dismissed, then the image is returned and displayed in the view controller.

 DOCS
 ====
 UIImagePickerController: https://developer.apple.com/documentation/uikit/uiimagepickercontroller
 UIImagePickerControllerDelegate: https://developer.apple.com/documentation/uikit/uiimagepickercontrollerdelegate
 UINavigationControllerDelegate: https://developer.apple.com/documentation/uikit/uinavigationcontrollerdelegate

 **/

// We need to conform to `UIImagePickerControllerDelegate` & `UINavigationControllerDelegate` to respond to the picker events
class PhotoRollViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // this is the view that the resulting image will be shown in
    private let photoView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Roll"
        view.backgroundColor = .white

        // set the right navigation bar button to be a camera button that will call `showCamera` when tapped
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pickPhoto))

        // set a background pattern so it's easier to see where the image will appear
        if let transparencyImage = UIImage(named: "transparency") {
            photoView.backgroundColor = UIColor(patternImage: transparencyImage)
        }

        // set up and add the image view for the photo
        photoView.contentMode = .scaleAspectFit
        photoView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: view.bounds.width - 40)
        photoView.center = view.center
        view.addSubview(photoView)
    }

    /**
     When the add button is tapped, this function is called which takes care of prompting the user for permissions
     and presenting the photo picker
     **/
    @objc func pickPhoto() {
        // check for permissions and hardware availability
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        let pickerController = UIImagePickerController()
        // set the delegate to self to handle the results
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        // present the picker modally
        present(pickerController, animated: true, completion: nil)
    }

    // MARK: UIImagePickerControllerDelegate

    /**
     Called when a photo chosen approved
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
