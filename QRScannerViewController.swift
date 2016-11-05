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
import MetalKit
import MetalPerformanceShaders
import Accelerate



class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, SFSafariViewControllerDelegate {
    
    
    @IBOutlet weak var QRModalView: UIView!
    @IBOutlet weak var qrWelcomeTextField: UITextView!
    @IBOutlet weak var getStartedButtonLabel: UIButton!
    @IBOutlet weak var qrCodeResult: UILabel!
    @IBOutlet weak var photoFrameImage: UIImageView!
    @IBOutlet weak var tabBarLineView: UIView!
    @IBOutlet weak var alignQRCodeLabel: UILabel!
    @IBOutlet weak var scanButton: UIButton!
    
    
    ///////
//    var Net: Inception3Net? = nil
//    var device: MTLDevice!
//    var commandQueue: MTLCommandQueue!
//    var imageNum = 0
//    var total = 6
//    var textureLoader : MTKTextureLoader!
//    var ciContext : CIContext!
//    var sourceTexture : MTLTexture? = nil
//    var camRan = false
///////
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    
    func configureVideoCapture() {
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
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
        objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
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
        qrCodeFrameView?.layer.borderColor = UIColor.blue.cgColor
        qrCodeFrameView?.layer.borderWidth = 5
        self.view.addSubview(qrCodeFrameView!)
        self.view.addSubview(tabBarLineView)
        self.view.addSubview(photoFrameImage)
        self.view.addSubview(alignQRCodeLabel)
        self.view.addSubview(scanButton)
    }
    
    
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if objMetadataMachineReadableCodeObject.type == AVMetadataObjectTypeQRCode {
            let objBarCode = videoPreviewLayer?.transformedMetadataObject(for: objMetadataMachineReadableCodeObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = objBarCode.bounds;
            if objMetadataMachineReadableCodeObject.stringValue != nil {
                qrCodeResult.text = objMetadataMachineReadableCodeObject.stringValue
                
            }
        }
    }
    
    @IBAction func scanButtonTapped(_ sender: AnyObject) {
        
        let qrResult = qrCodeResult.text
        
        func openURL() {
            guard let url = URL(string: qrResult!) else {
                return
            }
            
            if ["http", "https"].contains(url.scheme!.lowercased()) {
                let safariViewController = SFSafariViewController(url: url)
                self.present(safariViewController, animated: true, completion: nil)
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            } else { return }
        }
        openURL()
    }
    
    func qrOn(_ isOn: Bool = false) {
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (captureSession?.isRunning == true) {
            captureSession!.stopRunning()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if QRModalView.isHidden == false {
            scanButton.isHidden = true
            photoFrameImage.isHidden = true
        } else {
            scanButton.isHidden = false
            photoFrameImage.isHidden = false
        }
        
        captureSession?.stopRunning()
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.removeFromSuperview()
        }
        
        qrCodeFrameView = nil
        
        initializeQRView()
        if (captureSession?.isRunning == false) {
            self.captureSession!.startRunning()
        }
        
        if QRModalView.isHidden == false {
            alignQRCodeLabel.isHidden = true
        }
    }
    
    
    func cameraCheck() {
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch authStatus {
        case .authorized:
            qrOn(true)
            QRModalView.isHidden = true
            alignQRCodeLabel.isHidden = false
            scanButton.isHidden = false
            photoFrameImage.isHidden = false
            
        case .denied:
            let cameraAlert = UIAlertController(title: "No Camera Access", message: "Please Allow Access To The Camera", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { (cameraAlert) in
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            cameraAlert.addAction(cancelAction)
            cameraAlert.addAction(settingsAction)
            
            self.present(cameraAlert, animated: true, completion: nil)
            
            
            QRModalView.isHidden = false
            alignQRCodeLabel.isHidden = true
            scanButton.isHidden = true
            photoFrameImage.isHidden = true
            
        case .notDetermined:
            
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: nil)
            

            
        default: break
                
        }
    
    }
    
    @IBAction func getStartedButtonTapped(_ sender: AnyObject) {
        
        cameraCheck()

        }
    
//    func runNetwork(){
//        
//        // to deliver optimal performance we leave some resources used in MPSCNN to be released at next call of autoreleasepool,
//        // so the user can decide the appropriate time to release this
//        autoreleasepool{
//            // encoding command buffer
//            let commandBuffer = commandQueue.makeCommandBuffer()
//            
//            // encode all layers of network on present commandBuffer, pass in the input image MTLTexture
//            Net!.forward(commandBuffer: commandBuffer, sourceTexture: sourceTexture)
//            
//            // commit the commandBuffer and wait for completion on CPU
//            commandBuffer.commit()
//            commandBuffer.waitUntilCompleted()
//            
//            // display top-5 predictions for what the object should be labelled
//            let label = Net!.getLabel()
//            alignQRCodeLabel.text = label
//            alignQRCodeLabel.isHidden = false
//        }
//        
//    }
}



