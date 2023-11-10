//
//  SelfiPreviewViewController.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 25/04/2023.
//

import UIKit
import AVFoundation

class SelfiPreviewViewController: BaseViewController {
    
    @IBOutlet weak var stepBar: BaseStepper!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var instructionLabel: UILabel!
    
    //Camera Capture requiered properties
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    var popToViewController:AnyClass? = nil
    
    var updateType:UserUpdateType?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setTitle(title: "register".localized, subtitle: "verify_identity".localized, isBlackNav: true)
        
        self.stepBar.addRedLine(noOfSteps: 4, currentStep: 2)
        self.createNavBackBtn(isWhite: true)
        instructionLabel.text = "self_instruction_msg".localized
 
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
        (self.navigationController as? BaseNavigationController)?.isBlackNavBar = true
        NotificationCenter.default.post(name: .onChangeTopViewColor, object: nil, userInfo: ["isBlack":true])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Setup your camera here...
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        setScreenSize(size: .fullScreenOverContext)
        NotificationCenter.default.post(name: .onChangeTopCloseButton, object: nil, userInfo: ["isShow":false])
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video,position: .front)
            else {
                print("Unable to access back camera!")
                return
        }
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (self.navigationController as? BaseNavigationController)?.isBlackNavBar = false
        NotificationCenter.default.post(name: .onChangeTopViewColor, object: nil, userInfo: ["isBlack":false])
        self.captureSession.stopRunning()
    }

    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.previewView.bounds
            }
        }
    }
    
    @IBAction func captureBtnTapped(_ sender: Any) {
        let vc = LivenessCheckViewController.instantiate(fromAppStoryboard: .Liveness)
        vc.cofigurationResponse = GlobalData.shared.keyAndConfiguration
//        vc.popToViewController = self.popToViewController
        vc.updateType = self.updateType
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// AVCaptureVideoDataOutputSampleBufferDelegate protocol and related methods
extension SelfiPreviewViewController:  AVCaptureVideoDataOutputSampleBufferDelegate{
    

}
