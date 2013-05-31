//
//  SettingViewController.m
//  wakeup
//
//  Created by din1030 on 13/5/29.
//  Copyright (c) 2013年 din1030. All rights reserved.
//

#import "AppDelegate.h"
#import "SettingViewController.h"

@interface SettingViewController ()

- (IBAction)fbClick:(UIButton *)sender;
- (IBAction)sendClick:(UIButton *)sender;

@end

@implementation SettingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    NSLog(@"%@",currentTimeZone.description); // Local Time Zone (Asia/Taipei (GMT+08:00) offset 28800)
    NSLog(@"%@",currentTimeZone.abbreviation); // GMT+08:00
    self.timeZone.text = currentTimeZone.abbreviation;
    //NSInteger offset = [currentTimeZone secondsFromGMT];
    //[NSDate dateWithTimeIntervalSince1970:1301322715];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

/* - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
} */

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)dealloc {
    [_fbButton release];
    [_timeZone release];
    [super dealloc];
}

#pragma mark - for Facebook

- (IBAction)fbClick:(UIButton *)sender
{
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    // If the user is authenticated, log out when the button is clicked.
    // If the user is not authenticated, log in when the button is clicked.
    if (FBSession.activeSession.isOpen) {
        [appDelegate closeSession];
    } else {
        // The user has initiated a login, so call the openSession method
        // and show the login UX if necessary.
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
}


// Convenience method to perform some action that requires the "publish_actions" permissions.
- (void) performPublishAction:(void (^)(void)) action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession requestNewPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
                                                   defaultAudience:FBSessionDefaultAudienceFriends
                                                 completionHandler:^(FBSession *session, NSError *error) {
                                                     if (!error) {
                                                         action();
                                                     }
                                                     //For this example, ignore errors (such as if user cancels).
                                                 }];
    } else {
        action();
    }
    
}


- (IBAction)sendClick:(UIButton *)sender {
    // Post a status update to the user's feed via the Graph API, and display an alert view
    // with the results or an error.
    //NSString *name = self.loggedInUser.name;
    NSString *message = [NSString stringWithFormat:@"成功送出～"]; //name != nil ? name : @"me"
    //                     self.contentText.text]; //送出的訊息
    
    // if it is available to us, we will post using the native dialog
    //    BOOL displayedNativeDialog = [FBNativeDialogs presentShareDialogModallyFrom:self
    //                                                                    initialText:@"HI!"
    //                                                                          image:nil
    //                                                                            url:[NSURL URLWithString:@""]
    //                                                                        handler:nil];
    if (FBSession.activeSession.isOpen) { //name!=nil , FBSession.activeSession.isOpen
        NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       [NSString stringWithFormat:@"骨子裡其實是個%@", //name,
                                        @"法國人"],@"message",@"法國人",@"name", @" " ,@"caption",
                                       @"Hi～～～",@"description",
                                       @"https://www.parse.com/docs/cloud_code_guide", @"link",
                                       @"http://big5.gmw.cn/images/2009-07/30/xin_1207063003540622341025.jpg", @"picture",
                                       nil];
        
        [self performPublishAction:^{
            // otherwise fall back on a request for permissions and a direct post
            [FBRequestConnection startWithGraphPath:@"me/feed"
                                         parameters:params HTTPMethod:@"POST"
                                  completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                      
                                      [self showAlert:message result:result error:error]; //跳出alert
                                      self.fbButton.enabled = YES;
                                  }];
            
            self.fbButton.enabled = NO;
        }];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"哇嗚～"
                              //上面是標題的設定
                                                        message:@"要先登入才能分享唷！"  //警告訊息內文的設定
                                                       delegate:self // 叫出AlertView之後，要給該ViewController去處理
                              
                                              cancelButtonTitle:@"OK"  //cancel按鈕文字的設定
                                              otherButtonTitles: nil]; // 其他按鈕的設定
        // 如果要多個其他按鈕 >> otherButtonTitles: @"check1", @"check2", nil];
        
        [alert show];  // 把alert這個物件秀出來
        //        [alert release]; //釋放alert這個物件
    }
}

// UIAlertView helper for post buttons
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
    
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertMsg = [NSString stringWithFormat:@"出錯了 QQ error:%@", error.localizedDescription ];
        alertTitle = @"哇～";
    } else {
        //NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = @"已分享到你的塗鴉牆囉！";
        //[NSString stringWithFormat:@"%@，蠍男小星機已分享到你的塗鴉牆囉！",self.loggedInUser.first_name];
        alertTitle = @"恭喜！";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}


@end
