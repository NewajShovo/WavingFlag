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
//pixelPosition.x = (gridPos.x % 2 == 0) ? pixelPosition.x : tileSize.x - pixelPosition.x   - 1;
//pixelPosition.y = (gridPos.y % 2 == 0) ? pixelPosition.y : tileSize.y - pixelPosition.y - 1;
//float2 destCoord = (pixelPosition * scale)/textureSize;
//return inTexture.sample(inSampler, destCoord);



fragment float4 tileZoomFilterFragFunc(
                                VertexOut vertexIn [[stage_in]],
                                texture2d<float, access::sample> inTexture [[texture(0)]],
                                sampler inSampler [[sampler(0)]]
                                )
{
    float2 scale = 1.4;
    float2 textureCoordinate = vertexIn.textureCoordinate;
    float2 textureSize = float2(inTexture.get_width(),inTexture.get_height());
    float2 position = textureCoordinate*textureSize;
    float width = inTexture.get_width()/scale.x;
    float height= inTexture.get_height()/scale.y;
    float2 shiftValue = float2((inTexture.get_width()-width)/2, (inTexture.get_height()-height)/2);
    float2 topLeft = float2(shiftValue.x,shiftValue.y);
    float2 bottomRight = float2(shiftValue.x+width,shiftValue.y+height);
    bool flag;
    flag = ((position.x>topLeft.x&&position.x<bottomRight.x) &&(position.y>topLeft.y&&position.y<bottomRight.y)) ? 1 : 0;
    float2 value = float2(position.x-shiftValue.x, position.y-shiftValue.y);
    position = (flag) ? value*scale : position;
    position/= textureSize;
    return inTexture.sample(inSampler, position);
}
