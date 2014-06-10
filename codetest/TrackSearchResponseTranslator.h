//
//  TrackSearchResponseTranslator.h
//  codetest
//
//  Created by David on 10/06/2014.
//  Copyright (c) 2014 MBP Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackSearchResponseTranslator : NSObject

+ (NSArray *)translateJsonResponse:(NSData *)jsonData;

@end
