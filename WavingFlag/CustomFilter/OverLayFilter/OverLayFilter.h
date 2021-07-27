//
//  overLayFilter.h
//  WavingFlag
//
//  Created by leo on 26/7/21.
//

#import <MetalPetal/MetalPetal.h>

NS_ASSUME_NONNULL_BEGIN

@interface OverLayFilter : MTIUnaryImageRenderingFilter
@property (nonatomic, strong) MTIImage *overlayMaskImage;
@end

NS_ASSUME_NONNULL_END
