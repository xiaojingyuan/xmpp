//
//  ChatViewController.m
//  Xmpp24Demo
//
//  Created by xiaojingyuan on 14-7-24.
//  Copyright (c) 2014年 xiaojingyuan. All rights reserved.
//

#import "ChatViewController.h"
#import "AppDelegate.h"
@interface ChatViewController ()
{
    NSMutableString *_contextString;
}
@end

@implementation ChatViewController

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
- (void)getMessageData{
    NSManagedObjectContext *context = [[self appDelegate].xmppMessageArchivingCoreDataStorage mainThreadManagedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    NSError *error ;
    NSArray *messages = [context executeFetchRequest:request error:&error];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:messages];
    for (XMPPMessageArchiving_Message_CoreDataObject *ob in self.dataArray) {
        [_contextString appendFormat:@"bareJidStr:%@\n",ob.body ];
    }
    contextTextView.text = _contextString;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
     _contextString= [[NSMutableString alloc]init];
    self.title = [[[[self appDelegate]xmppStream]myJID]bare];
    self.dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self getMessageData];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)sendButtonAction:(UIButton *)sender {
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.userobject.jid];
    [message addBody:sendTextField.text];
    [[[self appDelegate] xmppStream] sendElement:message];
}
- (IBAction)addImageSendTo:(UIButton *)sender {
}
- (void)getNewMessage:(AppDelegate *)appD Message:(XMPPMessage *)message
{
    NSLog(@"getback==========getback");
    [self getMessageData];
}
- (void)friendStatusChange:(AppDelegate *)appD Presence:(XMPPPresence *)presence
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [contextTextView resignFirstResponder];
}
@end
