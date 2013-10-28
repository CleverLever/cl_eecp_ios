//
//  CLFirstLoginViewController.h
//  EECP
//
//  Created by Austin Gregg on 10/14/13.
//  Copyright (c) 2013 CleverLever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLCPViewController.h"

@interface CLFirstLoginViewController : UIViewController <UIAlertViewDelegate> {
    CLWebView *parentWv;
}

@property (retain, strong) IBOutlet UITextField *cpUrlTF;
@property (retain, strong) IBOutlet UITextField *userNameTF;
@property (retain, strong) IBOutlet UITextField *passwordTF;
@property (retain, strong) IBOutlet UIButton *connectBtn;
@property (retain, strong) IBOutlet UISwitch *rememberSw;
@property (retain, strong) CLWebView *parentWV;
@property (retain, strong) CLCPViewController *parentVC;

@property NSInteger *loginAttempts;


-(IBAction) connectToCp;

@end
