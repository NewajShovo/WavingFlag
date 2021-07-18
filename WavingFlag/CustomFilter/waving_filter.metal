//
//  File.metal
//  WavingFlag
//
//  Created by leo on 24/12/20.
//

#include <metal_stdlib>
#include "MTIShaderLib.h"

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
    
    const float PI = 3.1415926535;        
    float w = sin((curCoord.x + curCoord.y - time * .5 + sin(1.5 * curCoord.x + 4.5 * curCoord.y) * PI * .3) * PI * .6); // fake waviness factor
     
//    float3 col = float3(currentColor.r,currentColor.g,currentColor.b);
    float3 col = float3(0.80,0.80,0.0);
    //col = mix(col, vec3(0.8,0.,0.), smoothstep(.01, .025, uv.y+w*.02));
    //col = mix(col, vec3(0.09,0.09,0.09), smoothstep(.65, .75, uv.y+w*.04));
//    col += w * .12;
     

    
    
    
//    float4 changedColor = float4(col,1.0);
    float4 changedColor = float4(1.0,1.0,1.0,1.0);
    
    
    
    
    

    return changedColor;
}
