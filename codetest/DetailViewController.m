//
//  DetailViewController.m
//  codetest
//
//  Created by David on 10/06/2014.
//  Copyright (c) 2014 MBP Consulting Ltd. All rights reserved.
//

#import "DetailViewController.h"
#import "Track.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if ([self.detailItem isKindOfClass:[Track class]]) {
        Track *track = (Track *)self.detailItem;
        self.trackLabel.text = track.name;
        self.albumLabel.text = track.albumName;
        self.artistLabel.text = track.artistName;
        
        //TODO: Add proper currency locale handling
        self.priceLabel.text = [NSString stringWithFormat:@"£%@", track.price];
        
        //TODO format the date to match the locale, and only include the day, month and year
        self.releaseDateLabel.text = track.releaseDate.description;
        
        if(track.artworkURL100 != nil) {
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *task = [session dataTaskWithURL:track.artworkURL100
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"ERROR: %@", error);
                                                    } else {
                                                        
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                        if (httpResponse.statusCode == 200) {
                                                            UIImage *image = [UIImage imageWithData:data];
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [self.artworkImage setImage:image];
                                                                
                                                                //Make the imageView show a circular image
                                                                self.artworkImage.layer.cornerRadius = self.artworkImage.frame.size.height / 2;
                                                                self.artworkImage.layer.masksToBounds = YES;
                                                                self.artworkImage.layer.borderWidth = 0;
                                                            });
                                                        } else {
                                                            NSLog(@"Error loading image at URL: %@", track.artworkURL100);
                                                            NSLog(@"HTTP %d", httpResponse.statusCode);
                                                        }
                                                    }
                                                }];
            [task resume];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
