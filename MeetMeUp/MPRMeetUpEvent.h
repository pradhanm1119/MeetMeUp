//
//  MPRMeetUpEvent.h
//  MeetMeUp
//
//  Created by Manas Pradhan on 3/24/14.
//  Copyright (c) 2014 Manas Pradhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPRMeetUpEvent : NSObject
@property NSString *meetUpGroupName;
@property NSString *meetUpEventName;
@property NSString *meetUpEventVenueName;
@property NSString *meetUpEventVenueAddress;
@property NSString *meetUpEventDescription;
@property NSString *meetUpEventURL;
@property NSNumber *yesRSVP;
@property NSNumber *maybeRSVP;
@property NSNumber *waitlistRSVP;
@end
