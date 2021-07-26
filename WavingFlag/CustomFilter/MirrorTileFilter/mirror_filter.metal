#include <metal_stdlib>
#include "MTIShaderLib.h"

//reference: http://glslsandbox.com/e#72454.0

using namespace metal;
using namespace metalpetal;


fragment float4 mirrorTileFragFunc(
                                   VertexOut vertexIn [[stage_in]],
                                   texture2d<float, access::sample> inTexture [[texture(0)]],
                                   sampler inSampler [[sampler(0)]],
                                   constant uint2 &tileSize [[ buffer(0) ]],
                                   constant float2 &scale [[ buffer(1) ]],
                                   constant float2 &offset [[ buffer(2) ]],
                                   constant float &angle [[ buffer(3) ]]
                                   )
{
    float2 textureSize = float2(inTexture.get_width(), inTexture.get_height());
    float2 textureCoordinate = vertexIn.textureCoordinate;
    float2 position =  textureCoordinate * textureSize;
    position.x -= tileSize.x/2;
    position.y -= tileSize.y/2;
    int2 gridPos = int2(floor(position.x/tileSize.x), floor(position.y/tileSize.y));
    int lowerX = gridPos.x * tileSize.x;
    int lowerY = gridPos.y * tileSize.y;
    float2 pixelPosition = float2(position.x - lowerX, position.y - lowerY);
    pixelPosition.x += (pixelPosition.x < 0) ? tileSize.x : 0;
    pixelPosition.y += (pixelPosition.y < 0) ? tileSize.y : 0;
    pixelPosition.x = (gridPos.x % 2 == 0) ? pixelPosition.x : tileSize.x - pixelPosition.x - 1;
    pixelPosition.y = (gridPos.y % 2 == 0) ? pixelPosition.y : tileSize.y - pixelPosition.y - 1;
    float2 destCoord = (pixelPosition * scale)/textureSize;
    return inTexture.sample(inSampler, destCoord);
}

