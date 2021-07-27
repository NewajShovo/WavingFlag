//
//  tileZoomFilter.metal
//  WavingFlag
//
//  Created by leo on 27/7/21.
//

#include <metal_stdlib>
#include "MTIShaderLib.h"
using namespace metal;
using namespace metalpetal;

//float2 textureSize = float2(inTexture.get_width(), inTexture.get_height());
//float2 textureCoordinate = vertexIn.textureCoordinate;
//float2 position =  textureCoordinate * textureSize;
//position.x -= tileSize.x/2;
//position.y -= tileSize.y/2;
//int2 gridPos = int2(floor(position.x/tileSize.x), floor(position.y/tileSize.y));
//int lowerX = gridPos.x * tileSize.x;
//int lowerY = gridPos.y * tileSize.y;
//float2 pixelPosition = float2(position.x - lowerX, position.y - lowerY);
//pixelPosition.x += (pixelPosition.x < 0) ? tileSize.x : 0;
//pixelPosition.y += (pixelPosition.y < 0) ? tileSize.y : 0;
//pixelPosition.x = (gridPos.x % 2 == 0) ? pixelPosition.x : tileSize.x - pixelPosition.x - 1;
//pixelPosition.y = (gridPos.y % 2 == 0) ? pixelPosition.y : tileSize.y - pixelPosition.y - 1;
//float2 destCoord = (pixelPosition * scale)/textureSize;
//return inTexture.sample(inSampler, destCoord);



fragment float4 tileZoomFilterFragFunc(
                                VertexOut vertexIn [[stage_in]],
                                texture2d<float, access::sample> inTexture [[texture(0)]],
                                sampler inSampler [[sampler(0)]]
                                )
{
    float2 textureCoordinate = vertexIn.textureCoordinate;
    float2 textureSize = float2(inTexture.get_width(),inTexture.get_height());
    float2 position = textureCoordinate*textureSize;
    float height= inTexture.get_height()/1.5;
    float width = inTexture.get_width()/1.5;
    float2 gridSize = float2(width,height);
    float2 scale = float2(1.5,1.5);
    position = (position.x>gridSize.x||position.y>gridSize.y) ? float2(position.x,position.y): position*=scale;
    position/= textureSize;
    return inTexture.sample(inSampler, position);
}
