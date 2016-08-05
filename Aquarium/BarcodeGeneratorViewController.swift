//
//  BarcodeGeneratorViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 8/4/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit
import CoreImage

class BarcodeGeneratorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var barcodeImage: UIImageView!
    @IBOutlet weak var barcodeNumberLabel: UILabel!
    @IBOutlet weak var barcodeNumberTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient(self.view)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BarcodeGeneratorViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        barcodeNumberTextField.delegate = self

    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        
        
        
        if barcodeNumberTextField.text != nil {
        let barcodeNumber = barcodeNumberTextField.text
        let barcode = BarcodeGeneratorViewController.barcodefromString(barcodeNumber!)
        
        barcodeImage.image = barcode
        barcodeNumberLabel.text = barcodeNumber
        roundCornerButtons(barcodeImage)
        textField.resignFirstResponder()
        } else {
            textField.resignFirstResponder()}
        return true
        }
    
    
    
    
    class func barcodefromString(string : String) -> UIImage? {
        
        guard let barcode = string.dataUsingEncoding(NSASCIIStringEncoding) else { return BarcodeGeneratorViewController.barcodefromString("1") }
        
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        filter!.setValue(barcode, forKey: "inputMessage")
        return UIImage(CIImage: filter!.outputImage!)
    }
    
    @IBAction func createButtonTapped(sender: AnyObject) {
        
        guard let barcodeNumber = barcodeNumberTextField.text else { return }
   
        let barcode = BarcodeGeneratorViewController.barcodefromString(barcodeNumber)
        
        barcodeImage.image = barcode
        barcodeNumberLabel.text = barcodeNumber
        roundCornerButtons(barcodeImage)
        dismissKeyboard()
        
    }

}

