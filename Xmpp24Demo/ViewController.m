//
//  ViewController.m
//  Xmpp24Demo
//
//  Created by xiaojingyuan on 14-7-24.
//  Copyright (c) 2014年 xiaojingyuan. All rights reserved.
//
#import "ViewController.h"
#import "AppDelegate.h"
#import "FriendsListViewController.h"
#import "RoomViewController.h"
@interface ViewController ()

@end

@implementation ViewController
{
    XMPPRoomCoreDataStorage    *_storage;
    XMPPRoom                   *_xmppRoom;
}
- (AppDelegate *)appDelegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _storage = [[XMPPRoomCoreDataStorage alloc]init];
    [[[self appDelegate] xmppStream] setHostName:@"123.103.19.173"];
    [[[self appDelegate] xmppStream] setHostPort:5222];
     _nameField.text = @"xiao2@openfire.youmi.cn";
    _passField.text = @"xiao2";
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)friendButtonAction:(UIButton *)sender {
    FriendsListViewController *f = [[FriendsListViewController alloc]init];
    [self.navigationController pushViewController:f animated:YES];
}
- (IBAction)addFriendAction:(UIBarButtonItem *)sender {
    [[[self appDelegate]xmppRoster]addUser:[XMPPJID jidWithString:_nameField.text] withNickname:_passField.text];
}
- (IBAction)commitButtonAction:(UIButton *)sender {
    if (![self allInformationReady]) {
        return;
    }
    if ([[self appDelegate]myConnect]) {
        self.title = [[[[self appDelegate]xmppStream]myJID]bare];
    }
    else
    {
        self.title = @"no seccuss";
    }

     NSLog(@"3333333333");
}
-(BOOL)allInformationReady{
    if (_nameField.text&&_passField.text) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:[NSString stringWithFormat:@"%@/XMPPIOS",_nameField.text] forKey:kMyJID];
        [user setObject:_passField.text forKey:kPS];
        [user synchronize];
        return YES;
    }
    [[self appDelegate] showAlertView:@"信息不完整"];
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)copyAction:(id)sender {
    //粘贴复制功能中的复制，把只复制出来。
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = @"123456";
}
- (IBAction)roomButtonAction:(UIButton *)sender {
    RoomViewController *r= [[RoomViewController alloc]init];
    [self.navigationController pushViewController:r animated:YES];
}
- (IBAction)createRoomButtonAtion:(UIButton *)sender {
    XMPPJID * roomJid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@conference.%@",_roomField.text,@"openfire.youmi.cn"]];
    _xmppRoom = [[XMPPRoom alloc]initWithRoomStorage:_storage jid:roomJid dispatchQueue:dispatch_get_main_queue()];
    [_xmppRoom activate:[self appDelegate].xmppStream];
    [_xmppRoom joinRoomUsingNickname:@"xiao123" history:nil];
    [_xmppRoom fetchConfigurationForm];
    
    [_xmppRoom addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    
}
- (void)xmppRoomMemoryStorage:(XMPPRoomMemoryStorage *)sender occupantDidJoin:(XMPPRoomOccupantMemoryStorageObject *)occupant atIndex:(NSUInteger)index inArray:(NSArray *)allOccupants
{
    NSLog(@"roomdid join111111111");
}
- (void)xmppRoomDidCreate:(XMPPRoom *)sender
{
    [self sendDefaultRoomConfig];
    NSLog(@"room did creat1111111111===%@",sender);
    //    [sender fetchConfigurationForm];
    [sender configureRoomUsingOptions:nil];
}
#pragma mark 配置房间为永久房间
-(void)sendDefaultRoomConfig
{
    
    NSXMLElement *x = [NSXMLElement elementWithName:@"x" xmlns:@"jabber:x:data"];
    
    NSXMLElement *field = [NSXMLElement elementWithName:@"field"];
    NSXMLElement *value = [NSXMLElement elementWithName:@"value"];
    
    NSXMLElement *fieldowners = [NSXMLElement elementWithName:@"field"];
    NSXMLElement *valueowners = [NSXMLElement elementWithName:@"value"];
    
    
    [field addAttributeWithName:@"var" stringValue:@"muc#roomconfig_persistentroom"];  // 永久属性
    [fieldowners addAttributeWithName:@"var" stringValue:@"muc#roomconfig_roomowners"];  // 谁创建的房间
    
    
    [field addAttributeWithName:@"type" stringValue:@"boolean"];
    [fieldowners addAttributeWithName:@"type" stringValue:@"jid-multi"];
    
    [value setStringValue:@"1"];
    [valueowners setStringValue:_nameField.text]; //创建者的Jid
    
    [x addChild:field];
    [x addChild:fieldowners];
    [field addChild:value];
    [fieldowners addChild:valueowners];
    
    [_xmppRoom configureRoomUsingOptions:x];
    
}

@end
