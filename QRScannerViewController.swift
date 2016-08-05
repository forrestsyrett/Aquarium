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
    
    
    @IBOutlet weak var qrCodeResult: UILabel!
    @IBOutlet weak var photoFrameImage: UIImageView!
    @IBOutlet weak var tabBarLineView: UIView!
    @IBOutlet weak var alignQRCodeLabel: UILabel!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var cameraAccessPenguin: UIImageView!
    
    
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
        if (error != nil) {
            let alertController = UIAlertController(title: "Device Error", message: "Device not supported for this Application", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
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
        if AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) ==  AVAuthorizationStatus.Authorized
        {
        qrOn(true)
        scanButton.layer.cornerRadius = 20
            cameraAccessPenguin.hidden = true
        }
        
        else {
            gradient(self.view)
            photoFrameImage.hidden = true
            alignQRCodeLabel.text = "Please Allow Access to The Camera"
            scanButton.hidden = true
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if (captureSession?.running == true) {
            captureSession!.stopRunning()
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        captureSession?.stopRunning()
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.removeFromSuperview()
        }
        
        qrCodeFrameView = nil
        
        initializeQRView()
        if (captureSession?.running == false) {
            self.captureSession!.startRunning()
        }
    }
    
    
}




