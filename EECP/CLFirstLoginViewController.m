//
//  CLFirstLoginViewController.m
//  EECP
//
//  Created by Austin Gregg on 10/14/13.
//  Copyright (c) 2013 CleverLever. All rights reserved.
//

#import "CLFirstLoginViewController.h"
#import "CLAppDelegate.h"


@interface CLFirstLoginViewController ()

@end

@implementation CLFirstLoginViewController
@synthesize cpUrlTF, userNameTF, passwordTF, connectBtn, rememberSw, parentVC, parentWV, loginAttempts;

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
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Site"];
    NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastAccessed" ascending:NO];
    NSArray *sortDescriptors = @[dateDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSArray *sites = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    if (! [sites count] == 0) {
        NSManagedObject *site = [sites objectAtIndex:0];
        self.cpUrlTF.text = [site valueForKey:@"cpUrl"];
        self.userNameTF.text = [site valueForKey:@"userName"];
        self.passwordTF.text = [site valueForKey:@"password"];
    }
    
    loginAttempts = 0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) connectToCp {

    //Check for empty text fields
    NSArray *textFields = [NSArray arrayWithObjects:cpUrlTF, userNameTF, passwordTF, nil];
    for (UITextField *tF in textFields) {
        if (tF.text == [NSString stringWithFormat:@""]) {
            [self flashTextField:tF withColor:[UIColor redColor]];
            return;
        }
    }
    
#warning Add http:// check
    
    if (![self validateUrl:cpUrlTF.text]) {
        NSLog(@"Malformed Url");
        return;
    }
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Site"];
    NSArray *sites = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    for (NSManagedObject *site in sites) {
        [context deleteObject:site];
    }
    
    
    if ([rememberSw isOn]) {
    
        NSManagedObject *site = [NSEntityDescription insertNewObjectForEntityForName:@"Site" inManagedObjectContext:context];
        [site setValue:self.cpUrlTF.text forKey:@"cpUrl"];
        [site setValue:self.userNameTF.text forKey:@"userName"];
        [site setValue:self.passwordTF.text forKey:@"password"];
        [site setValue:[NSDate date] forKey:@"lastAccessed"];
        
        NSError *error;
        if(![context save:&error]){
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    
    }
    [parentVC.webView setDelegate:self];
    [parentVC loadUrl:[NSURL URLWithString:cpUrlTF.text]];
    
    
//    for (UITextField *tF in textFields) {
//        tF.text = nil;
//    }
    
//     [self.navigationController popViewControllerAnimated:YES];

}

-(BOOL)validateUrl:(NSString *)url {
    
    NSURL *candidateURL = [NSURL URLWithString:url];
    if (candidateURL && candidateURL.scheme && candidateURL.host) {
        return TRUE;
    }
    return FALSE;
}

-(void)webViewDidFinishLoad:(CLWebView *)wView {
    [self performSelector:@selector(webViewCheck) withObject:Nil afterDelay:.2];
    }

-(void)webViewCheck {
    CLWebView *wView = self.parentWV;
    if ([wView isLogin]) {
        if (loginAttempts >= 3) {
#warning Add AlertView
            NSLog(@"Error Logging In");
            loginAttempts = 0;
        }
        else {
            NSString *xid = [wView retrieveXid];
            NSLog(@"Xid = %@", xid);
            if (! ([xid isEqual: @""])) {
                [wView loginToCP:cpUrlTF.text withXid:xid userName:userNameTF.text password:passwordTF.text];
            }
            loginAttempts = loginAttempts+1;
        }
        
    }
    else if ([wView isCP]) {
        [wView setDelegate:parentVC];
        [wView reload];
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (BOOL)webView:(CLWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"Will Load URL = %@",[request URL]);
    
    return YES;
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void) flashTextField:(UITextField *)textField withColor:(UIColor *)color {
    
    
}

@end
