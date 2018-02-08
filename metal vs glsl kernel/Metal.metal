//
//  Metal.metal
//  metal vs glsl kernel
//
//  Created by Dan Pashchenko on 2/7/18.
//  Copyright © 2018 https://ios-engineer.com. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

#include <CoreImage/CoreImage.h>

extern "C" { namespace coreimage {
 
    float4 motionBlur(sampler image, float2 velocity, destination dest){
        const int NUM_SAMPLES = 10; // per direction
     
        float4 s = float4(0.0);
        float2 dc = dest.coord(), offset = -velocity;
        
        for (int i=0; i < (NUM_SAMPLES * 2 + 1); i++) {
            s += image.sample(image.transform(dc + offset));
            offset += velocity / float(NUM_SAMPLES);
        }
        
        return s / float((NUM_SAMPLES * 2 + 1));
    }
    
}}
