//
//  RCTool.m
//  rsscoffee
//
//  Created by beer on 8/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RCTool.h"
#import "FoodAppDelegate.h"
#import "Reachability.h"
#import "Book.h"
#import <CommonCrypto/CommonDigest.h>
#import "NTDB.h"
#import "SBJSON.h"

static int g_reachabilityType = -1;


@implementation RCTool

+ (NSString*)getUserDocumentDirectoryPath
{
	NSArray* array = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
	if([array count])
		return [array objectAtIndex: 0];
	else
		return @"";
}

+ (NSString *)md5:(NSString *)str 
{
	const char *cStr = [str UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];	
}


#pragma mark -
#pragma mark network

+ (void)setReachabilityType:(int)type
{
	g_reachabilityType = type;
}

+ (int)getReachabilityType
{
	return g_reachabilityType;
}

+ (BOOL)isReachableViaInternet
{
	Reachability* internetReach = [Reachability reachabilityForInternetConnection];
	[internetReach startNotifier];
	NetworkStatus netStatus = [internetReach currentReachabilityStatus];
	switch (netStatus)
    {
        case NotReachable:
        {
            return NO;
        }
        case ReachableViaWWAN:
        {
            return YES;
        }
        case ReachableViaWiFi:
        {
			return YES;
		}
		default:
			return NO;
	}
	
	return NO;
}

+ (BOOL)isReachableViaWiFi
{
	Reachability* internetReach = [Reachability reachabilityForInternetConnection];
	[internetReach startNotifier];
	NetworkStatus netStatus = [internetReach currentReachabilityStatus];
	switch (netStatus)
    {
        case NotReachable:
        {
            return NO;
        }
        case ReachableViaWWAN:
        {
            return NO;
        }
        case ReachableViaWiFi:
        {
			return YES;
		}
		default:
			return NO;
	}
	
	return NO;
}

+ (BOOL)isExistingFile:(NSString*)path
{
	if(0 == [path length])
		return NO;
	
	NSFileManager* fileManager = [NSFileManager defaultManager];
	return [fileManager fileExistsAtPath:path];
}

+ (NSPersistentStoreCoordinator*)getPersistentStoreCoordinator
{
	FoodAppDelegate* appDelegate = (FoodAppDelegate*)[[UIApplication sharedApplication] delegate];
	return [appDelegate persistentStoreCoordinator];
}

+ (NSManagedObjectContext*)getManagedObjectContext
{
	FoodAppDelegate* appDelegate = (FoodAppDelegate*)[[UIApplication sharedApplication] delegate];
	return [appDelegate managedObjectContext];
}

+ (NSManagedObjectID*)getExistingEntityObjectIDForName:(NSString*)entityName
											 predicate:(NSPredicate*)predicate
									   sortDescriptors:(NSArray*)sortDescriptors
											   context:(NSManagedObjectContext*)context

{
	if(0 == [entityName length] || nil == context)
		return nil;
	
	//NSManagedObjectContext* context = [RCTool getManagedObjectContext];
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
											  inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	
	//sortDescriptors 是必传属性
	NSArray *temp = [NSArray arrayWithArray: sortDescriptors];
	[fetchRequest setSortDescriptors:temp];
	
	
	//set predicate
	[fetchRequest setPredicate:predicate];
	
	//设置返回类型
	[fetchRequest setResultType:NSManagedObjectIDResultType];
	
	
	//	NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] 
	//															initWithFetchRequest:fetchRequest 
	//															managedObjectContext:context 
	//															sectionNameKeyPath:nil 
	//															cacheName:@"Root"];
	//	
	//	//[context tryLock];
	//	[fetchedResultsController performFetch:nil];
	//	//[context unlock];
	
	NSArray* objectIDs = [context executeFetchRequest:fetchRequest error:nil];
	
	[fetchRequest release];
	
	if(objectIDs && [objectIDs count])
		return [objectIDs lastObject];
	else
		return nil;
}

+ (NSArray*)getExistingEntityObjectsForName:(NSString*)entityName
								  predicate:(NSPredicate*)predicate
							sortDescriptors:(NSArray*)sortDescriptors
{
	if(0 == [entityName length])
		return nil;
	
	NSManagedObjectContext* context = [RCTool getManagedObjectContext];
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
											  inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	
	//sortDescriptors 是必传属性
	if(nil == sortDescriptors)
	{
		NSArray *temp = [NSArray arrayWithArray: sortDescriptors];
		[fetchRequest setSortDescriptors:temp];
	}
	else
		[fetchRequest setSortDescriptors:sortDescriptors];

	
	
	//set predicate
	[fetchRequest setPredicate:predicate];
	
	//设置返回类型
	[fetchRequest setResultType:NSManagedObjectResultType];
	
	NSArray* objects = [context executeFetchRequest:fetchRequest error:nil];
	
	[fetchRequest release];
	
	return objects;
}

+ (id)insertEntityObjectForName:(NSString*)entityName 
		   managedObjectContext:(NSManagedObjectContext*)managedObjectContext;
{
	if(0 == [entityName length] || nil == managedObjectContext)
		return nil;
	
	NSManagedObjectContext* context = managedObjectContext;
	id entityObject = [NSEntityDescription insertNewObjectForEntityForName:entityName 
													inManagedObjectContext:context];
	
	
	return entityObject;
	
}

+ (id)insertEntityObjectForID:(NSManagedObjectID*)objectID 
		 managedObjectContext:(NSManagedObjectContext*)managedObjectContext;
{
	if(nil == objectID || nil == managedObjectContext)
		return nil;
	
	return [managedObjectContext objectWithID:objectID];
}

+ (void)saveCoreData
{
	FoodAppDelegate* appDelegate = (FoodAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSError *error = nil;
    if ([appDelegate managedObjectContext] != nil) 
	{
        if ([[appDelegate managedObjectContext] hasChanges] && ![[appDelegate managedObjectContext] save:&error]) 
		{

        } 
    }
}

+ (void)importLocalData
{
	NSArray* bookArray = [RCTool getExistingEntityObjectsForName:@"Book"
													   predicate:nil
												 sortDescriptors:nil];
	if([bookArray count])
		return;
	
	NSArray* array = [NTDB getRecords:@"Book" fields:[NSArray arrayWithObjects:@"id", 
													  @"type", @"title", 
													  @"desc", @"content", @"segment_id",@"ishidden",@"isnew",nil] option:@""];
	
	if([array count])
	{
		for(NSDictionary* temp in array)
		{
			NSString* idString = [temp objectForKey:@"id"];
			if(0 == [idString length])
				continue;
			
			NSManagedObjectContext* insertionContext = [RCTool getManagedObjectContext];
			NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id = %@",idString];
			NSManagedObjectID* objectID = [RCTool getExistingEntityObjectIDForName: @"Book"
																		 predicate: predicate
																   sortDescriptors: nil
																		   context: insertionContext];
			
			
			Book* book = nil;
			if(nil == objectID)
			{
				book = [RCTool insertEntityObjectForName:@"Book" 
									managedObjectContext:insertionContext];
			}
			else
			{
				book = (Book*)[RCTool insertEntityObjectForID:objectID
										 managedObjectContext:insertionContext];
			}
			
			book.id = idString;
			book.title = [temp objectForKey:@"title"];
			book.desc = [temp objectForKey:@"desc"];
			book.type = [temp objectForKey:@"type"];
			book.content = [temp objectForKey:@"content"];
			book.segment_id = [temp objectForKey:@"segment_id"];
			
			NSString* isHidden = [temp objectForKey:@"ishidden"];
			if([isHidden isEqualToString:@"1"])
				book.isHidden = [NSNumber numberWithBool:YES];
			
			NSString* isNew = [temp objectForKey:@"isnew"];
			if([isNew isEqualToString:@"1"])
				book.isNew = [NSNumber numberWithBool:YES];
		}
		
		[RCTool saveCoreData];
	}
}

+ (UIView*)getAdView
{
	FoodAppDelegate* appDelegate = (FoodAppDelegate*)[[UIApplication sharedApplication] delegate];
	UIView* adView = appDelegate.adMobAd;
	if(adView)
		return adView;
	
	return nil;
}

#pragma mark - 兼容iOS6和iPhone5

+ (CGSize)getScreenSize
{
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGRect)getScreenRect
{
    return [[UIScreen mainScreen] bounds];
}

+ (BOOL)isIphone5
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize size = [[UIScreen mainScreen] bounds].size;
        if(568 == size.height)
        {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isIpad
{
	UIDevice* device = [UIDevice currentDevice];
	if(device.userInterfaceIdiom == UIUserInterfaceIdiomPhone)
	{
		return NO;
	}
	else if(device.userInterfaceIdiom == UIUserInterfaceIdiomPad)
	{
		return YES;
	}
	
	return NO;
}

+ (CGFloat)systemVersion
{
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    return systemVersion;
}

#pragma mark - App Info

+ (NSString*)getAdId
{
    NSDictionary* app_info = [[NSUserDefaults standardUserDefaults] objectForKey:@"app_info"];
    if(app_info && [app_info isKindOfClass:[NSDictionary class]])
    {
        NSString* ad_id = [app_info objectForKey:@"ad_id"];
        if([ad_id length])
            return ad_id;
    }
    
    return AD_ID;
}

+ (NSString*)getScreenAdId
{
    NSDictionary* app_info = [[NSUserDefaults standardUserDefaults] objectForKey:@"app_info"];
    if(app_info && [app_info isKindOfClass:[NSDictionary class]])
    {
        NSString* ad_id = [app_info objectForKey:@"mediation_id"];
        if(0 == [ad_id length])
            ad_id = [app_info objectForKey:@"screen_ad_id"];
        
        if([ad_id length])
            return ad_id;
    }
    
    return SCREEN_AD_ID;
}

+ (int)getScreenAdRate
{
    NSDictionary* app_info = [[NSUserDefaults standardUserDefaults] objectForKey:@"app_info"];
    if(app_info && [app_info isKindOfClass:[NSDictionary class]])
    {
        NSString* ad_rate = [app_info objectForKey:@"screen_ad_rate"];
        if([ad_rate intValue] > 0)
            return [ad_rate intValue];
    }
    
    return SCREEN_AD_RATE;
}

+ (NSString*)getAppURL
{
    NSDictionary* app_info = [[NSUserDefaults standardUserDefaults] objectForKey:@"app_info"];
    if(app_info && [app_info isKindOfClass:[NSDictionary class]])
    {
        NSString* link = [app_info objectForKey:@"link"];
        if([link length])
            return link;
    }
    
    return APP_URL;
}

+ (BOOL)isOpenAll
{
    NSDictionary* app_info = [[NSUserDefaults standardUserDefaults] objectForKey:@"app_info"];
    if(app_info && [app_info isKindOfClass:[NSDictionary class]])
    {
        NSString* openall = [app_info objectForKey:@"openall"];
        if([openall isEqualToString:@"1"])
            return YES;
    }
    else
    {
        NSDate* date = [[[NSDate alloc] initWithString:@"2014-04-1 12:06:04 +0800"] autorelease];
        NSDate* startDate = [NSDate date];
        
        if([startDate timeIntervalSinceDate:date] >= 14*24*60*60)
        {
            return YES;
        }
    }
    
    return NO;
}


+ (NSDictionary*)parseToDictionary:(NSString*)jsonString
{
    if(0 == [jsonString length])
		return nil;
    
    
	SBJSON* sbjson = [[SBJSON alloc] init];
    
    NSError* error = nil;
	NSDictionary* dict = [sbjson objectWithString:jsonString error:&error];
    
    if(error)
        NSLog(@"error:%@",[error description]);
	
	if(dict && [dict isKindOfClass:[NSDictionary class]])
	{
        [sbjson release];
        return dict;
	}
	
	[sbjson release];
    
	return nil;
}

@end
