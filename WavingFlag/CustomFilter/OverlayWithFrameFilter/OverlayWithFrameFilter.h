//
//  OverlayWithFrame.h
//  WavingFlag
//
//  Created by leo on 26/7/21.
//

#import <MetalPetal/MetalPetal.h>

NS_ASSUME_NONNULL_BEGIN

@interface OverlayWithFrameFilter : MTIUnaryImageRenderingFilter
@property (nonatomic, strong) MTIImage *frameImage;
@end

NS_ASSUME_NONNULL_END
