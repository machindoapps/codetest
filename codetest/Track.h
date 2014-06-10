//
//  Track.h
//  codetest
//
//  Created by David on 10/06/2014.
//  Copyright (c) 2014 MBP Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject

@property (nonatomic, copy) NSString *artistName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *albumName;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSDate *releaseDate;
@property (nonatomic, copy) NSURL *artworkURL60;
@property (nonatomic, copy) NSURL *artworkURL100;

//todo: add artwork

+(Track *) trackWithArtist:(NSString *)newArtistName
                     track:(NSString *)newTrackName
                     album:(NSString *)newAlbumName
                     price:(NSNumber *)newPrice
               releaseDate:(NSDate *)newReleaseDate
                 artwork60:(NSURL *)newArtworkURL60
                artwork100:(NSURL *)newArtworkURL100;

@end
