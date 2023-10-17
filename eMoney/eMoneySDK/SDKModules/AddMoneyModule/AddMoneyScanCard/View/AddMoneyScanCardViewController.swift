//
//  AddMoneyScanCardViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 07/05/2023.
//  
//

import UIKit
import AVFoundation
import Vision
import CoreImage

class AddMoneyScanCardViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var scannerView: UIView!
    @IBOutlet weak var guidedView: UIView!
    
    // MARK: Properties
    var presenter: AddMoneyScanCardPresenterProtocol!
    
    // MARK: - Private Properties
    private let captureSession = AVCaptureSession()
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let preview = AVCaptureVideoPreviewLayer(session: self.captureSession)
        preview.videoGravity = .resizeAspectFill
        return preview
    }()
    private let device = AVCaptureDevice.default(for: .video)
    private let videoOutput = AVCaptureVideoDataOutput()
    
    private var captureButton: UIButton?
    
    var inCaptureFrame = false
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.navigationController as? BaseNavigationController)?.setupNavigationWithClearBackground()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (self.navigationController as? BaseNavigationController)?.navigationBarWithWhiteBackground()
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = scannerView.bounds
    }
    
    deinit {
        stopSession()
    }
}

// MARK: - Class Methods
extension AddMoneyScanCardViewController: AddMoneyScanCardViewProtocol {
    func setupUI() {
        setupNavigation()
        startCaptureSession()
    }
    
    private func setupNavigation() {
        self.navigationItem.setTitle(title: Strings.AddMoney.addNewCard, subtitle: Strings.AddMoney.scanCard, isBlackNav: true)
        self.createNavBackBtn(isWhite: true)
    }
}

// MARK: - Start Capture Session
extension AddMoneyScanCardViewController {
    
    // MARK: - Add Views
    func startCaptureSession() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // the user has already authorized to access the camera.
            self.setupCaptureSession()
            
        case .notDetermined: // the user has not yet asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted { // if user has granted to access the camera.
                    print("the user has granted to access the camera")
                    DispatchQueue.main.async {
                        self.setupCaptureSession()
                    }
                } else {
                    print("the user has not granted to access the camera")
                }
            }
            
        case .denied:
            print("the user has denied previously to access the camera.")
            
        case .restricted:
            print("the user can't give camera access due to some restriction.")
            
        default:
            print("something has wrong due to we can't access the camera.")
        }
    }
    
    private func setupCaptureSession() {
        addCameraInput()
        addPreviewLayer()
        addVideoOutput()
        addCaptureButton()
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    private func addCameraInput() {
        guard let device = device else { return }
        let cameraInput = try! AVCaptureDeviceInput(device: device)
        captureSession.addInput(cameraInput)
    }

    private func addPreviewLayer() {
        scannerView.layer.addSublayer(previewLayer)
    }
    
    private func addVideoOutput() {
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as NSString: NSNumber(value: kCVPixelFormatType_32BGRA)] as [String: Any]
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "my.image.handling.queue"))
        captureSession.addOutput(videoOutput)
        guard let connection = videoOutput.connection(with: AVMediaType.video),
            connection.isVideoOrientationSupported else {
            return
        }
        connection.videoOrientation = .portrait
    }
    
    private func stopSession() {
        captureSession.stopRunning()
    }
    
    private func addCaptureButton() {
        captureButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        scannerView.addSubview(captureButton!)
        captureButton?.translatesAutoresizingMaskIntoConstraints = false
        captureButton?.centerXAnchor.constraint(equalTo: scannerView.centerXAnchor).isActive = true
        captureButton?.bottomAnchor.constraint(equalTo: scannerView.bottomAnchor, constant: -63).isActive = true
        captureButton?.setTitle("", for: .normal)
        captureButton?.setImage(UIImage(named: "captureBtn"), for: .normal)
        captureButton?.addTarget(self, action: #selector(scanCompleted), for: .touchUpInside)
    }
}

// MARK: - Actions
extension AddMoneyScanCardViewController {
    @objc func scanCompleted() {
        self.inCaptureFrame = true
    }
}

// MARK: - AV Capture Photo Delegate Methods
extension AddMoneyScanCardViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("unable to get image from sample buffer")
            return
        }
        
        if inCaptureFrame {
            self.inCaptureFrame = false
            self.handleObservedPaymentCard(in: frame)
        }
    }
}

// MARK: - Extract Card Data
extension AddMoneyScanCardViewController {
    private func handleObservedPaymentCard(in frame: CVImageBuffer) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.extractPaymentCardData(frame: frame)
        }
    }

    private func extractPaymentCardData(frame: CVImageBuffer) {
        let ciImage = CIImage(cvImageBuffer: frame)
        
        DispatchQueue.main.async {
            var recognizedText = [String]()
            var request = VNRecognizeTextRequest()
            request.recognitionLevel = .accurate
            request.customWords = CardType.allCases.map { $0.rawValue } + ["Expiry Date"]
            request.usesLanguageCorrection = false
            request = VNRecognizeTextRequest() { (request, error) in
                guard let results = request.results,
                      !results.isEmpty,
                      let requestResults = request.results as? [VNRecognizedTextObservation]
                else {
                    print("requestResults not found")
                    return
                }
                recognizedText = requestResults.compactMap { observation in
                    return observation.topCandidates(1).first?.string
                }
                
                if recognizedText.isEmpty == false {
                    
                }
            }
            
            let context = CIContext(options: nil)
            
            guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
                return
            }
            
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try handler.perform([request])
                let cardDetails = self.parseResults(for: recognizedText)
                
                var message = (cardDetails.name ?? "") + "\n"
                message += (cardDetails.number ?? "") + "\n"
                message += (cardDetails.expiryDate ?? "") + "\n"
                self.presenter.sendBack(cardDetails: cardDetails)
                
            } catch {
                print(error)
                self.showAlert(with: error.localizedDescription)
            }
        }
    }
    
    func parseResults(for recognizedText: [String]) -> CardDetails {
        
        if recognizedText.isEmpty {
            return CardDetails()
        }
        
        // Credit Card Number
        let creditCardNumber = recognizedText.first(where: { $0.count >= 14 && ["4", "5", "3", "6"].contains($0.first) })
        
        // Expiry Date
        let expiryDateString = recognizedText.first(where: { $0.count > 4 && $0.contains("/") && $0.replace(string: "/", replacement: "").isOnlyNumbers })
        let expiryDate = expiryDateString?.filter({ $0.isNumber || $0 == "/" })
        
        // Name
        let ignoreList = ["GOOD THRU", "GOOD", "THRU", "Gold", "GOLD", "Standard", "STANDARD", "Platinum", "PLATINUM", "WORLD ELITE", "WORLD", "ELITE", "World Elite", "World", "Elite", "Deb", "Cre"]
        let wordsToAvoid = [creditCardNumber, expiryDateString] +
            ignoreList +
            CardType.allCases.map { $0.rawValue } +
            CardType.allCases.map { $0.rawValue.lowercased() } +
            CardType.allCases.map { $0.rawValue.uppercased() }
        let name = recognizedText.filter({ !wordsToAvoid.contains($0) }).last
        
        return CardDetails(numberWithDelimiters: creditCardNumber, name: name, expiryDate: expiryDate)
    }
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
