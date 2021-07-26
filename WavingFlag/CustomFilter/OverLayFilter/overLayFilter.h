//
//  overLayFilter.h
//  WavingFlag
//
//  Created by leo on 26/7/21.
//

#import <MetalPetal/MetalPetal.h>

NS_ASSUME_NONNULL_BEGIN

@interface overLayFilter : MTIUnaryImageRenderingFilter
//@property (nonatomic) float scale;
//@property (nonatomic) CGPoint offset;
//@property (nonatomic) float angle;
@property (nonatomic, strong) MTIImage *overlayMaskImage;
@end

NS_ASSUME_NONNULL_END
