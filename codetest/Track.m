//
//  Track.m
//  codetest
//
//  Created by David on 10/06/2014.
//  Copyright (c) 2014 MBP Consulting Ltd. All rights reserved.
//

#import "Track.h"

@implementation Track

+(Track *) trackWithArtist:(NSString *)newArtistName
                     track:(NSString *)newTrackName
                     album:(NSString *)newAlbumName
                     price:(NSNumber *)newPrice
               releaseDate:(NSDate *)newReleaseDate
                   artwork:(NSURL *)newArtworkURL
{
    Track *track = [[Track alloc] init];
    
    //TODO: add validation to supplied fields
    
    track.artistName = newArtistName;
    track.name = newTrackName;
    track.albumName = newAlbumName;
    track.price = newPrice;
    track.releaseDate = newReleaseDate;
    track.artworkURL = newArtworkURL;

    return track;
}

@end
