//
//  ViewController.m
//  OpenCV-简单处理马赛克
//
//  Created by LiDong on 2018/7/3.
//  Copyright © 2018年 LiDong. All rights reserved.
//

#import "ImageUtils.h"
#import "ViewController.h"

//需要自己下载OpenCV的包，拖进来即可运行

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)showOriginalImageAction:(id)sender {
    self.imageView.image = [UIImage imageNamed:@"iconviewimage.jpg"];
}
- (IBAction)showMosaicImageAction:(id)sender {
    self.imageView.image = [ImageUtils openCVImage:self.imageView.image level:20];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
