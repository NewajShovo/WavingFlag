//
//  TileZoomFilter.h
//  WavingFlag
//
//  Created by leo on 27/7/21.
//

#import <MetalPetal/MetalPetal.h>

NS_ASSUME_NONNULL_BEGIN

@interface TileZoomFilter : MTIUnaryImageRenderingFilter
@property (nonatomic,strong) MTIImage *originalImage;

@end

NS_ASSUME_NONNULL_END
