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


fragment float4 tileZoomFilterFragFunc(
                                       VertexOut vertexIn [[stage_in]],
                                       texture2d<float, access::sample> inTexture [[texture(0)]],
                                       texture2d<float, access::sample> inTexture1 [[texture(1)]],
                                       sampler inSampler [[sampler(0)]],
                                       sampler inSampler1 [[sampler(1)]]
                                       )
{
    float2 scale = 2;
    float2 scale1 = 1.35;
    float2 textureCoordinate = vertexIn.textureCoordinate;
    float2 textureSize = float2(inTexture.get_width(),inTexture.get_height());
    float2 position = textureCoordinate*textureSize;
    
    float width = inTexture.get_width()/scale.x;
    float width1 = inTexture.get_width()/scale1.x;
    
    float height= inTexture.get_height()/scale.y;
    float height1= inTexture.get_height()/scale1.y;
    
    float2 shiftValue = float2((inTexture.get_width()-width)/2, (inTexture.get_height()-height)/2);
    float2 shiftValue1 = float2((inTexture.get_width()-width1)/2, (inTexture.get_height()-height1)/2);
    
    
    float2 topLeft = float2(shiftValue.x,shiftValue.y);
    float2 topLeft1 = float2(shiftValue1.x,shiftValue1.y);
     
    float2 bottomRight = float2(shiftValue.x+width,shiftValue.y+height);
    float2 bottomRight1 = float2(shiftValue1.x+width1,shiftValue1.y+height1);
    bool flag= false,flag1 = false;

    flag = ((position.x>topLeft.x&&position.x<bottomRight.x) &&(position.y>topLeft.y&&position.y<bottomRight.y)) ? 1 : 0;
    
    flag1 = ((position.x>topLeft1.x&&position.x<bottomRight1.x) &&(position.y>topLeft1.y&&position.y<bottomRight1.y)) ? 1 : 0;
    
    float2 value = float2(position.x-shiftValue.x, position.y-shiftValue.y);
    float2 value1 = float2(position.x-shiftValue1.x, position.y-shiftValue1.y);
    position = (flag&&flag1) ? value*scale : position;
    position = (flag1&&!flag) ? value1*scale1 : position;
    position/= textureSize;
    if(!flag&&!flag1)return inTexture.sample(inSampler, position);
    return inTexture1.sample(inSampler1, position);
}

