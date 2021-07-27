//
//  TileZoomFilter.m
//  WavingFlag
//
//  Created by leo on 27/7/21.
//

#import "TileZoomFilter.h"

@implementation TileZoomFilter
+ (MTIRenderPipelineKernel *) kernel
{
    static MTIRenderPipelineKernel * kernel;
    if(!kernel){
        NSBundle *bundle = [NSBundle mainBundle];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            kernel = [[MTIRenderPipelineKernel alloc] initWithVertexFunctionDescriptor:[[MTIFunctionDescriptor alloc] initWithName:MTIFilterPassthroughVertexFunctionName]
                                                            fragmentFunctionDescriptor:[[MTIFunctionDescriptor alloc] initWithName:@"tileZoomFilterFragFunc" libraryURL:[bundle URLForResource:@"default" withExtension:@"metallib"]]
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
    self.inputImage = [self.inputImage imageWithSamplerDescriptor:[MTISamplerDescriptor defaultSamplerDescriptorWithAddressMode:MTLSamplerAddressModeClampToEdge]];
    return [self.class.kernel applyToInputImages:@[ self.inputImage]
                                      parameters:@{
                                      }
                         outputTextureDimensions:MTITextureDimensionsMake2DFromCGSize(self.inputImage.size)
                               outputPixelFormat:self.outputPixelFormat];
    
}
@end
