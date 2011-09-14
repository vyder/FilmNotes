//
//  ExposureViewController.h
//  FilmNotes
//
//  Created by Vidur Murali on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Exposure.h"

@interface ExposureViewController : UITableViewController {
    
    NSManagedObjectContext  *managedObjectContext;
    NSMutableArray          *eventArray;
}

@property (nonatomic, retain) NSManagedObjectContext  *managedObjectContext;
@property (nonatomic, retain) NSMutableArray          *eventArray;

- (void)fetchRecords;
- (void)addExposure:(id)sender; 

@end
