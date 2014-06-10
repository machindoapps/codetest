//
//  MasterViewController.h
//  codetest
//
//  Created by David on 10/06/2014.
//  Copyright (c) 2014 MBP Consulting Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
