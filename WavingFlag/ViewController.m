//
//  ViewController.m
//  WavingFlag
//
//  Created by leo on 24/12/20.
//

#import "ViewController.h"
#import "WavingFlagFilter.h"
#import "MirrorTileFilter.h"
#import "OverLayFilter.h"
#import "OverlayWithFrameFilter.h"
#import "OverlayWithAlphaFilter.h"
#import "TileZoomFilter.h"

@interface ViewController (){
    dispatch_once_t onceTokenViewLoad;
    MTIImage *tempImage, *tempImage1;
    WavingFlagFilter *waveFilter;
    MirrorTileFilter *mirrorTileFilter;
    OverLayFilter *overlayFilter;
    OverlayWithFrameFilter *overlayWithFrameFilter;
    OverlayWithAlphaFilter *overlayWithAlphaFilter;
    TileZoomFilter *tileZoomFilter;
    
}
@property (nonatomic, strong) MTIContext *mtiContext;
@property (nonatomic, strong) CIContext *context;
@property (weak, nonatomic) IBOutlet MTIImageView *mtiImageView;
@end

@import  MetalPetal;
CAShapeLayer *shapeLayer;
UIImage *image;


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor = [UIColor redColor].CGColor;
}

- (void) didFinishAutoLayout {
    dispatch_once(&onceTokenViewLoad, ^{
        NSError *error;
        self.mtiContext = [[MTIContext alloc] initWithDevice:MTLCreateSystemDefaultDevice() error:&error];
        shapeLayer = [CAShapeLayer layer];
        // Do any additional setup after loading the view.
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [path appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake((self.view.frame.size.width/2)-140, (self.view.frame.size.height)/2-140, 280, 280)]];
        shapeLayer.fillColor = [UIColor colorWithRed:0/255.0f green:100.0/255.0f blue:0/255.0f alpha:1.0].CGColor;
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        shapeLayer.fillRule = kCAFillRuleEvenOdd;
        shapeLayer.lineWidth = 0.0;
        [self.view.layer addSublayer:shapeLayer];
//        image = [self takeSnapshot];
//        image = [UIImage imageNamed:@"IMG_2025.PNG"];
//        image = [UIImage imageNamed:@"IMG_1805.JPG"];
//        image = [UIImage imageNamed:@"potrait9.JPG"];
        image = [UIImage imageNamed:@"potrait7.JPG"];
//        image = [UIImage imageNamed:@"Image.png"];
        self.view.backgroundColor = [UIColor clearColor];
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.mtiImageView.layer.hidden = NO;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                [self useWaveFilter];
//                [self useMirrorTileFilter];
//                [self useOverlayFilter];
//                [self useOverlayWithFrameFilter];
//                [self useOverlayWithAlphaFilter];
                [self useTileZoomFilter];
            });
        });
    });
}


-(void) useWaveFilter{
    tempImage =[[MTIImage alloc] initWithCGImage:[image CGImage] options:@{MTKTextureLoaderOptionSRGB : @(NO)}];
    tempImage = [tempImage imageByUnpremultiplyingAlpha];
    waveFilter = [[WavingFlagFilter alloc] init];
    while(true){
        dispatch_async(dispatch_get_main_queue(), ^{
            self->waveFilter.inputImage =  self->tempImage;
            self.mtiImageView.image = self->waveFilter.outputImage;
        });
    }
}

-(void) useMirrorTileFilter{
    tempImage =[[MTIImage alloc] initWithCGImage:[image CGImage] options:@{MTKTextureLoaderOptionSRGB : @(NO)}];
    tempImage = [tempImage imageByUnpremultiplyingAlpha];
    mirrorTileFilter = [[MirrorTileFilter alloc] init];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mtiImageView.image = self->tempImage;
        self->mirrorTileFilter.inputImage = self->tempImage;
        self.mtiImageView.image = self->mirrorTileFilter.outputImage;
    });
}

-(void) useOverlayWithFrameFilter{
    tempImage =[[MTIImage alloc] initWithCGImage:[image CGImage] options:@{MTKTextureLoaderOptionSRGB : @(NO)}];
    tempImage = [tempImage imageByUnpremultiplyingAlpha];
    UIImage *backGroundImage = [UIImage imageNamed:@"bcm_test_filter_frame_sample.png"];
    tempImage1 = [[MTIImage alloc] initWithCGImage:[backGroundImage CGImage] options:@{MTKTextureLoaderOptionSRGB : @(NO)}];
    tempImage1 = [tempImage1 imageByUnpremultiplyingAlpha];
    overlayWithFrameFilter = [[OverlayWithFrameFilter alloc] init];
    overlayWithFrameFilter.inputImage = tempImage;
    overlayWithFrameFilter.frameImage = tempImage1;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mtiImageView.image = self->tempImage;
        
        self.mtiImageView.image = self->overlayWithFrameFilter.outputImage;
    });
}

-(void) useOverlayFilter{
    tempImage =[[MTIImage alloc] initWithCGImage:[image CGImage] options:@{MTKTextureLoaderOptionSRGB : @(NO)}];
    tempImage = [tempImage imageByUnpremultiplyingAlpha];
    UIImage *backGroundImage = [UIImage imageNamed:@"bcm_test_filter_frame_sample.png"];
    tempImage1 = [[MTIImage alloc] initWithCGImage:[backGroundImage CGImage] options:@{MTKTextureLoaderOptionSRGB : @(NO)}];
    tempImage1 = [tempImage1 imageByUnpremultiplyingAlpha];
    overlayFilter = [[OverLayFilter alloc] init];
    overlayFilter.inputImage = tempImage;
    overlayFilter.overlayMaskImage = tempImage1;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mtiImageView.image = self->tempImage;
        
        self.mtiImageView.image = self->overlayFilter.outputImage;
    });
}


-(void) useOverlayWithAlphaFilter{
    tempImage =[[MTIImage alloc] initWithCGImage:[image CGImage] options:@{MTKTextureLoaderOptionSRGB : @(NO)}];
    tempImage = [tempImage imageByUnpremultiplyingAlpha];
    UIImage *backGroundImage = [UIImage imageNamed:@"filter1.darken.png"];
    tempImage1 = [[MTIImage alloc] initWithCGImage:[backGroundImage CGImage] options:@{MTKTextureLoaderOptionSRGB : @(NO)}];
    tempImage1 = [tempImage1 imageByUnpremultiplyingAlpha];
    overlayWithAlphaFilter = [[OverlayWithAlphaFilter alloc] init];
    overlayWithAlphaFilter.inputImage = tempImage;
    overlayWithAlphaFilter.alphaImage = tempImage1;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mtiImageView.image = self->tempImage;
        self.mtiImageView.image = self->overlayWithAlphaFilter.outputImage;
    });
}

-(void) useTileZoomFilter{
    tempImage =[[MTIImage alloc] initWithCGImage:[image CGImage] options:@{MTKTextureLoaderOptionSRGB : @(NO)}];
    tempImage = [tempImage imageByUnpremultiplyingAlpha];
    tileZoomFilter = [[TileZoomFilter alloc] init];
    tileZoomFilter.inputImage = tempImage;

    dispatch_async(dispatch_get_main_queue(), ^{
        self.mtiImageView.image = self->tempImage;
        self.mtiImageView.image = self->tileZoomFilter.outputImage;
    });
}


#pragma mark - ViewDidLayoutSubviews Called
-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.mtiImageView.layer.hidden = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(didFinishAutoLayout)
                                               object:nil];
    [self performSelector:@selector(didFinishAutoLayout) withObject:nil
               afterDelay:0];
    
}

- (UIImage *)takeSnapshot {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
