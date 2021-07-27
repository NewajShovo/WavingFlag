//
//  OverlayWithAlphaFilter.h
//  WavingFlag
//
//  Created by leo on 27/7/21.
//

#import <MetalPetal/MetalPetal.h>

NS_ASSUME_NONNULL_BEGIN

@interface OverlayWithAlphaFilter : MTIUnaryImageRenderingFilter
@property (nonatomic, strong) MTIImage *alphaImage;
@end

NS_ASSUME_NONNULL_END
