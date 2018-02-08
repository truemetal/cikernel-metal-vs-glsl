//
//  MetalFilter.swift
//  metal vs glsl kernel
//
//  Created by Dan Pashchenko on 2/7/18.
//  Copyright © 2018 https://ios-engineer.com. All rights reserved.
//

import CoreImage

class MetalFilter: CIFilter
{
    @objc var inputImage: CIImage?
    @objc var inputRadius: CGFloat = 20
    @objc var inputAngle: CGFloat = CGFloat.pi / 4
    
    private let kernel = try? CIKernel(functionName: "motionBlur", fromMetalLibraryData: MetalLib.data)
    
    override var outputImage: CIImage? {
        guard let kernel = kernel, let inputImage = inputImage else { abort() }
        
        let velocity = CIVector(x: inputRadius * cos(inputAngle), y: inputRadius * sin(inputAngle))
        
        let dod = regionOf(rect: inputImage.extent, vector: velocity)
        
        return kernel.apply(extent: dod, roiCallback: { self.regionOf(rect: $1, vector: velocity) }, arguments: [inputImage, velocity])
    }
    
    func regionOf(rect: CGRect, vector: CIVector) -> CGRect {
        return rect.insetBy(dx: -abs(vector.x), dy: -abs(vector.y))
    }
}

class MetalLib {
    private static var url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
    static var data = try! Data(contentsOf: url)
}
