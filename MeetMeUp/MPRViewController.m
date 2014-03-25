//
//  MPRViewController.m
//  MeetMeUp
//
//  Created by Manas Pradhan on 3/24/14.
//  Copyright (c) 2014 Manas Pradhan. All rights reserved.
//

#import "MPRViewController.h"

@interface MPRViewController () <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView             *myTableView;
    NSArray                          *allMeetUpEvents;
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
    [myTableView reloadData];
    
    
    // Call to the super class to load the view
    
    [super viewDidLoad];
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
    // Prepares MeetUpEvent object for segue to the MeetUpEvent View Controller
    
    NSIndexPath *indexPath              = [myTableView indexPathForCell:sender];
    MPRMeetUpEventViewController *vc    = segue.destinationViewController;
    
    vc.navigationItem.title       = [allMeetUpEvents[indexPath.row]objectForKey:@"name"];
    vc.meetUpGroupName            = [[allMeetUpEvents[indexPath.row]objectForKey:@"group"]objectForKey:@"name"];
    vc.meetUpEventName            = [allMeetUpEvents[indexPath.row] objectForKey:@"name"];
    vc.meetUpEventVenueName       = [[allMeetUpEvents[indexPath.row] objectForKey:@"venue"] objectForKey:@"name"];
    vc.meetUpEventVenueAddress    = [[allMeetUpEvents[indexPath.row] objectForKey:@"venue"] objectForKey:@"address_1"];
    vc.meetUpEventDescription     = [allMeetUpEvents[indexPath.row] objectForKey:@"description"];
    vc.meetUpEventURL             = [allMeetUpEvents[indexPath.row] objectForKey:@"event_url"];
    vc.yesRSVP                    = [allMeetUpEvents[indexPath.row] objectForKey:@"yes_rsvp_count"];
    vc.maybeRSVP                  = [allMeetUpEvents[indexPath.row] objectForKey:@"maybe_rsvp_count"];
    vc.waitlistRSVP               = [allMeetUpEvents[indexPath.row] objectForKey:@"waitlist_count"];
}

@end
