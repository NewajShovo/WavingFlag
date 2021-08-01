//
//  File.metal
//  WavingFlag
//
//  Created by leo on 24/12/20.
//

#include <metal_stdlib>
#include "MTIShaderLib.h"

//reference: http://glslsandbox.com/e#72454.0
//https://glslsandbox.com/e#70004.1

using namespace metal;
using namespace metalpetal;


//vec2 p=FC.xy/min(r.x,r.y)*8.;
//float a=length(p)+t*acos(-1.0)+smoothstep(0.2,0.22,length((p-vec2(7.0,4.0)))*.08);;
//p+=0.2*tan(a)*cos(a);
//o=vec4(0.10,0.15,1,0)*mod(floor(p.x)+floor(p.y),2.1)*(2.+sin(a+3.0))+0.1;
//o.a = 1.0;


fragment float4 wavingFlagFragmentFunc(VertexOut vertexIn [[ stage_in ]],
                                       texture2d<float, access::sample> inTexture1 [[texture(0)]],
                                       sampler inSampler1 [[sampler(0)]],
                                       constant float &time [[ buffer(0) ]])
{
    
    float2 xy = vertexIn.textureCoordinate;
//    float2 textureSize = float2(inTexture1.get_width(),inTexture1.get_height());
//    float2 textureCoordinate = vertexIn.textureCoordinate;
//    float2 curCoord = textureCoordinate * textureSize;
//    float z = sin(time);
   
    float2 p = xy/min(inTexture1.get_width(),inTexture1.get_height())*8.0;
    float a=length(p)+time*acos(-1.0)+smoothstep(0.2,0.22,length((p-float2(7.0,4.0)))*.08);
    p+=0.2*tan(a)*cos(a);
    float4 color=float4(0.10,0.15,1,0)*mod(floor(p.x)+floor(p.y),2.1)*(2.+sin(a+3.0))+0.1;
    color  = float4(color.r,color.g,color.b,1.0);
//    float3 currentColor = inTexture1.sample(inSampler1, xy).rgb;
//    float2 resolution = float2(inTexture1.get_width(),inTexture1.get_height());
//    float2 p = (curCoord*2.0 -resolution)/min(resolution.x,resolution.y);
//    float z = 0.5+sin(time*1.5+p.x*2.5)*0.5;
//    p*=1.0+z * 0.1;
//    z=1.0-z;
//    z = 0.7+(z*.85);
//    p.x += time*0.2;
//    float3 col1 = currentColor;
//    float3 col2 = currentColor;
//    float d = step(sin(p.y*20.0)+sin(p.x*20.0),0.0);
    
//    float3 col1 = float3(0.0,1.0,0.0);
//    float3 col2 = float3(1.0,0.0,0.0);
//    float d = step(sin(p.y*20.0)+sin(p.x*20.0),0.0);
//    float4 changeColor = float4(mix(col1,col2,d)*z,1.0);
//    return changeColor ;
    return color;
}
