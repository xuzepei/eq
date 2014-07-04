//
//  Book.h
//  Food
//
//  Created by xuzepei on 10/10/11.
//  Copyright 2011 Rumtel Co.,Ltd. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Book :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * isHidden;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSNumber * isFavorited;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * isNew;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * segment_id;
@property (nonatomic, retain) NSString * desc;

@end



