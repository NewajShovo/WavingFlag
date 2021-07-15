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
                                      sampler inSampler1 [[sampler(0)]])
{

    float2 xy = vertexIn.textureCoordinate;
    float4 currentColor = inTexture1.sample(inSampler1, xy);
    currentColor.r -= 0.5;
//    currentColor.g -= 0.5;
//    currentColor.b -= 0.5;
//    currentColor.a = 0.0;

//    float height = inTexture1.get_height();
//    float width = inTexture1.get_width();

    return currentColor;
}
