//
//  ViewController.swift
//  Focuser
//
//  Created by Artur Gurgul on 01/12/2017.
//  Copyright © 2017 Artur Gurgul. All rights reserved.
//

import UIKit
import BarcodeScanner

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , BarcodeScannerCodeDelegate {
    
    @IBOutlet weak var barcodeImageView: UIImageView!
    func generate(string : String) -> CIImage {
        let data = string.data(using: .ascii)
        //let filter = CIFilter(name: "CIAztecCodeGenerator")
        
        //let filter = CIFilter(name: "CIQRCodeGenerator")
         let filter = CIFilter(name: "CICode128BarcodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        //filter?.setValue(NSNumber(value:240), forKey: kCIInputWidthKey)
        
        let context = CIContext()
        
        return filter!.outputImage!
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func barcodeScannerDidDismiss(_ controller: BarcodeScannerController) {
        controller.dismiss(animated: true)
    }
    
    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        let alert = UIAlertController(title: code, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    @IBAction func scanAction(_ sender: Any) {
        let controller = BarcodeScannerController()
        controller.codeDelegate = self
        
        present(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: "followCell")!
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cf23df2207d99a74fbe169e3eba035e633b65d94
        //cf23df2207d99a74fbe1
        // 69e3eba035
        // e633b65d94
        
        let image  = generate(string: "69e3eba035e6")
        
        let x = barcodeImageView.frame.size.width / image.extent.size.width
        let y = barcodeImageView.frame.size.height / image.extent.size.height
        
        let transformation = CGAffineTransform(scaleX: x, y: y)
        //let transformation = CGAffineTransform(scaleX: 0.5, y: 0.5)
        //image.applying(transformation)
        
        
        
        barcodeImageView.image = UIImage(ciImage:image.transformed(by: transformation))
        
    }
}

