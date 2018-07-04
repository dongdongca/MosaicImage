//
//  ImageUtils.m
//  OpenCV-简单处理马赛克
//
//  Created by LiDong on 2018/7/3.
//  Copyright © 2018年 LiDong. All rights reserved.
//

#import "ImageUtils.h"

@implementation ImageUtils

+ (UIImage *)openCVImage:(UIImage *)image level:(int)level {
    //1、将iOS图片转换->OpenCV图片（Mat矩阵）
    Mat mat_image_src;
    UIImageToMat(image, mat_image_src);
    
    //2、确定宽高
    int width = mat_image_src.cols;
    int height = mat_image_src.rows;
    
    //3、图片类型转换
    //图片类型->进行转换
    //在OpenCV里面
    //坑隐藏
    //支持->RGB处理
    //图片ARGB
    //将ARGB->RGB
    Mat mat_image_dst;
    cvtColor(mat_image_src, mat_image_dst, CV_RGBA2RGB, 3);
    
    
    //研究OpenCV时候，如何发现巨坑？
    //观察规律
    //看到了OpenCV官方网站->每次进行图像处理时候，规律->每一次都会调用cvtColor保持一致(RGB)
    //所以：每一次你在进行转换的时候，一定要记得转换类型
    
    //为了不影响原图片，clone一个
    Mat mat_image_clone = mat_image_dst.clone();
    
    
    //4、分析马赛克原理
    //分析马赛克算法原理
    //level = 3-> 3 * 3矩形
    //动态的处理
    int x = width - level;
    int y = height - level;
    
    //这样会使整张图片打上马赛克
//    int x = width;
//    int y = height;
    
    for (int i = 0; i < y; i += level) {
        for (int j = 0; j < x; j += level) {
            //创建一个矩形区域（）马赛克区域
            Rect2i mosaicRect = Rect2i(j, i, level, level);
            
            //给mosaicRect区域->添加数据->原始数据
            Mat roi = mat_image_dst(mosaicRect);
            
            //让整个区域保持同一个颜色
            //mat_image_clone.at<Vec3b>(i, j)->像素点（颜色值组成->多个）->ARGB->数组
            //mat_image_clone.at<Vec3b>(i, j)[0]->R值
            //mat_image_clone.at<Vec3b>(i, j)[1]->G值
            //mat_image_clone.at<Vec3b>(i, j)[2]->B值
            Scalar scalar = Scalar(
                                   mat_image_clone.at<Vec3b>(i, j)[0],
                                   mat_image_clone.at<Vec3b>(i, j)[1],
                                   mat_image_clone.at<Vec3b>(i, j)[2]);
            
            //将处理好矩形区域->数据->拷贝到图片上面去->修改后的数据
            //CV_8UC3解释一下->后面也会讲到
            //CV_:表示框架命名空间
            //8表示：32位色->ARGB->8位 = 1字节 -> 4个字节
            //U分析
            //两种类型：有符号类型(Sign->有正负->简写"S")、无符号类型(Unsign->正数->"U")
            //无符号类型：0-255(通常情况)
            //有符号类型：-128-127
            //C分析：char类型
            //3表示：3个通道->RGB
            Mat roiCopy = Mat(mosaicRect.size(), CV_8UC3, scalar);
            roiCopy.copyTo(roi);
        }
    }
    //第四步：将OpenCV图片->iOS图片
    return MatToUIImage(mat_image_dst);
}

@end
