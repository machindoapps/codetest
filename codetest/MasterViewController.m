//
//  MasterViewController.m
//  codetest
//
//  Created by David on 10/06/2014.
//  Copyright (c) 2014 MBP Consulting Ltd. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TrackSearchResponseTranslator.h"
#import "Track.h"

static const NSString *itunesURLPath = @"http://itunes.apple.com";
static const NSString *itunesSearchMethod = @"/search?term=";

@interface MasterViewController ()
@property (nonatomic, strong) NSArray *searchResults;
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackCell" forIndexPath:indexPath];

    //TODO: insert objects into table from returned results
    if(self.searchResults.count > 0) {
        Track *track = (Track *)self.searchResults[[indexPath row]];
                                               
        if(track) {
            cell.detailTextLabel.text = track.name;
            cell.textLabel.text = track.artistName;
        }
        
        if(track.artworkURL60 != nil) {
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *task = [session dataTaskWithURL:track.artworkURL60
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            if (error) {
                                NSLog(@"ERROR: %@", error);
                            } else {
                                
                                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                if (httpResponse.statusCode == 200) {
                                    UIImage *image = [UIImage imageWithData:data];
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        cell.imageView.image = image;
                                    });
                                } else {
                                    NSLog(@"Couldn't load image at URL: %@", track.artworkURL60);
                                    NSLog(@"HTTP %d", httpResponse.statusCode);
                                }
                            }
                        }];
            [task resume];
        }
        
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _searchResults[indexPath.row];
        _detailViewController.detailItem = object;
    }
}

#pragma mark - UISearchBar delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if(searchBar.text.length < 3) {
        //discard searches that are too short
        return;
    }
    
    //Format search string to match what itunes requires, i.e. http://itunes.apple.com/search?term=SEARCHTERM1+SEARCHTERM2+...
    NSString *queryString = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    //TODO: given more time and greater scope requirements, the iTunes rest interface should be placed into its own class,
    //named e.g. iTunesRestClient, rather than hard-coding the url as follows...
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", itunesURLPath, itunesSearchMethod, queryString];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      //TODO: add HTTP status code check & error handling
                                      NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                      NSLog(@"%@", responseString);
                                      
                                      _searchResults = [TrackSearchResponseTranslator translateJsonResponse:data];
                                      [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                  }];
    
    [task resume];
    [searchBar resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _searchResults[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
