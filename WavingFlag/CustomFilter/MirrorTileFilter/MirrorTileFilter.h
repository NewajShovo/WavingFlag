//
//  MirrorTileFilter.h
//  WavingFlag
//
//  Created by leo on 25/7/21.
//


#import <UIKit/UIKit.h>
#import <MetalPetal/MetalPetal.h>
NS_ASSUME_NONNULL_BEGIN

@interface MirrorTileFilter : MTIUnaryImageRenderingFilter
@property (nonatomic) float scale;
@property (nonatomic) CGPoint offset;
@property (nonatomic) float angle;
@end

NS_ASSUME_NONNULL_END
