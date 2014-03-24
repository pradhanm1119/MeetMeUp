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
    NSArray *allMeetUpsArray;
    IBOutlet UITableView *myTableView;
}
@end

@implementation MPRViewController

- (void)viewDidLoad
{
    // Download data from MeetUp JSON file
    NSData *allMeetUpData = [[NSData alloc] initWithContentsOfURL:
                             [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=2b35722b207036d151b4453654be73"]];
    
    NSError *error;
    NSMutableDictionary *allMeetUps = [NSJSONSerialization
                                       JSONObjectWithData:allMeetUpData
                                       options:NSJSONReadingMutableContainers
                                       error:&error];
    
    allMeetUpsArray = allMeetUps[@"results"];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allMeetUpsArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeetupID"];
    NSDictionary    *meetUp = allMeetUpsArray[indexPath.row];
    
    cell.textLabel.text       = meetUp[@"name"];
    cell.detailTextLabel.text = [meetUp[@"venue"] objectForKey:@"address_1"];
    
    return cell;

}

@end
