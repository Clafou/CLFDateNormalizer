//
//  CLFDateNormalizerTests.m
//  CLFDateNormalizerTests
//
//  Created by Sébastien Molines on 19/02/2013.
//  Copyright (c) 2013 Sébastien Molines. All rights reserved.
//

#import "CLFDateNormalizerTests.h"
#import "CLFDateNormalizer.h"

@implementation CLFDateNormalizerTests

- (void)setUp
{
    [super setUp];
    
    // We want the unit tests to work in any locale, so we use a fixed (invariant) locale and formatter to parse test date strings
    _invariantLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    _invariantFormatter = [NSDateFormatter new];
    _invariantFormatter.timeStyle = NSDateFormatterFullStyle;
    _invariantFormatter.dateStyle = NSDateFormatterFullStyle;
    _invariantFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss zzz";
}

- (void)tearDown
{
    [_invariantLocale release];
    [_invariantFormatter release];
    [super tearDown];
}

- (void)testSetsTimeToMidnight
{
    CLFDateNormalizer *normalizer = [[CLFDateNormalizer alloc] initWithLocalTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *notMidnight = [_invariantFormatter dateFromString:@"2012-02-19 19:45:22 UTC"];

    NSDate *normalized = [normalizer normalize:notMidnight];

    NSString *sNormalized = [_invariantFormatter stringFromDate:normalized];
    STAssertEqualObjects(sNormalized, @"2012-02-19 00:00:00 UTC", @"Should keep the date but set the time to midnight");
}

- (void)testInterpretInputInLocalTimeZone
{
    NSDate *aheadInAustralia = [_invariantFormatter dateFromString:@"2012-02-19 18:15:20 UTC"]; // This is the next day in Australia
    CLFDateNormalizer *normalizer = [[CLFDateNormalizer alloc] initWithLocalTimeZone:[NSTimeZone timeZoneWithName:@"Australia/Sydney"]];

    NSDate *normalized = [normalizer normalize:aheadInAustralia];

    NSString *sNormalized = [_invariantFormatter stringFromDate:normalized];
    STAssertEqualObjects(sNormalized, @"2012-02-20 00:00:00 UTC", @"Should interpret dates in the local time zone");
}

- (void)testInterpretInputInLocalTimeZone2
{
    NSDate *aheadInAustralia = [_invariantFormatter dateFromString:@"2012-02-20 07:42:00 +11"]; // Sydney is GMT+11
    CLFDateNormalizer *normalizer = [[CLFDateNormalizer alloc] initWithLocalTimeZone:[NSTimeZone timeZoneWithName:@"Australia/Sydney"]];
    
    NSDate *normalized = [normalizer normalize:aheadInAustralia];
    
    NSString *sNormalized = [_invariantFormatter stringFromDate:normalized];
    STAssertEqualObjects(sNormalized, @"2012-02-20 00:00:00 UTC", @"Should interpret dates in the local time zone");
}

- (void)testInterpretInputInLocalTimeZone3
{
    NSDate *behindInStates = [_invariantFormatter dateFromString:@"2012-02-19 01:23:45 UTC"];   // This is the previous day in USA
    CLFDateNormalizer *normalizer = [[CLFDateNormalizer alloc] initWithLocalTimeZone:[NSTimeZone timeZoneWithName:@"US/Pacific"]];

    NSDate *normalized = [normalizer normalize:behindInStates];

    NSString *sNormalized = [_invariantFormatter stringFromDate:normalized];
    STAssertEqualObjects(sNormalized, @"2012-02-18 00:00:00 UTC", @"Should interpret dates in the local time zone");
}

@end
