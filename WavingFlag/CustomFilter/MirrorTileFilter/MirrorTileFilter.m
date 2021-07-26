//
//  MirrorTileFilter.m
//  WavingFlag
//
//  Created by leo on 25/7/21.
//

#import "MirrorTileFilter.h"

@implementation MirrorTileFilter
+ (MTIRenderPipelineKernel *) kernel
{
    static MTIRenderPipelineKernel * kernel;
    if(!kernel){
        NSBundle *bundle = [NSBundle mainBundle];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            kernel = [[MTIRenderPipelineKernel alloc] initWithVertexFunctionDescriptor:[[MTIFunctionDescriptor alloc] initWithName:MTIFilterPassthroughVertexFunctionName]
                                                            fragmentFunctionDescriptor:[[MTIFunctionDescriptor alloc] initWithName:@"mirrorTileFragFunc" libraryURL:[bundle URLForResource:@"default" withExtension:@"metallib"]]
                      ];
        });
    }
    return kernel;
}

- (instancetype)init
{
    self = [super init];
    return self;
}

- (MTIImage *) outputImage
{
    if (self.inputImage == nil) {
        return self.inputImage;
    }
    self.scale = 3.0;
    simd_uint2 tileSize = (simd_uint2){
        (unsigned int)self.inputImage.size.width / self.scale,
        (unsigned int)self.inputImage.size.height / self.scale};
    MTIVector *tileSizeVector = [MTIVector vectorWithUInt2:tileSize];
    
    simd_float2 scale = (simd_float2){
        self.scale, self.scale};
    MTIVector *scaleVector = [MTIVector vectorWithFloat2:scale];
    
    simd_float2 offset = (simd_float2){
        (self.inputImage.size.width / 2.0) + self.offset.x,
        (self.inputImage.size.height / 2.0) + self.offset.y};
    MTIVector *offsetVector = [MTIVector vectorWithFloat2:offset];
    
    self.inputImage = [self.inputImage imageWithSamplerDescriptor:[MTISamplerDescriptor defaultSamplerDescriptorWithAddressMode:MTLSamplerAddressModeClampToEdge]];
    return [self.class.kernel applyToInputImages:@[ self.inputImage ]
                                      parameters:@{
                                          @"tileSize" : tileSizeVector,
                                          @"scale" : scaleVector,
                                          @"offset" : offsetVector,
                                          @"angle" : @(self.angle)
                                      }
                         outputTextureDimensions:MTITextureDimensionsMake2DFromCGSize(self.inputImage.size)
                               outputPixelFormat:self.outputPixelFormat];
    
}
@end
