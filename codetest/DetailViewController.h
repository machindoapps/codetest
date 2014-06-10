//
//  DetailViewController.h
//  codetest
//
//  Created by David on 10/06/2014.
//  Copyright (c) 2014 MBP Consulting Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
