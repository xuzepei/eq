//
//  FDEQDetailView.h
//  Food
//
//  Created by xuzepei on 10/12/11.
//  Copyright 2011 Rumtel Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDEQDetailViewController;
@interface FDEQDetailView : UIView {
	
	NSMutableDictionary* _item;
	CGFloat _offset_y;
	
	UIButton* _button0;
	UIButton* _button1;
	UIButton* _button2;
	UIButton* _button3;
	UIButton* _button4;
	
	UIButton* _previous;
	UIButton* _next;
	UIButton* _resultButton;
	
	int _index;
	int _selectedIndex;
	
	FDEQDetailViewController* _delegate;
}

@property(nonatomic,retain)NSMutableDictionary* _item;

@property(nonatomic,retain)UIButton* _button0;
@property(nonatomic,retain)UIButton* _button1;
@property(nonatomic,retain)UIButton* _button2;
@property(nonatomic,retain)UIButton* _button3;
@property(nonatomic,retain)UIButton* _button4;

@property(nonatomic,retain)UIButton* _previous;
@property(nonatomic,retain)UIButton* _next;
@property(nonatomic,retain)UIButton* _resultButton;

@property(nonatomic,retain)FDEQDetailViewController* _delegate;

- (void)updateContent:(NSMutableDictionary*)item index:(int)index;

@end
