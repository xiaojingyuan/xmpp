//
//  ChatViewController.h
//  Xmpp24Demo
//
//  Created by xiaojingyuan on 14-7-24.
//  Copyright (c) 2014年 xiaojingyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPFramework.h"
#import "AppDelegate.h"

@interface ChatViewController : UIViewController<ChatDelegate>
{
    
    __weak IBOutlet UITextView *contextTextView;
    __weak IBOutlet UITextField *sendTextField;
}
@property (strong,nonatomic) XMPPUserCoreDataStorageObject * userobject;
@property (strong,nonatomic) NSMutableArray *dataArray;
@end
