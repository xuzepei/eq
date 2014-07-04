//
//  FDEQResultView.h
//  Food
//
//  Created by xuzepei on 10/14/11.
//  Copyright 2011 Rumtel Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FDEQResultView : UIView {
	
	int _score;
	NSString* _information;

}

@property(nonatomic,retain)NSString* _information;

- (void)updateContent:(int)score;

@end
