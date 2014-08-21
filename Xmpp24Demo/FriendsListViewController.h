//
//  FriendsListViewController.h
//  Xmpp24Demo
//
//  Created by xiaojingyuan on 14-7-24.
//  Copyright (c) 2014年 xiaojingyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface FriendsListViewController : UIViewController<ChatDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    __weak IBOutlet UITableView *_friendTableView;
}
@property (strong,nonatomic)NSMutableArray * dataArray;
@end
