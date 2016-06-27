//
//  ViewController.swift
//  QRCodeDemo
//
//  Created by 雪 禹 on 6/27/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    
    
    @IBOutlet weak var QRlabel: UILabel!
    
    var session: AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var borderView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupSession()
        setupBorderView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSession(){
        
        //session
        session = AVCaptureSession()
        //device
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        //input
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input){
                session.addInput(input)
            }
        } catch {
            print("Error handling the camera Input: \(error)")
            return
        }
        //output
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        //add preview layer
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session:session)
        videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer.frame = view.bounds
        view.layer.addSublayer(videoPreviewLayer)
        
        //start
        session.startRunning()
    }
    
    func setupBorderView(){
        borderView = UIView()
        borderView.layer.borderColor = UIColor.greenColor().CGColor
        borderView.layer.borderWidth = 2
        view.addSubview(borderView)
        view.bringSubviewToFront(borderView)
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        for metadataObject in metadataObjects{
            if metadataObject.type == AVMetadataObjectTypeQRCode {
                let metadata = metadataObject as! AVMetadataMachineReadableCodeObject
                let codeCoord = videoPreviewLayer.transformedMetadataObjectForMetadataObject(metadata) as! AVMetadataMachineReadableCodeObject
                borderView.frame = codeCoord.bounds
                
                if let QRValue = metadata.stringValue {
                    session.stopRunning()
                    QRlabel.text = QRValue
                    print(QRValue)
                }
            }
        }
    }



}

