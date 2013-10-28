//
//  CLAppDelegate.h
//  EECP
//
//  Created by Austin Gregg on 10/14/13.
//  Copyright (c) 2013 CleverLever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"

@interface CLAppDelegate : UIResponder <UIApplicationDelegate> {
    NSManagedObjectContext *managedObjectContext;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (retain, nonatomic) UIViewController *centerController;
@property (retain, nonatomic) UIViewController *leftController;



- (IIViewDeckController *)generateControllerStack;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
