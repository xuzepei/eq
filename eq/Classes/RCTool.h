//
//  RCTool.h
//  rsscoffee
//
//  Created by beer on 8/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCTool : NSObject {

}

+ (NSString*)getUserDocumentDirectoryPath;
+ (NSString *)md5:(NSString *)str;

+ (BOOL)isExistingFile:(NSString*)path;

+ (void)setReachabilityType:(int)type;
+ (int)getReachabilityType;
+ (BOOL)isReachableViaWiFi;
+ (BOOL)isReachableViaInternet;

+ (NSPersistentStoreCoordinator*)getPersistentStoreCoordinator;
+ (NSManagedObjectContext*)getManagedObjectContext;
+ (NSManagedObjectID*)getExistingEntityObjectIDForName:(NSString*)entityName
											 predicate:(NSPredicate*)predicate
									   sortDescriptors:(NSArray*)sortDescriptors
											   context:(NSManagedObjectContext*)context;

+ (NSArray*)getExistingEntityObjectsForName:(NSString*)entityName
								  predicate:(NSPredicate*)predicate
							sortDescriptors:(NSArray*)sortDescriptors;

+ (id)insertEntityObjectForName:(NSString*)entityName 
		   managedObjectContext:(NSManagedObjectContext*)managedObjectContext;

+ (id)insertEntityObjectForID:(NSManagedObjectID*)objectID 
		 managedObjectContext:(NSManagedObjectContext*)managedObjectContext;

+ (void)saveCoreData;

+ (void)importLocalData;

+ (UIView*)getAdView;


#pragma mark - 兼容iOS6和iPhone5
+ (CGSize)getScreenSize;
+ (CGRect)getScreenRect;
+ (BOOL)isIphone5;
+ (BOOL)isIpad;
+ (CGFloat)systemVersion;


#pragma mark - App Info

+ (NSString*)getAdId;
+ (NSString*)getScreenAdId;
+ (int)getScreenAdRate;
+ (NSString*)getAppURL;
+ (BOOL)isOpenAll;
+ (NSDictionary*)parseToDictionary:(NSString*)jsonString;

@end
