//
//  MPRMeetUpEventViewController.m
//  MeetMeUp
//
//  Created by Manas Pradhan on 3/24/14.
//  Copyright (c) 2014 Manas Pradhan. All rights reserved.
//

#import "MPRMeetUpEventViewController.h"

@interface MPRMeetUpEventViewController ()
@property (strong, nonatomic) IBOutlet UILabel    *eventNameLabel;
@property (strong, nonatomic) IBOutlet UILabel    *groupNameLabel;
@property (strong, nonatomic) IBOutlet UILabel    *venueNameLabel;
@property (strong, nonatomic) IBOutlet UILabel    *venueAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel    *urlLabel;
@property (strong, nonatomic) IBOutlet UILabel    *yesLabel;
@property (strong, nonatomic) IBOutlet UILabel    *maybeLabel;
@property (strong, nonatomic) IBOutlet UILabel    *waitlistLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionDisplay;

@end

@implementation MPRMeetUpEventViewController

- (void)viewDidLoad
{
    // Call to the super class to load the view
    
    [super viewDidLoad];
    
    self.eventNameLabel.text     = self.meetUpEventName;
    self.groupNameLabel.text     = self.meetUpGroupName;
    self.venueNameLabel.text     = self.meetUpEventVenueName;
    self.venueAddressLabel.text  = self.meetUpEventVenueAddress;
    self.urlLabel.text           = self.meetUpEventURL;
    self.yesLabel.text           = self.yesRSVP;
    self.maybeLabel.text         = self.maybeRSVP;
    self.waitlistLabel.text      = self.waitlistRSVP;
    self.descriptionDisplay.text = self.meetUpEventDescription;
}

@end
