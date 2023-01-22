//
//  ViewController.swift
//  IntroduceingMe
//
//  Created by Ellah Nzikoba on 1/21/23.
//

import UIKit
import Foundation
import PhotosUI

class ViewController: UIViewController, PHPickerViewControllerDelegate {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var schoolYearSegmentControl: UISegmentedControl!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var addImageButton: UIButton!
    
    @IBOutlet weak var petsCountStepper: UIStepper!
    @IBOutlet weak var numberOfPets: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var morePetsSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        morePetsSwitch.setOn(false, animated: false)
        morePetsSwitch.onTintColor = UIColor.red
        
        let textColorAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(textColorAttributes, for: .selected)
        schoolYearSegmentControl.selectedSegmentTintColor = UIColor.red
        schoolYearSegmentControl.tintColor = UIColor.white
        
        
        var buttonConfig = addImageButton.configuration
        buttonConfig?.baseBackgroundColor = UIColor.black
        buttonConfig?.baseForegroundColor = UIColor.white
        addImageButton.configuration = buttonConfig

        // Do any additional setup after loading the view.
    }
    
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        // Get value from stepper
        numberOfPets.text = "\(Int(sender.value))"
    }
    
    @IBAction func didTapIntroduceYourself(_ sender: UIButton) {
        
        let year = schoolYearSegmentControl.titleForSegment(at: schoolYearSegmentControl.selectedSegmentIndex)
        let introduction = """
        My name is \(firstNameTextField.text!) \(lastNameTextField.text!) and I attend \(schoolTextField.text!).
        I am currently in my \(year!) year and I own \(numberOfPets.text!) pet\(Int(numberOfPets.text!)! == 1 ? "" : "s"). It is \(morePetsSwitch.isOn) that I want more pets.
        """
        
//        print(introduction)
        
        let alertController = UIAlertController(title: "My Introduction", message: introduction, preferredStyle: .alert)
                
        let dismissAlert = UIAlertAction(title: "Nice to meet you!", style: .default, handler: nil)
        alertController.addAction(dismissAlert)
        
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func didTapAddImage(_ sender: UIButton) {
        var phpConfig = PHPickerConfiguration()
        phpConfig.filter = .images
        phpConfig.selectionLimit = 1
        let imagePicker = PHPickerViewController(configuration: phpConfig)
        imagePicker.delegate = self
        imagePicker.title = "Add Image"
        present(imagePicker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        results.forEach {result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}

