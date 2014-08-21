//
//  FriendsListViewController.m
//  Xmpp24Demo
//
//  Created by xiaojingyuan on 14-7-24.
//  Copyright (c) 2014年 xiaojingyuan. All rights reserved.
//

#import "FriendsListViewController.h"
#import "ChatViewController.h"
@interface FriendsListViewController ()

@end

@implementation FriendsListViewController

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
    AppDelegate *delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.chatDelegate = self;
	return delegate;
}
- (void)getData{
    NSManagedObjectContext *context = [[[self appDelegate] xmppRosterStorage] mainThreadManagedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPUserCoreDataStorageObject" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entity];
    NSError *error ;
    NSArray *friends = [context executeFetchRequest:request error:&error];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:friends];
    NSLog(@"11111=======%@",self.dataArray);
//    XMPPUserCoreDataStorageObject * objec =[self.dataArray objectAtIndex:0];
//    NSLog(@"22222====%@====%@==%@",objec,[objec displayName],[[[objec primaryResource]presence]status]);
//    [_friendTableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _friendTableView.delegate = self;
    _friendTableView.dataSource = self;
    self.title = [[[[self appDelegate]xmppStream]myJID]bare];
    self.dataArray = [[NSMutableArray alloc]init];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.backgroundColor = [UIColor redColor];
    XMPPUserCoreDataStorageObject * objec =[self.dataArray objectAtIndex:indexPath.row];
    NSLog(@"cell=======%@====%@",self.dataArray,objec);
    NSString *name = [objec displayName];
    if (!name) {
        name = [objec nickname];
    }
    if (!name)
    {
        name = [objec jidStr];
    }
    cell.textLabel.text = [objec displayName];
    cell.detailTextLabel.text = [[[objec primaryResource]presence]status];
    cell.tag = indexPath.row;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatViewController *c = [[ChatViewController alloc]init];
    c.userobject = [self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:c animated:YES];
}
#pragma mark - Chat Delegate
-(void)friendStatusChange:(AppDelegate *)appD Presence:(XMPPPresence *)presence
{
    for (XMPPUserCoreDataStorageObject *object in self.dataArray) {
        if ([object.jidStr isEqualToString:presence.fromStr] || [object.jidStr isEqualToString:presence.from.bare]) {
            [[[[object primaryResource] presence] childAtIndex:0] setStringValue:presence.status];
        }
    }
    [_friendTableView reloadData];
}
-(void)getNewMessage:(AppDelegate *)appD Message:(XMPPMessage *)message
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
