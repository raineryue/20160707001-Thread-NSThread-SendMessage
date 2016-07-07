//
//  ViewController.m
//  20160707001-Thread-NSThread-SendMessage
//
//  Created by Rainer on 16/7/7.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/** 图片显示视图 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 异步线程中开启下载图片请求
//    [self performSelectorInBackground:@selector(showDownLoadImage01) withObject:nil];
//    [self performSelectorInBackground:@selector(showDownLoadImage02) withObject:nil];
    [self performSelectorInBackground:@selector(showDownLoadImage03) withObject:nil];
}

/**
 *  第一种方法显示下载的图片
 */
- (void)showDownLoadImage01 {
    // 获取下载图片
    UIImage *image = [self downLoadImageFunction01];
    
    // 回到主线程显示图片
    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:YES];
}

/**
 *  第二种方法显示下载的图片
 */
- (void)showDownLoadImage02 {
    // 获取下载图片
    UIImage *image = [self downLoadImageFunction02];
    
    // 掉用图片视图的回到主线程方法显示图片(这里直接掉用了UIImageView的setImage方法)
    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
}

/**
 *  第二种方法显示下载的图片
 */
- (void)showDownLoadImage03 {
    // 获取下载图片
    UIImage *image = [self downLoadImageFunction02];
    
    // 掉用图片视图的回到主线程方法显示图片(这里直接掉用了UIImageView的setImage方法)
    [self.imageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
}

/**
 *  下载图片（第一种打印下载时间的方式）
 */
- (UIImage *)downLoadImageFunction01 {
    // 创建图片地址
    NSURL *imageUrl = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/zhidao/pic/item/38dbb6fd5266d0163e620ee5962bd40734fa3587.jpg"];
    
    // 获取当前时间（以秒数返回）
    CFTimeInterval beginTime = CFAbsoluteTimeGetCurrent();
    
    // 下载图片
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    
    // 获取当前时间（以秒数返回）
    CFTimeInterval endTime = CFAbsoluteTimeGetCurrent();
    
    NSLog(@"==========================>下载图片共花费[%f]秒.", endTime - beginTime);
    
    return image;
}

/**
 *  下载图片（第二种打印下载时间的方式）
 */
- (UIImage *)downLoadImageFunction02 {
    // 创建图片地址
    NSURL *imageUrl = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/zhidao/pic/item/38dbb6fd5266d0163e620ee5962bd40734fa3587.jpg"];
    
    // 获取当前日期时间
    NSDate *beginDate = [NSDate date];
    
    // 下载图片
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    
    // 获取当前日期时间
    NSDate *endDate = [NSDate date];
    
    NSLog(@"==========================>下载图片共花费[%f]秒.", [endDate timeIntervalSinceDate:beginDate]);
    
    return image;
}

/**
 *  显示已下载的图片
 */
- (void)showImage:(UIImage *)image {
    self.imageView.image = image;
}

@end
