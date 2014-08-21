//
//  RoomViewController.h
//  Xmpp24Demo
//
//  Created by xiaojingyuan on 14-8-4.
//  Copyright (c) 2014年 xiaojingyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    __weak IBOutlet UITableView *_roomTableView;
}
@end
