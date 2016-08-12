//
//  QRScannerViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/17/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit
import AVFoundation
import SafariServices



class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, SFSafariViewControllerDelegate {
    
    
    @IBOutlet weak var QRModalView: UIView!
    @IBOutlet weak var qrWelcomeTextField: UITextView!
    @IBOutlet weak var getStartedButtonLabel: UIButton!
    @IBOutlet weak var qrCodeResult: UILabel!
    @IBOutlet weak var photoFrameImage: UIImageView!
    @IBOutlet weak var tabBarLineView: UIView!
    @IBOutlet weak var alignQRCodeLabel: UILabel!
    @IBOutlet weak var scanButton: UIButton!
    
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    
    func configureVideoCapture() {
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var error: NSError?
        let input: AnyObject!
        
        
        do {
            input = try AVCaptureDeviceInput(device: captureDevice) as AVCaptureDeviceInput
        }
        catch let error1 as NSError {
            error = error1
            input = nil
        }
//        if (error != nil) {
//            let alertController = UIAlertController(title: "Device Error", message: "Device not supported for this Application", preferredStyle: .Alert)
//            
//            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//            alertController.addAction(cancelAction)
//        }
        
        
        captureSession = AVCaptureSession()
        if captureDevice == nil {
    
            return
            
        } else {
            captureSession?.addInput(input as? AVCaptureInput)
        }
        
        let objCaptureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(objCaptureMetadataOutput)
        objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        objCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    }
    
    
    func addVideoPreviewLayer() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        self.view.layer.addSublayer(videoPreviewLayer!)
        captureSession?.startRunning()
    }
    
    func initializeQRView() {
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.blueColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 5
        self.view.addSubview(qrCodeFrameView!)
        self.view.addSubview(tabBarLineView)
        self.view.addSubview(photoFrameImage)
        self.view.addSubview(alignQRCodeLabel)
        self.view.addSubview(scanButton)
    }
    
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            return
        }
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if objMetadataMachineReadableCodeObject.type == AVMetadataObjectTypeQRCode {
            let objBarCode = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(objMetadataMachineReadableCodeObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = objBarCode.bounds;
            if objMetadataMachineReadableCodeObject.stringValue != nil {
                qrCodeResult.text = objMetadataMachineReadableCodeObject.stringValue
                
            }
        }
    }
    
    @IBAction func scanButtonTapped(sender: AnyObject) {
        
        let qrResult = qrCodeResult.text
        
        func openURL() {
            guard let url = NSURL(string: qrResult!) else {
                return
            }
            
            if ["http", "https"].contains(url.scheme.lowercaseString) {
                let safariViewController = SFSafariViewController(URL: url)
                self.presentViewController(safariViewController, animated: true, completion: nil)
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            } else { return }
        }
        openURL()
    }
    
    func qrOn(isOn: Bool = false) {
        if isOn {
            configureVideoCapture()
            addVideoPreviewLayer()
            initializeQRView()
        }}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        roundCornerButtons(QRModalView)
        roundCornerButtons(getStartedButtonLabel)
        roundCornerButtons(scanButton)
            gradient(self.view)

        }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if (captureSession?.running == true) {
            captureSession!.stopRunning()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if QRModalView.hidden == false {
            scanButton.hidden = true
            photoFrameImage.hidden = true
        } else {
            scanButton.hidden = false
            photoFrameImage.hidden = false
        }
        
        captureSession?.stopRunning()
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.removeFromSuperview()
        }
        
        qrCodeFrameView = nil
        
        initializeQRView()
        if (captureSession?.running == false) {
            self.captureSession!.startRunning()
        }
        
        if QRModalView.hidden == false {
            alignQRCodeLabel.hidden = true
        }
    }
    
    
    func cameraCheck() {
        let authStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        switch authStatus {
        case .Authorized:
            qrOn(true)
            QRModalView.hidden = true
            alignQRCodeLabel.hidden = false
            scanButton.hidden = false
            photoFrameImage.hidden = false
            
        case .Denied:
            let cameraAlert = UIAlertController(title: "No Camera Access", message: "Please Allow Access To The Camera", preferredStyle: .Alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .Default, handler: { (cameraAlert) in
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            cameraAlert.addAction(cancelAction)
            cameraAlert.addAction(settingsAction)
            
            self.presentViewController(cameraAlert, animated: true, completion: nil)
            
            
            QRModalView.hidden = false
            alignQRCodeLabel.hidden = true
            scanButton.hidden = true
            photoFrameImage.hidden = true
            
        case .NotDetermined:
            
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: nil)
            

            
        default: break
                
        }
    
    }
    
    @IBAction func getStartedButtonTapped(sender: AnyObject) {
        
        cameraCheck()

        }
}



