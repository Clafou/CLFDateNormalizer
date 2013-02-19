//
//  CLFDateNormalizer.h
//  CLFDateNormalizer
//
//  Created by Sébastien Molines on 19/02/2013.
//  Copyright (c) 2013 Sébastien Molines. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLFDateNormalizer : NSObject
{
    NSCalendar *_localCalendar;
    NSCalendar *_utcCalendar;
}

- (id)initWithLocalTimeZone:(NSTimeZone *)localTimeZone;
- (NSDate *)normalize:(NSDate *)date;

@end