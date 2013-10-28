//
//  CLWebView.m
//  EECP
//
//  Created by Austin Gregg on 10/15/13.
//  Copyright (c) 2013 CleverLever. All rights reserved.
//

#import "CLWebView.h"

@implementation CLWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(BOOL)isLogin {
    NSString *title = [self stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('Title')[0].innerHTML"];
    NSLog(@"Title = %@", title);
    if ([title isEqualToString:@"Login | ExpressionEngine"]) return TRUE;
    return FALSE;
}

-(BOOL)isCP {
    NSString *title = [self stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('Title')[0].innerHTML"];
    NSLog(@"Title = %@", title);
    if ([title isEqualToString:@"CP Home | ExpressionEngine"]) return TRUE;
    return FALSE;
}

-(NSString *)retrieveXid {
    
    NSString *xid = [self stringByEvaluatingJavaScriptFromString:@"document.getElementsByName('XID')[0].value"];
    
    return xid;
}

- (void)loginToCP:(NSString*)cp withXid:(NSString*)xid userName:(NSString*)userName password:(NSString*)password {

    // Setup the URL
    NSString *loginUrl = [NSString stringWithFormat:@"%@/index.php?S=0&D=cp&C=login&M=authenticate", cp];
    NSURL *url = [NSURL URLWithString:loginUrl];
    NSMutableURLRequest *requestObj = [[NSMutableURLRequest alloc]initWithURL:url];
    
    // POST the username password
    [requestObj setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"username=%@&password=%@&XID=%@", userName, password, xid];
    NSData *data = [postString dataUsingEncoding: NSUTF8StringEncoding];
    [requestObj setHTTPBody:data];
    
//    NSLog(@"PostString = %@",postString);
    
    // Load the request
    [self loadRequest:requestObj];
}

@end
