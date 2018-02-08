//
//  ViewController.swift
//  metal vs glsl kernel
//
//  Created by Dan Pashchenko on 2/7/18.
//  Copyright © 2018 https://ios-engineer.com. All rights reserved.
//

import UIKit
import CoreImage

let context = CIContext(mtlDevice: MTLCreateSystemDefaultDevice()!)

class ViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = context
        
        after(1) {
            var image: UIImage!
            measure("glsl 1") { image = self.processImage(filter: self.glslFilter) }
            measure("glsl 2") { image = self.processImage(filter: self.glslFilter) }
            measure("glsl 3") { image = self.processImage(filter: self.glslFilter) }
            measure("glsl 4") { image = self.processImage(filter: self.glslFilter) }
            measure("glsl 5") { image = self.processImage(filter: self.glslFilter) }
            measure("glsl 6") { image = self.processImage(filter: self.glslFilter) }
            measure("glsl 7") { image = self.processImage(filter: self.glslFilter) }
            measure("glsl 8") { image = self.processImage(filter: self.glslFilter) }
            measure("glsl 9") { image = self.processImage(filter: self.glslFilter) }
            measure("glsl 10") { image = self.processImage(filter: self.glslFilter) }
            measure("metal 1") { image = self.processImage(filter: self.metalFilter) }
            measure("metal 2") { image = self.processImage(filter: self.metalFilter) }
            measure("metal 3") { image = self.processImage(filter: self.metalFilter) }
            measure("metal 4") { image = self.processImage(filter: self.metalFilter) }
            measure("metal 5") { image = self.processImage(filter: self.metalFilter) }
            measure("metal 6") { image = self.processImage(filter: self.metalFilter) }
            measure("metal 7") { image = self.processImage(filter: self.metalFilter) }
            measure("metal 8") { image = self.processImage(filter: self.metalFilter) }
            measure("metal 9") { image = self.processImage(filter: self.metalFilter) }
            measure("metal 10") { image = self.processImage(filter: self.metalFilter) }
            self.imgView.image = image
        }
    }
    
    var photo = UIImage(named: "photo.jpg")!
    var metalFilter = MetalFilter()
    var glslFilter = GLSLFilter()
    
    func processImage(filter: CIFilter) -> UIImage {
        filter.setValue(CIImage(cgImage: photo.cgImage!), forKey: kCIInputImageKey)
        return convert(cmage: filter.outputImage!)
    }
}

public func convert(cmage: CIImage) -> UIImage {
    let cgImage = context.createCGImage(cmage, from: cmage.extent)!
    return UIImage(cgImage: cgImage)
}

func measure(_ description: String, block: ()->()) {
    let start = Date()
    block()
    print("\(description) took \((Date().timeIntervalSinceReferenceDate - start.timeIntervalSinceReferenceDate) * 1000)ms")
}

func after(_ delay: Double, block: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: block)
}
