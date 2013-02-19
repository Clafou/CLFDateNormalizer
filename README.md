CLFDateNormalizer
=================

Interprets a NSDate in a given input locale (typically the system locale) and creates an NSDate that represents the same day/month/year at midnight UTC time.
Proper use of UTC time in your application and storage where relevant should mean that you don't need this, but there are scenarios where it is useful:

* If you have previously recorded dates of events (where time is irrelevant, such as birthdays) in the user's timezone and want to migrate to UTC-based logic without causing any of these dates to change for the user.
* For normalizing NSDates in order to compare or chart them as time intervals. The time intervals of such normalized NSDates are guaranteed to differ by whole increments of a full day's duration, no matter what the time part of the original dates was or what time zone was used to input these original dates.
* To clear the time section of an NSDate, for example to initialize the date of a `UIDatePicker` in mode `UIDatePickerModeDate`, if it is important for you to obtain NSDates with time elements of midnight UTC from this date picker.

## Installation

* Add `CLFDateNormalizer.{h,m}` to your project
* Import as necessary with: `#import "CLFDateNormalizer.h"`.

## Usage

Instantiate a `CLFDateNormalizer` with an input time zone. This is the time zone from which it will interpret dates and would typically be `[NSTimeZone systemTimeZone]`. You can then use this `CLFDateNormalizer` to create any number of normalized dates using its `normalize` method.

```objective-c
CLFDateNormalizer *normalizer = [[CLFDateNormalizer alloc] initWithLocalTimeZone:[NSTimeZone systemTimeZone]];
NSDate *normalized = [normalizer normalize:myDate];
```
