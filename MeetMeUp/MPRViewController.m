//
//  MPRViewController.m
//  MeetMeUp
//
//  Created by Manas Pradhan on 3/24/14.
//  Copyright (c) 2014 Manas Pradhan. All rights reserved.
//

#import "MPRViewController.h"
#import "MPRMeetUpEvent.h"
#import "MPRMeetUpEventViewController.h"

@interface MPRViewController () <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView             *myTableView;
    NSArray                          *allMeetUpEvents;
    MPRMeetUpEvent                   *event;
    NSMutableArray                   *events;
}
@end

@implementation MPRViewController

- (void)viewDidLoad
{
    // Download data from MeetUp JSON file
    
    NSData *allMeetUpData            = [[NSData alloc] initWithContentsOfURL:
                                        [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=2b35722b207036d151b4453654be73"]];
    
    
    // Initialize mutable dictionary of MeetUp events
    
    NSError *error;
    NSMutableDictionary *allMeetUps  = [NSJSONSerialization
                                        JSONObjectWithData:allMeetUpData
                                        options:NSJSONReadingMutableContainers
                                        error:&error];
    
    
    // Stores mutable dictionary of MeetUp events into an array

    allMeetUpEvents                  = allMeetUps[@"results"];
    
    
    // Call to the super class to load the view
    
    [super viewDidLoad];
    
    
    // Store information from MeetUp JSON file into MeetUpEvent object
    
    event.meetUpGroupName            = [[allMeetUps objectForKey:@"group"] objectForKey:@"name"];
    event.meetUpEventName            = [allMeetUps objectForKey:@"name"];
    event.meetUpEventVenueName       = [[allMeetUps objectForKey:@"venue"] objectForKey:@"name"];
    event.meetUpEventVenueAddress    = [[allMeetUps objectForKey:@"venue"] objectForKey:@"address_1"];
    event.meetUpEventDescription     = [allMeetUps objectForKey:@"description"];
    event.meetUpEventURL             = [allMeetUps objectForKey:@"event_url"];
    event.yesRSVP                    = [allMeetUps objectForKey:@"yes_rsvp_count"];
    event.maybeRSVP                  = [allMeetUps objectForKey:@"maybe_rsvp_count"];
    event.waitlistRSVP               = [allMeetUps objectForKey:@"waitlist_count"];
    
    
    // Store MeetUpEvent objects into a mutable array
    
    events                           = [[NSMutableArray alloc]initWithObjects:event, nil];
    [events addObject:event];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allMeetUpEvents count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Returns table cell containing information from the MeetUpEvent
    
    UITableViewCell *cell            = [tableView dequeueReusableCellWithIdentifier:@"MeetupID"];
    NSDictionary    *meetUp          = allMeetUpEvents[indexPath.row];
    
    
    // Formats the cell
    
    cell.textLabel.text              = meetUp[@"name"];
    cell.detailTextLabel.text        = [meetUp[@"venue"] objectForKey:@"address_1"];
    cell.backgroundColor             = [UIColor redColor];
    
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
    NSIndexPath *indexPath           = [myTableView indexPathForCell:sender];
    MPRMeetUpEvent *meetUpEvent      = [events objectAtIndex:indexPath.row];
    MPRMeetUpEventViewController *vc = segue.destinationViewController;
    vc.event                         = meetUpEvent;
}

@end
