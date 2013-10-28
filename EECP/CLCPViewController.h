//
//  CLCPViewController_iPhone.h
//  EECP
//
//  Created by Austin Gregg on 10/14/13.
//  Copyright (c) 2013 CleverLever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLCPViewController : UIViewController

@property (retain, strong) IBOutlet CLWebView *webView;

-(void)loadUrl:(NSURL *)url;

@end
