//
//  overlayWithFrameFilter.metal
//  WavingFlag
//
//  Created by leo on 26/7/21.
//

#include <metal_stdlib>
#include "MTIShaderLib.h"
using namespace metal;
using namespace metalpetal;


fragment float4 overLayWithFrameFragFunc(
                                VertexOut vertexIn [[stage_in]],
                                texture2d<float, access::sample> inTexture [[texture(0)]],
                                texture2d<float, access::sample> inTextureMask [[texture(1)]],
                                sampler inSampler [[sampler(0)]],
                                sampler inSamplerMask [[sampler(1)]]
                                )
{
    float2 textureCoordinate = vertexIn.textureCoordinate;
    float4 inputColor = inTexture.sample(inSampler, textureCoordinate);
    float4 maskColor = inTextureMask.sample(inSamplerMask, textureCoordinate);
    float4 color;
    float opacity = 1-maskColor.a;
    color = (opacity< 0.001) ? maskColor : inputColor;
    return color;

}
