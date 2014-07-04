//
//  FDEQDetailViewController.h
//  Food
//
//  Created by xuzepei on 10/12/11.
//  Copyright 2011 Rumtel Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDEQDetailView;
@class FDEQResultView;
@interface FDEQDetailViewController : UIViewController {
	
	NSMutableArray* _itemArray;
	FDEQDetailView* _detailView;
	FDEQResultView* _resultView;
	UIScrollView* _scrollView;
	UILabel* _timeLabel;

	int _index;
	int _timeCount;
}

@property(nonatomic,retain)NSMutableArray* _itemArray;
@property(nonatomic,retain)FDEQDetailView* _detailView;
@property(nonatomic,retain)FDEQResultView* _resultView;
@property(nonatomic,retain)UIScrollView* _scrollView;
@property(nonatomic,retain)UILabel* _timeLabel;

- (void)updateContent;
- (void)clickPreviousButton;
- (void)clickNextButton;
- (void)clickResultButton;

@end
