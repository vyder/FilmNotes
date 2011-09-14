//
//  ExposureViewController.m
//  FilmNotes
//
//  Created by Vidur Murali on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ExposureViewController.h"

@implementation ExposureViewController

@synthesize managedObjectContext;
@synthesize eventArray;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Exposure"];
    
    // Add an "Add" button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addExposure:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
    [self fetchRecords];
}

- (void) addExposure:(id)sender {
    
    Exposure *exposure = (Exposure *)[NSEntityDescription insertNewObjectForEntityForName:@"Exposure" inManagedObjectContext:managedObjectContext];
    
    // Set variables/attributes of table
    [exposure setDate_created:[NSDate date]];
    
    NSError *error;
    if(![managedObjectContext save:&error]) {
        //Some serious shit just went down and you can't save data
        NSLog(@"Serious shit went down");
    }
    
    [eventArray insertObject:exposure atIndex:0];
    
    [self.tableView reloadData];
}

- (void)fetchRecords {
    
    // Define entity/table to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Exposure" inManagedObjectContext:managedObjectContext];
    
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    // Define how to sort the records
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date_created" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];
    [sortDescriptor release];
    
    NSError *error;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if(!mutableFetchResults) {
        //Some serious shit just went down and you can't save data
        NSLog(@"Serious shit went down");        
    }
    
    [self setEventArray:mutableFetchResults];
    [mutableFetchResults release];
    [request release];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    static NSDateFormatter *dateFormatter = nil;
    
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"h:mm.ss a"];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    Exposure *exposure = [eventArray objectAtIndex:[indexPath row]];
    Exposure *previousExposure = nil;
    
    if ([eventArray count] > ([indexPath row] + 1)) {
        previousExposure = [eventArray objectAtIndex:([indexPath row] + 1)];
    }
    
    [cell.textLabel setText:[dateFormatter stringFromDate:[exposure date_created]]];
    
    if (previousExposure) {  
        NSTimeInterval timeDifference = [[exposure date_created] timeIntervalSinceDate: [previousExposure date_created]];  
        [cell.detailTextLabel setText: [NSString stringWithFormat:@"+%.02f sec", timeDifference]];  
    } else {  
        [cell.detailTextLabel setText: @"---"];  
    }   
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [eventArray count];
}

- (void)dealloc {
    [managedObjectContext release];
    [eventArray release];
    
    [super dealloc];
}
@end
