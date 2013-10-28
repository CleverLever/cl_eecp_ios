//
//  DetailViewController.h
//  TVTest
//
//  Created by Austin Gregg on 10/20/13.
//  Copyright (c) 2013 BottleRocket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
