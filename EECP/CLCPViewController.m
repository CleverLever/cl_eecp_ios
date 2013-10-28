//
//  CLCPViewController_iPhone.m
//  EECP
//
//  Created by Austin Gregg on 10/14/13.
//  Copyright (c) 2013 CleverLever. All rights reserved.
//

#import "CLCPViewController.h"
#import "CLFirstLoginViewController.h"
#import "CLAppDelegate.h"

@interface CLCPViewController ()

-(void)injectJavascript;

@end

@implementation CLCPViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CLFirstLoginViewController *loginView = [[CLFirstLoginViewController alloc] initWithNibName:@"CLFirstLoginViewController" bundle:[NSBundle mainBundle]];
    loginView.parentWV = self.webView;
    loginView.parentVC = self;
    [webView setDelegate:loginView];

    [self.navigationController pushViewController:loginView animated:NO];
    
//    webView.backgroundColor = [UIColor darkGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(CLWebView *)wView {
//    [self injectJavascript];
//    if ([self isLogin]) {
//        NSString *xid = [self retrieveXid];
//        NSLog(@"Xid = %@", xid);
//        if (! ([xid isEqual: @""])) {
//            [self login:xid];
//        }
//    }
    
    [self performSelector:@selector(injectJavascript) withObject:nil afterDelay:0.1];
}

- (BOOL)webView:(CLWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"URL = %@",[request URL]);
    
    return YES;
}

-(void)loadUrl:(NSURL *)url {
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];

}

-(void)injectJavascript {
    NSString *js = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://greggmanor.com/test/test.js"] encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"%@", js);
    
    [self.webView stringByEvaluatingJavaScriptFromString:js];
    
    
//    NSString *source = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('navigationTabs').outerHTML;"];
//    
//    NSLog(@"Source = %@", source);
}


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


@end
