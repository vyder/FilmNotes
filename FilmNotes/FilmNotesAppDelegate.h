//
//  FilmNotesAppDelegate.h
//  FilmNotes
//
//  Created by Vidur Murali on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilmNotesAppDelegate : NSObject <UIApplicationDelegate> {
    
    NSManagedObjectModel            *managedObjectModel;
    NSManagedObjectContext          *managedObjectContext;
    NSPersistentStoreCoordinator    *persistentStoreCoordinator;
    
    UIWindow                *window;
    UINavigationController  *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSString *)applicationDocumentsDirectory;

@end
