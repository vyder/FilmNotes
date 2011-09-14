//
//  Exposure.h
//  FilmNotes
//
//  Created by Vidur Murali on 9/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Exposure : NSManagedObject {
@private
}
/*@property (nonatomic, retain) NSNumber * shot_num;
@property (nonatomic, retain) NSNumber * shutter_speed;
@property (nonatomic, retain) NSDecimalNumber * aperture;
@property (nonatomic, retain) NSNumber * focal_length;*/
@property (nonatomic, retain) NSDate * date_created;

@end
