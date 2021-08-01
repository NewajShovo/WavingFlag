//
//  WavingFlagFilter.m
//  WavingFlag
//
//  Created by leo on 24/12/20.
//

#import "WavingFlagFilter.h"

@interface WavingFlagFilter (){
    CGFloat startTime;
}
@end

@implementation WavingFlagFilter

+ (MTIRenderPipelineKernel *) kernel
{
    static MTIRenderPipelineKernel * kernel;
    if(!kernel){
        NSBundle *bundle = [NSBundle mainBundle];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            kernel = [[MTIRenderPipelineKernel alloc] initWithVertexFunctionDescriptor:[[MTIFunctionDescriptor alloc] initWithName:MTIFilterPassthroughVertexFunctionName]
                                                            fragmentFunctionDescriptor:[[MTIFunctionDescriptor alloc] initWithName:@"wavingFlagFragmentFunc" libraryURL:[bundle URLForResource:@"default" withExtension:@"metallib"]]
                      ];
        });
    }
    return kernel;
}

- (instancetype)init
{
    self = [super init];
    startTime = CFAbsoluteTimeGetCurrent();
    return self;
}

- (MTIImage *) outputImage
{
    
    float timeValue =CFAbsoluteTimeGetCurrent()-startTime;
    timeValue = sin(timeValue);
    return [self.class.kernel applyToInputImages:@[ self.inputImage ]
                                      parameters:@{
                                          @"time" : @(timeValue)
                                      }
                         outputTextureDimensions:MTITextureDimensionsMake2DFromCGSize(self.inputImage.size)
                               outputPixelFormat:self.outputPixelFormat];
    
}
@end
