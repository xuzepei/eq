//
//  FDEQViewController.h
//  Food
//
//  Created by xuzepei on 10/11/11.
//  Copyright 2011 Rumtel Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FDEQViewController : UIViewController {
	
	NSMutableArray* _itemArray;
	
}

@property(nonatomic,retain)NSMutableArray* _itemArray;

- (void)updateContent:(NSDictionary*)dict;

@end
