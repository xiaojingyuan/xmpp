//
//  ViewController.h
//  Xmpp24Demo
//
//  Created by xiaojingyuan on 14-7-24.
//  Copyright (c) 2014年 xiaojingyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPRoomMemoryStorage.h"
@interface ViewController : UIViewController<XMPPRoomMemoryStorageDelegate>
{
    
    __weak IBOutlet UITextField *_passField;
    __weak IBOutlet UITextField *_nameField;
    __weak IBOutlet UITextField *_roomField;
}
@end
