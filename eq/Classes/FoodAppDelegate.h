//
//  FoodAppDelegate.h
//  Food
//
//  Created by xuzepei on 9/27/11.
//  Copyright 2011 Rumtel Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@class FDEQViewController;
@interface FoodAppDelegate : NSObject <UIApplicationDelegate,GADBannerViewDelegate,GADInterstitialDelegate> {
    
    UIWindow *window;

	FDEQViewController* _eqViewController;
	UINavigationController* _eqNavigationController;

@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) FDEQViewController* _eqViewController;
@property (nonatomic, retain) UINavigationController* _eqNavigationController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) GADBannerView *adMobAd;
@property (assign)BOOL isAdMobVisible;
@property (nonatomic, retain) GADInterstitial *adInterstitial;

@property (nonatomic,retain) NSString* ad_id;
@property (nonatomic,assign)BOOL showFullScreenAd;
@property (nonatomic,assign)BOOL needRequestFullscreenAd;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;
- (void)showInterstitialAd:(id)argument;

@end

