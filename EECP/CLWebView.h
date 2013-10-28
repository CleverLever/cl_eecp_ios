//
//  CLWebView.h
//  EECP
//
//  Created by Austin Gregg on 10/15/13.
//  Copyright (c) 2013 CleverLever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLWebView : UIWebView

-(BOOL)isLogin;
-(BOOL)isCP;
-(NSString *)retrieveXid;
- (void)loginToCP:(NSString*)cp withXid:(NSString*)xid userName:(NSString*)userName password:(NSString*)password;

@end
