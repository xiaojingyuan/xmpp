//
//  AppDelegate.h
//  Xmpp24Demo
//
//  Created by xiaojingyuan on 14-7-24.
//  Copyright (c) 2014年 xiaojingyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPFramework.h"
@protocol ChatDelegate;

typedef void(^callbackBlock)(id);
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    callbackBlock _callbackBlock;
    XMPPStream *xmppStream;
    XMPPRoster *xmppRoster;
    XMPPRosterCoreDataStorage *xmppRosterStorage;
    XMPPReconnect *xmppReconnect;
    XMPPMessageArchivingCoreDataStorage *xmppMessageArchivingCoreDataStorage;
    XMPPMessageArchiving *xmppMessageArchivingModule;

}
@property (strong, nonatomic) UIWindow *window;
//---------------------------------------------------------------------
@property (nonatomic, strong) XMPPStream *xmppStream;
@property (nonatomic, strong) XMPPRosterCoreDataStorage *xmppRosterStorage;
@property (nonatomic, strong) XMPPRoster *xmppRoster;
@property (nonatomic, strong) XMPPReconnect *xmppReconnect;
@property (nonatomic, strong) XMPPMessageArchivingCoreDataStorage *xmppMessageArchivingCoreDataStorage;
@property (nonatomic, strong) XMPPMessageArchiving *xmppMessageArchivingModule;

//---------------------------------------------------------------------
@property (nonatomic) BOOL isRegistration;

- (BOOL)myConnect;
- (void)getExistRoomBlock:(callbackBlock)block;
- (void)createReservedRoomWithJID:(NSString *)jid;

- (void)showAlertView:(NSString *)message;

@property (nonatomic,strong) id<ChatDelegate> chatDelegate;

@end

@protocol ChatDelegate <NSObject>

-(void)friendStatusChange:(AppDelegate *)appD Presence:(XMPPPresence *)presence;
-(void)getNewMessage:(AppDelegate *)appD Message:(XMPPMessage *)message;

@end

