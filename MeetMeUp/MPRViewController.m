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
//    NSURL *url            = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=2b35722b207036d151b4453654be73"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Download data from MeetUp JSON file
    NSData *allMeetUpData = [[NSData alloc] initWithContentsOfURL:
                              [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=2b35722b207036d151b4453654be73"]];
    
    NSError *error;
    NSMutableDictionary *allMeetUps = [NSJSONSerialization
                                       JSONObjectWithData:allMeetUpData
                                       options:NSJSONReadingMutableContainers
                                       error:&error];
    //[myTableView reloadData];
    
    allMeetUpsArray = allMeetUps[@"results"];
    
//    if(error)
//    {
//        NSLog(@"%@", [error localizedDescription]);
//    }
//    else {
//        allMeetUpsArray = allMeetUps[@"results"];
//        for (NSDictionary *theCourse in monday)
//        {
//            NSLog(@"----");
//            NSLog(@"Title: %@", theCourse[@"title"] );
//            NSLog(@"Speaker: %@", theCourse[@"speaker"] );
//            NSLog(@"Time: %@", theCourse[@"time"] );
//            NSLog(@"Room: %@", theCourse[@"room"] );
//            NSLog(@"Details: %@", theCourse[@"details"] );
//            NSLog(@"----");
//        }
//    }

    
    //    heroes = @[@{@"Name": @"Superman", @"Age": @32},
    //               @{@"Name": @"Wonder Woman", @"Age": @23}];
    
    [super viewDidLoad];
    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^
//     (NSURLResponse *response, NSData *data, NSError *connectionError)
//     {
//         NSError *error;
//         myMeetUps = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//         [myTableView reloadData];
//         
//     }];
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
    
    //NSURL           *url = [NSURL URLWithString:superhero[@"avatar_url"]];
    
    cell.textLabel.text       = meetUp[@"name"];
    NSLog(@"Venue: %@", meetUp[@"venue"]);
    //cell.detailTextLabel.text = meetUp[@"venue", @"address"];
    //cell.imageView.image      = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    return cell;

}

@end
