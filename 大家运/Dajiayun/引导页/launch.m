//
//  launch.m
//  登陆
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "launch.h"
#import "XGConst.h"

@interface launch()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation launch

- (void)loadLaunchImage:(NSString *)imageName bgimage:(NSString *)bgName {
    
    self.bgImageView = [[UIImageView alloc] initWithFrame:SCREEN_BOUNDS];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.8)];
    
    self.bgImageView.image = [UIImage imageNamed:bgName];
    
    self.imageView.image = [UIImage imageNamed:imageName];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self.bgImageView];
    
    [window addSubview:self.imageView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.bgImageView removeFromSuperview];
        
        [self.imageView removeFromSuperview];
        
    });

}


@end
