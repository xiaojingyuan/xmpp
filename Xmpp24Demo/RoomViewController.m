//
//  RoomViewController.m
//  Xmpp24Demo
//
//  Created by xiaojingyuan on 14-8-4.
//  Copyright (c) 2014年 xiaojingyuan. All rights reserved.
//

#import "RoomViewController.h"
#import "AppDelegate.h"
@interface RoomViewController ()

@end

@implementation RoomViewController
{
    NSMutableArray           *_roomArray;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (AppDelegate *)appDelegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"房间";
    _roomTableView.delegate =self;
    _roomTableView.dataSource = self;
    [[self appDelegate] getExistRoomBlock:^(id result) {
        XMPPIQ *iq = (XMPPIQ *)result;
        NSLog(@"111======%@",iq);
        _roomArray = [NSMutableArray array];
        for (DDXMLElement *element in iq.children) {
            NSLog(@"ele=======%@",element);
            if ([element.name isEqualToString:@"query"]) {
                for (DDXMLElement *item in element.children) {
                    if ([item.name isEqualToString:@"item"]) {
                        [_roomArray addObject:item.attributes];
                    }
                }
            }
        }
        NSLog(@"====%@",_roomArray);

        [_roomTableView reloadData];
    }];

}
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _roomArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"roomcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"roomcell"];
    }
    NSArray *array = [_roomArray objectAtIndex:indexPath.row];
    NSLog(@"array====%@",array);
    cell.textLabel.text =[array objectAtIndex:0];
    cell.detailTextLabel.text = [array objectAtIndex:1];
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
