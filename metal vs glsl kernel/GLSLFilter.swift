//
//  GLSLFilter.swift
//  metal vs glsl kernel
//
//  Created by Dan Pashchenko on 2/8/18.
//  Copyright © 2018 https://ios-engineer.com. All rights reserved.
//

import Foundation
import CoreImage

class GLSLFilter: CIFilter {
    
    @objc var inputImage: CIImage?
    @objc var inputRadius: CGFloat = 20
    @objc var inputAngle: CGFloat = CGFloat.pi / 4
    
    private let kernel = CIKernel(source: """
kernel vec4 motionBlur (sampler image, vec2 velocity) {
    const int NUM_SAMPLES = 10; // per direction

    vec4 s = vec4(0.0);
    vec2 dc = destCoord(), offset = -velocity;

    for (int i=0; i < (NUM_SAMPLES * 2 + 1); i++) {
        s += sample (image, samplerTransform (image, dc + offset));
        offset += velocity / float(NUM_SAMPLES);
    }
    return s / float((NUM_SAMPLES * 2 + 1));
}
""")
    
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
