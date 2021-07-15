//
//  ViewController.m
//  WavingFlag
//
//  Created by leo on 24/12/20.
//

#import "ViewController.h"
#import "WavingFlagFilter.h"

@interface ViewController (){
    dispatch_once_t onceTokenEraseViewLoad;
}
@property (nonatomic, strong) MTIContext *mtiContext;
@property (nonatomic, strong) CIContext *context;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@end

@import  MetalPetal;
CAShapeLayer *shapeLayer;
UIImage *image;
MTIImage *img;


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) didFinishAutoLayout {
    NSError *error;
    self.mtiContext = [[MTIContext alloc] initWithDevice:MTLCreateSystemDefaultDevice() error:&error];
    self.flagImageView.layer.opacity = 0.0;
    self.view.backgroundColor = [UIColor redColor];
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        image = [self takeSnapshot];
        [self useWaveFilter];
    });
}


-(void) useWaveFilter{
    
    WavingFlagFilter *waveFilter = [[WavingFlagFilter alloc] init];
    
    MTIImage *tempImage =[[MTIImage alloc] initWithCGImage:[image CGImage] options:@{MTKTextureLoaderOptionSRGB : @(NO)}];

    tempImage = [tempImage imageByUnpremultiplyingAlpha];
    waveFilter.inputImage =  tempImage;
    MTIImage *image = waveFilter.outputImage;
    
    CIImage *waveFilterCIImage = [self.mtiContext createCIImageFromImage:image error:nil];
    
    self.flagImageView.image = [UIImage imageWithCIImage:waveFilterCIImage];

    
}


#pragma mark - ViewDidLayoutSubviews Called
-(void) viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(didFinishAutoLayout)
                                               object:nil];
    [self performSelector:@selector(didFinishAutoLayout) withObject:nil
               afterDelay:0];
    
}







- (UIImage *)takeSnapshot {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
   
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];

    // old style [self.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.flagImageView.layer.opacity = 1.0;
    return image;
}





@end
