//
//  ZYCVoiceViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/11.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCVoiceViewController.h"

@interface ZYCVoiceViewController ()

@end

@implementation ZYCVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化表格
    [self setUpTableView];
    
    
    
}
//初始化表格
- (void)setUpTableView
{
    //    设置内边距
    CGFloat top = ZYCTitlesViewY + ZYCTitlesViewH;
    CGFloat bottom = self.view.height - self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        return cell;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@----%zd",[self class],indexPath.row];
    return cell;
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
