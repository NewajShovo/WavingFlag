//
//  File.metal
//  WavingFlag
//
//  Created by leo on 24/12/20.
//

#include <metal_stdlib>
#include "MTIShaderLib.h"

//reference: http://glslsandbox.com/e#72454.0

using namespace metal;
using namespace metalpetal;

fragment float4 wavingFlagFragmentFunc(VertexOut vertexIn [[ stage_in ]],
                                       texture2d<float, access::sample> inTexture1 [[texture(0)]],
                                       sampler inSampler1 [[sampler(0)]],
                                       constant float &time [[ buffer(0) ]])
{
    
    float2 xy = vertexIn.textureCoordinate;
    float2 textureSize = float2(inTexture1.get_width(),inTexture1.get_height());
    float2 textureCoordinate = vertexIn.textureCoordinate;
    float2 curCoord = textureCoordinate * textureSize;
    
    
    
    float3 currentColor = inTexture1.sample(inSampler1, xy).rgb;
    float2 resolution = float2(inTexture1.get_width(),inTexture1.get_height());
    float2 p = (curCoord*2.0 -resolution)/min(resolution.x,resolution.y);
    float z = 0.5+sin(time*1.5+p.x*2.5)*0.5;
    p*=1.0+z * 0.1;
    z=1.0-z;
    z = 0.7+(z*.85);
    p.x += time*0.2;
    float3 col1 = currentColor;
    float3 col2 = currentColor;
    float d = step(sin(p.y*20.0)+sin(p.x*20.0),0.0);
    
//        float3 col1 = float3(0.0,1.0,0.0);
//        float3 col2 = float3(1.0,0.0,0.0);
//    float d = step(sin(p.y*20.0)+sin(p.x*20.0),0.0);
    float4 changeColor = float4(mix(col1,col2,d)*z,1.0);
    return changeColor ;
}
