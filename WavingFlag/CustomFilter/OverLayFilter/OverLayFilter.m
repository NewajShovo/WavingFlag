//
//  overLayFilter.m
//  WavingFlag
//
//  Created by leo on 26/7/21.
//

#import "OverLayFilter.h"

@implementation OverLayFilter
+ (MTIRenderPipelineKernel *) kernel
{
    static MTIRenderPipelineKernel * kernel;
    if(!kernel){
        NSBundle *bundle = [NSBundle mainBundle];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            kernel = [[MTIRenderPipelineKernel alloc] initWithVertexFunctionDescriptor:[[MTIFunctionDescriptor alloc] initWithName:MTIFilterPassthroughVertexFunctionName]
                                                            fragmentFunctionDescriptor:[[MTIFunctionDescriptor alloc] initWithName:@"overLayFragFunc" libraryURL:[bundle URLForResource:@"default" withExtension:@"metallib"]]
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
    return [self.class.kernel applyToInputImages:@[ self.inputImage, self.overlayMaskImage ]
                                      parameters:@{
                                      }
                         outputTextureDimensions:MTITextureDimensionsMake2DFromCGSize(self.inputImage.size)
                               outputPixelFormat:self.outputPixelFormat];
    
}
@end
