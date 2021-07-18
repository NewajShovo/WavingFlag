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
    float3 currentColor = inTexture1.sample(inSampler1, xy).rgb;
    const float PI = 3.1415926535;
    float w = sin((curCoord.x + curCoord.y - 10 * .5 + sin(1.5 * curCoord.x + 4.5 * curCoord.y) * PI * .3) * PI * .6); // fake waviness factor
    float3 col = float3(currentColor.r,currentColor.g,currentColor.b);
    col += w * .12;

    float4 changedColor = float4(col,1.0);
    return changedColor;
}

/*
 Luminance example code
 float2 xy = vertexIn.textureCoordinate;
 
 float2 widthStep = float2(inTexture1.get_width(), 0.0);
 float2 heightStep = float2(0.0, inTexture1.get_height());
 
 float2 leftXY = xy - widthStep;
 float2 rightXY = xy + widthStep;
 float2 bottomXY = xy - heightStep;
 float2 topXY = xy + heightStep;
 
 float3 currentColor = inTexture1.sample(inSampler1, xy).rgb;
 float3 leftColor = inTexture1.sample(inSampler1, leftXY).rgb;
 float3 rightColor = inTexture1.sample(inSampler1, rightXY).rgb;
 float3 bottomColor = inTexture1.sample(inSampler1, bottomXY).rgb;
 float3 topColor = inTexture1.sample(inSampler1, topXY).rgb;
 
 float centerMultiplier = 1.0 + 4.0 * 10;
 float edgeMultiplier = 10;
 
 return float4(currentColor * centerMultiplier - (leftColor * edgeMultiplier + rightColor * edgeMultiplier + bottomColor * edgeMultiplier + topColor * edgeMultiplier), 1);
 */
