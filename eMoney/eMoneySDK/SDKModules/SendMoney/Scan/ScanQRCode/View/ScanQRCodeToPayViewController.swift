//
//  ScanQRCodeToPayViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 11/05/2023.
//  
//

import Foundation
import UIKit
import AVFoundation
import Photos

class ScanQRCodeToPayViewController: BaseViewController,AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var segmentControl: FloatingSegmentedControl!
    
    @IBOutlet weak var btnTorch: UIButton!
    @IBOutlet weak var requestMoneyQRCode: UIView!
    @IBOutlet weak var btnOpenGallery: UIButton!
    
    @IBOutlet weak var scanQRCodeView: UIView!
    @IBOutlet weak var btnSharePaymentURL: BaseButton!
    // MARK: Properties
    @IBOutlet weak var btnCopyURL: UIButton!
    
    @IBOutlet weak var showYourQRCodeLabel: UILabel!
    @IBOutlet weak var eAndMoneyLabel: UILabel!
    
    @IBOutlet weak var scannerView: UIView!
    @IBOutlet weak var scanQRCodeLabel: UILabel!
    
    @IBOutlet weak var scanToPayLabel: UILabel!
    @IBOutlet weak var imgView203: UIImageView!
    @IBOutlet weak var imgView204: UIImageView!
    @IBOutlet weak var imgView205: UIImageView!
    @IBOutlet weak var imgView206: UIImageView!
    var presenter: ScanQRCodeToPayPresenterProtocol?
    var imagePicker = UIImagePickerController()
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    private let metadataQueue = DispatchQueue(label: "metadata.session.qrreader.queue")
    private let videoDataQueue = DispatchQueue(label: "videoData.session.qrreader.queue")
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUpScanner()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.captureSession?.isRunning == false) {
            metadataQueue.async { [weak self] in
                self?.captureSession.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (self.captureSession?.isRunning == true) {
            metadataQueue.async { [weak self] in
                self?.captureSession.stopRunning()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
     
//        self.previewLayer?.frame = self.scannerView.layer.bounds
//        self.previewLayer?.cornerRadius = 12
        // Fix orientation
//        if let connection = self.previewLayer?.connection {
//            let orientation = self.view.window?.windowScene?.interfaceOrientation ?? UIInterfaceOrientation.portrait
//            let previewLayerConnection : AVCaptureConnection = connection
//
//            if (previewLayerConnection.isVideoOrientationSupported) {
//                switch (orientation) {
//                case .landscapeRight:
//                    previewLayerConnection.videoOrientation = AVCaptureVideoOrientation.landscapeRight
//                case .landscapeLeft:
//                    previewLayerConnection.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
//                case .portraitUpsideDown:
//                    previewLayerConnection.videoOrientation = AVCaptureVideoOrientation.portraitUpsideDown
//                default:
//                    previewLayerConnection.videoOrientation = AVCaptureVideoOrientation.portrait
//                }
//            }
//        }
    }
    func setUpScanner(){
        CommonMethods.checkCameraAccess { success in
            if success {
                DispatchQueue.main.async {
                    self.setUpScannerView()
                }
            }
        }
    }
    
    func setUpScannerView(){
        // Setup Camera Capture
        let captureSession = AVCaptureSession()
        self.captureSession = captureSession
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (self.captureSession.canAddInput(videoInput)) {
            self.captureSession.addInput(videoInput)
        } else {
            self.failed()
            return
        }
        
        // Now the camera is setup add a metadata output
        let metadataOutput = AVCaptureMetadataOutput()
        if (self.captureSession.canAddOutput(metadataOutput)) {
            self.captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            self.failed()
            return
        }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.previewLayer.frame = self.scannerView.bounds
        self.previewLayer.videoGravity = .resizeAspectFill
        self.scannerView.layer.addSublayer(self.previewLayer)
        self.previewLayer.cornerRadius = 12
        self.scannerView.layer.cornerRadius = 12
        self.scannerView.bringSubviewToFront(self.imgView203)
        self.scannerView.bringSubviewToFront(self.imgView204)
        self.scannerView.bringSubviewToFront(self.imgView205)
        self.scannerView.bringSubviewToFront(self.imgView206)
        self.scannerView.bringSubviewToFront(self.btnTorch)
        
        DispatchQueue.global(qos: .background).async(execute: {
            self.captureSession.startRunning()
        })
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning failed", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(ac, animated: true)
        self.captureSession = nil
    }
    

    // MARK: AVCaptureMetadataOutputObjectsDelegate
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            print("Success")
            self.presenter?.navigateToSendMoneyEnterAmount()
            self.captureSession.stopRunning()
            // Show bounds
            let qrCodeObject: AVMetadataObject? = self.previewLayer.transformedMetadataObject(for: readableObject)
            // self.showQRCodeBounds(frame: qrCodeObject?.bounds)
        }
    }
    
    
    
    // MARK: - Detect QR Code From Static Image
    // https://stackoverflow.com/a/49275021/458205
    
    /// Detect a QR Code in a static image
    /// - Parameter image: The image to scan for QR codes
    /// - Returns: The found QR code details
    func detectQRCode(_ image: UIImage?) -> [CIFeature]? {
        if let image = image, let ciImage = CIImage.init(image: image){
            var options: [String: Any]
            let context = CIContext()
            options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
            let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
            if ciImage.properties.keys.contains((kCGImagePropertyOrientation as String)){
                options = [CIDetectorImageOrientation: ciImage.properties[(kCGImagePropertyOrientation as String)] ?? 1]
            } else {
                options = [CIDetectorImageOrientation: 1]
            }
            let features = qrDetector?.features(in: ciImage, options: options)
            return features

        }
        return nil
    }
    
    @IBAction func btnTorchPressed(_ sender: Any) {
        if (sender as AnyObject).isSelected{
            toggleFlash(on: false)
            btnTorch.isSelected = false
        }else{
            toggleFlash(on: true)
            btnTorch.isSelected = true
        }
        
    }
    @IBAction func btnOpenGalleryPressed(_ sender: Any) {
        
        CommonMethods.checkGalleryAccess { success in
            if success{
                DispatchQueue.main.async {
                    self.imagePicker.delegate = self
                    self.imagePicker.sourceType = .photoLibrary
                    self.imagePicker.allowsEditing = false
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            }
        }
        
    }
    @IBAction func btnSharePaymentURLPressed(_ sender: Any) {
    }
    
    @IBAction func btnCopyURLPressed(_ sender: Any) {
    }
    
    func toggleFlash(on: Bool ) {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            
            device.torchMode = on ? .on : .off
            if on {
                try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
            }
            
            device.unlockForConfiguration()
        } catch {
            print("Error: \(error)")
        }
    }
}

extension ScanQRCodeToPayViewController: ScanQRCodeToPayViewProtocol {
    
    func setupUI() {
        setUpNavbar()
        segmentControl.setSegments(with: ["Send money", "Request money"])
        segmentControl.addTarget(self, action: #selector(update(_:)))
        segmentControl.isAnimateFocusMoving = true
        segmentControl.focusedIndex = 0
        btnOpenGallery.isHidden = false
        btnCopyURL.isHidden = true
        btnSharePaymentURL.isHidden = true
        scanQRCodeView.isHidden = false
        requestMoneyQRCode.isHidden = true
        showYourQRCodeLabel.text = "Show your QR code to anyone to receive money."
        showYourQRCodeLabel.font = AppFont.appRegular(size: .body3)
        showYourQRCodeLabel.textColor = AppColor.eAnd_Grey_100
        eAndMoneyLabel.text = "e& money ID #:331670"
        eAndMoneyLabel.font = AppFont.appSemiBold(size: .body3)
        eAndMoneyLabel.textColor = AppColor.eAnd_Black_80
        btnCopyURL.setTitle("   Copy URL", for: .normal)
        btnCopyURL.titleLabel?.font = AppFont.appSemiBold(size: .body5)
        btnCopyURL.setTitleColor(AppColor.eAnd_Red_100, for: .normal)
        scanQRCodeLabel.text = "Scan a QR code to pay"
        scanQRCodeLabel.font = AppFont.appRegular(size: .body2)
        scanQRCodeLabel.textColor = AppColor.eAnd_Black_80
        scannerView.layer.cornerRadius = 12
        scanQRCodeLabel.text = "Position the QR within the box"
        scanQRCodeLabel.font = AppFont.appRegular(size: .body3)
        scanQRCodeLabel.textColor = AppColor.eAnd_Black_80
        btnOpenGallery.setTitle("Upload from gallery", for: .normal)
        btnOpenGallery.titleLabel?.font = AppFont.appSemiBold(size: .body5)
        btnOpenGallery.setTitleColor(AppColor.eAnd_Black_80, for: .normal)
        
    }
    private func setUpNavbar(){
        self.navigationItem.setTitle(title: "QR payments")
        self.createNavBackBtn()
    }
    @objc func update(_ sender: FloatingSegmentedControl) {
        
        if sender.focusedIndex == 0{
            btnOpenGallery.isHidden = false
            btnCopyURL.isHidden = true
            btnSharePaymentURL.isHidden = true
            scanQRCodeView.isHidden = false
            requestMoneyQRCode.isHidden = true
            metadataQueue.async { [weak self] in
                self?.captureSession.startRunning()
            }
        }else{
            metadataQueue.async { [weak self] in
                self?.captureSession.stopRunning()
            }
            btnOpenGallery.isHidden = true
            btnCopyURL.isHidden = false
            btnSharePaymentURL.isHidden = false
            scanQRCodeView.isHidden = true
            requestMoneyQRCode.isHidden = false
            
        }
    }
}

extension ScanQRCodeToPayViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let features = detectQRCode(image), !features.isEmpty{
                for case let row as CIQRCodeFeature in features{
                    print(row.messageString ?? "nope")
                    self.presenter?.navigateToSendMoneyEnterAmount()
                }
            }
        }
    }
}
