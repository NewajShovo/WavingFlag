//
//  OverlayWithAlphaFilter.m
//  WavingFlag
//
//  Created by leo on 27/7/21.
//

#import "OverlayWithAlphaFilter.h"

@implementation OverlayWithAlphaFilter
+ (MTIRenderPipelineKernel *) kernel
{
    static MTIRenderPipelineKernel * kernel;
    if(!kernel){
        NSBundle *bundle = [NSBundle mainBundle];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            kernel = [[MTIRenderPipelineKernel alloc] initWithVertexFunctionDescriptor:[[MTIFunctionDescriptor alloc] initWithName:MTIFilterPassthroughVertexFunctionName]
                                                            fragmentFunctionDescriptor:[[MTIFunctionDescriptor alloc] initWithName:@"overLayWithAlphaFragFunc" libraryURL:[bundle URLForResource:@"default" withExtension:@"metallib"]]
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
    return [self.class.kernel applyToInputImages:@[ self.inputImage, self.alphaImage ]
                                      parameters:@{
                                      }
                         outputTextureDimensions:MTITextureDimensionsMake2DFromCGSize(self.inputImage.size)
                               outputPixelFormat:self.outputPixelFormat];
    
}
@end
