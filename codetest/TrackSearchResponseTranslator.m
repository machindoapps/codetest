//
//  TrackSearchResponseTranslator.m
//  codetest
//
//  Created by David on 10/06/2014.
//  Copyright (c) 2014 MBP Consulting Ltd. All rights reserved.
//

#import "TrackSearchResponseTranslator.h"
#import "Track.h"

static const NSString *kArtistNameKey = @"artistName";
static const NSString *kTrackNameKey = @"trackName";
static const NSString *kAlbumNameKey = @"collectionName";
static const NSString *kTrackPriceKey = @"trackPrice";
static const NSString *kTrackReleaseDateKey = @"releaseDate";
static const NSString *kArtworkKey = @"artworkUrl100";

@implementation TrackSearchResponseTranslator

+ (NSArray *)translateJsonResponse:(NSData *)jsonData
{
    NSMutableArray *results = [NSMutableArray array];
    
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"JSONObjectWithData error: %@", error);
    } else {
        if(jsonDict != nil) {
            NSArray *jsonResultsArray = jsonDict[@"results"];
            if(jsonResultsArray != nil) {
                for(NSDictionary *trackDict in jsonResultsArray) {
                    NSString *artist = trackDict[kArtistNameKey];
                    NSString *trackName = trackDict[kTrackNameKey];
                    NSString *albumName = trackDict[kAlbumNameKey];
                    NSNumber *price = trackDict[kTrackPriceKey];
                    NSString *artworkUrl = trackDict[kArtworkKey];

                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
                    NSString *dateString = trackDict[kTrackReleaseDateKey];
                    NSDate *date = [formatter dateFromString:dateString];
                    Track *track = [Track trackWithArtist:artist
                                                    track:trackName
                                                    album:albumName
                                                    price:price
                                              releaseDate:date
                                                  artwork:[NSURL URLWithString:artworkUrl]];
                    
                    if(track != nil) {
                        [results addObject:track];
                    }
                }
            }
        }
    }
    
    return results;
}

@end
