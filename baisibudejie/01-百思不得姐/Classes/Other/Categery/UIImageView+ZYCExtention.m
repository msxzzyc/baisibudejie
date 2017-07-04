//
//  UIImageView+ZYCExtention.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/5.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "UIImageView+ZYCExtention.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (ZYCExtention)
- (UIImageView *)setHeader:(NSString *)url
{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
        
    }];
    return self;
    
}

@end
