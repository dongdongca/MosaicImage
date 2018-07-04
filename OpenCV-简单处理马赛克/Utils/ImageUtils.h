//
//  ImageUtils.h
//  OpenCV-简单处理马赛克
//
//  Created by LiDong on 2018/7/3.
//  Copyright © 2018年 LiDong. All rights reserved.
//



//倒入OpenCV框架
//核心头文件
#import <opencv2/opencv.hpp>
//对iOS支持
#import <opencv2/imgcodecs/ios.h>
//导入矩阵帮助类
#import <opencv2/highgui.hpp>
#import <opencv2/core/types.hpp>

#import <UIKit/UIKit.h>

//导入C++的命名空间
using namespace cv;

@interface ImageUtils : NSObject

+ (UIImage *)openCVImage:(UIImage *)image level:(int)level;

@end
