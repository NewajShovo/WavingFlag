//
//  overlayFilter.metal
//  WavingFlag
//
//  Created by leo on 26/7/21.
//

#include <metal_stdlib>
#include "MTIShaderLib.h"

//reference: http://glslsandbox.com/e#72454.0

using namespace metal;
using namespace metalpetal;


fragment float4 overLayFragFunc(
                                VertexOut vertexIn [[stage_in]],
                                texture2d<float, access::sample> inTexture [[texture(0)]],
                                texture2d<float, access::sample> inTextureMask [[texture(1)]],
                                sampler inSampler [[sampler(0)]],
                                sampler inSamplerMask [[sampler(1)]]
                                )
{
    float2 textureSize = float2(inTexture.get_width(), inTexture.get_height());
    float2 textureCoordinate = vertexIn.textureCoordinate;
    float4 inputColor = inTexture.sample(inSampler, textureCoordinate);
    float4 maskColor = inTextureMask.sample(inSamplerMask, textureCoordinate);
    float3 color = mix(float3(inputColor.r,inputColor.g,inputColor.b),float3(maskColor.r,maskColor.g,maskColor.b),float3(maskColor.r,maskColor.g,maskColor.b));
    float2 position =  textureCoordinate * textureSize;
    float opacity = sin(position.x);
    return float4(color,opacity);
}
