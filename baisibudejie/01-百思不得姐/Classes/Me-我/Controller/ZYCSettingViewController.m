//
//  ZYCSettingViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/29.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCSettingViewController.h"
#import "SDImageCache.h"
@interface ZYCSettingViewController ()

@end

@implementation ZYCSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.view.backgroundColor = ZYCGlobalBG;
    
    

}
- (void)getSizes
{
    //图片缓存
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    ZYCLog(@"%zd %@",size,NSTemporaryDirectory());
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    //获得文件夹内部的所有内容
    //    NSArray *contents = [manager contentsOfDirectoryAtPath:cachePath error:nil];//不能获取子路径
    NSArray *subPaths = [manager subpathsAtPath:cachePath];
}
- (void)getSize
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    //遍历文件
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:cachePath];
    NSInteger totalSize = 0;
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        
        //        BOOL dir = NO;
        //        //判断文件的类型：文件、文件夹
        //        [manager fileExistsAtPath:filePath isDirectory:&dir];
        //        if (dir) continue;
        //        NSInteger size = [[manager attributesOfItemAtPath:filePath error:nil][NSFileSize] integerValue];
        //        totalSize += size;
        
        NSDictionary *attrs = [manager attributesOfItemAtPath:filePath error:nil];
        if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
        totalSize += [attrs[NSFileSize] integerValue];
    }
    
    ZYCLog(@"%zd",totalSize);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    CGFloat size = [SDImageCache sharedImageCache].getSize/1000.0/1000;
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存（已使用%.2fMB",size];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [NSFileManager defaultManager] removeItemAtPath: error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>
    [[SDImageCache sharedImageCache] clearDisk];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
