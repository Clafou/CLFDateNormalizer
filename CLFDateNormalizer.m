//
//  CLFDateNormalizer.m
//  CLFDateNormalizer
//
//  Created by Sébastien Molines on 19/02/2013.
//  Copyright (c) 2013 Sébastien Molines. All rights reserved.
//

#import "CLFDateNormalizer.h"

@implementation CLFDateNormalizer

- (id)initWithLocalTimeZone:(NSTimeZone *)localTimeZone
{
    self = [super init];
    if (self)
    {
        _localCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [_localCalendar setTimeZone:localTimeZone];
        _utcCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [_utcCalendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    return self;
}

- (NSDate *)normalize:(NSDate *)date
{
    NSDateComponents *components = [_localCalendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSDate *normalized = [_utcCalendar dateFromComponents:components];
    return normalized;
}

// Returns an NSDate representing in UTC the same calendar date as what the local time zone considers to be today at this moment. The time portion is midnight UTC time.
- (NSDate *)normalizeToday
{
    return [self normalize:[NSDate date]];
}

- (void)dealloc
{
    [_localCalendar release];
    [_utcCalendar release];
    [super dealloc];
}

@end
