//
//  FDEQDetailViewController.m
//  Food
//
//  Created by xuzepei on 10/12/11.
//  Copyright 2011 Rumtel Co.,Ltd. All rights reserved.
//

#import "FDEQDetailViewController.h"
#import "RCTool.h"
#import "FDEQDetailView.h"
#import "FDEQResultView.h"

@implementation FDEQDetailViewController
@synthesize _itemArray;
@synthesize _detailView;
@synthesize _resultView;
@synthesize _timeLabel;
@synthesize _scrollView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
		_itemArray = [[NSMutableArray alloc] init];
		
		if(NO == [RCTool isIpad])
		{
			self.view.frame = CGRectMake(0,0,320,460);
		}
		else
		{
			self.view.frame = CGRectMake(0,0,768,1004);
		}
        
        //self.view.frame = CGRectMake(0,0,[RCTool getScreenSize].width,[RCTool getScreenSize].height);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAdView:) name:@"ADD_AD_NOTIFICATION" object:nil];
		
		NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1
								target:self 
							  selector:@selector(handleTimer:) 
							  userInfo:nil 
							   repeats:YES];
		[timer fire];
		
    }
    return self;
}

- (void)addAdView:(NSNotification*)noti
{
    UIView* adView = [RCTool getAdView];
	if(adView)
	{
		CGRect rect = adView.frame;
        rect.origin.y = self.view.frame.size.height - rect.size.height;
		
		adView.frame = rect;
		
		[self.view addSubview:adView];
	}
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
    UIView* adView = [RCTool getAdView];
    if(adView)
    {
        CGRect rect = adView.frame;
        rect.origin.y = [RCTool getScreenSize].height - rect.size.height - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT;
        
        //        if([RCTool systemVersion] >= 7.0)
        //            rect.origin.y -= STATUS_BAR_HEIGHT;
        
        adView.frame = rect;
        
        [self.view addSubview:adView];
    }
	
	if(nil == _timeLabel)
	{
		_timeLabel = [[UILabel alloc] initWithFrame:
					  CGRectMake(270, 2, 50, 40)];
		_timeLabel.text = @"25:00";
		_timeLabel.backgroundColor = [UIColor clearColor];
		_timeLabel.textColor = [UIColor whiteColor];
		_timeLabel.font = [UIFont boldSystemFontOfSize:15];
		
		if(NO == [RCTool isIpad])
		{
			_timeLabel.frame = CGRectMake(270, 2, 50, 40);
		}
		else
		{
			_timeLabel.frame = CGRectMake(680, 2, 50, 40);
		}
	}
		
	[self.navigationController.navigationBar addSubview: _timeLabel];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear: animated];
	
	[_timeLabel removeFromSuperview];
	
//	if(_scrollView)
//		[_scrollView removeFromSuperview];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[_itemArray release];
	[_detailView release];
	[_resultView release];
	[_scrollView release];
	[_timeLabel release];
	
    [super dealloc];
}

- (void)updateContent
{
	_index = 1;
	_timeCount = 25*60;
	self.title = [NSString stringWithFormat:NSLocalizedString(@"EQ测试(%d/33)",@""),_index];
	
	NSString* question1 = NSLocalizedString(@"请从下面的问题中,选择一个和自己最切合的答案。(点击选择)\r\r1．我有能力克服各种困难:",@"");
	NSString* question1_selection0 = @"A. 是的";
	NSNumber* question1_mark0 = [NSNumber numberWithInt:6];
	NSString* question1_selection1 = @"B. 不太确定";
	NSNumber* question1_mark1 = [NSNumber numberWithInt:3];
	NSString* question1_selection2 = @"C. 不是的";
	NSNumber* question1_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question2 = @"2. 如果我能到一个新的环境,我要把生活安排得:";
	NSString* question2_selection0 = @"A. 和从前相仿";
	NSNumber* question2_mark0 = [NSNumber numberWithInt:6];
	NSString* question2_selection1 = @"B. 不一定";
	NSNumber* question2_mark1 = [NSNumber numberWithInt:3];
	NSString* question2_selection2 = @"C. 和从前不一样";
	NSNumber* question2_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question3 = @"3. 一生中,我觉得自已能达到我所预想的目标:";
	NSString* question3_selection0 = @"A. 是的";
	NSNumber* question3_mark0 = [NSNumber numberWithInt:6];
	NSString* question3_selection1 = @"B. 不一定";
	NSNumber* question3_mark1 = [NSNumber numberWithInt:3];
	NSString* question3_selection2 = @"C. 不是的";
	NSNumber* question3_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question4 = @"4. 不知为什么,有些人总是回避或冷淡我:";
	NSString* question4_selection0 = @"A. 不是的";
	NSNumber* question4_mark0 = [NSNumber numberWithInt:6];
	NSString* question4_selection1 = @"B. 不一定";
	NSNumber* question4_mark1 = [NSNumber numberWithInt:3];
	NSString* question4_selection2 = @"C. 是的";
	NSNumber* question4_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question5 = @"5. 在大街上,我常常避开我不愿打招呼的人:";
	NSString* question5_selection0 = @"A. 从未如此";
	NSNumber* question5_mark0 = [NSNumber numberWithInt:6];
	NSString* question5_selection1 = @"B. 偶然如此";
	NSNumber* question5_mark1 = [NSNumber numberWithInt:3];
	NSString* question5_selection2 = @"C. 有时如此";
	NSNumber* question5_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question6 = @"6. 当我集中精力工作时,假使有人在旁边高谈阔论:";
	NSString* question6_selection0 = @"A. 我仍能用心工作";
	NSNumber* question6_mark0 = [NSNumber numberWithInt:6];
	NSString* question6_selection1 = @"B. 介于A、C之间";
	NSNumber* question6_mark1 = [NSNumber numberWithInt:3];
	NSString* question6_selection2 = @"C. 我不能专心且感到愤怒";
	NSNumber* question6_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question7 = @"7. 我不论到什么地方,都能清晰地辨别方向:";
	NSString* question7_selection0 = @"A. 是的";
	NSNumber* question7_mark0 = [NSNumber numberWithInt:6];
	NSString* question7_selection1 = @"B. 不一定";
	NSNumber* question7_mark1 = [NSNumber numberWithInt:3];
	NSString* question7_selection2 = @"C. 不是的";
	NSNumber* question7_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question8 = @"8. 我热爱所学的专业和所从事的工作:";
	NSString* question8_selection0 = @"A. 是的";
	NSNumber* question8_mark0 = [NSNumber numberWithInt:6];
	NSString* question8_selection1 = @"B. 不一定";
	NSNumber* question8_mark1 = [NSNumber numberWithInt:3];
	NSString* question8_selection2 = @"C. 不是的";
	NSNumber* question8_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question9 = @"9. 气候的变化不会影响我的情绪:";
	NSString* question9_selection0 = @"A. 是的";
	NSNumber* question9_mark0 = [NSNumber numberWithInt:6];
	NSString* question9_selection1 = @"B. 介于A、C之间";
	NSNumber* question9_mark1 = [NSNumber numberWithInt:3];
	NSString* question9_selection2 = @"C. 不是的";
	NSNumber* question9_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question10 = @"10. 我从不因流言蜚语而气愤:";
	NSString* question10_selection0 = @"A. 是的";
	NSNumber* question10_mark0 = [NSNumber numberWithInt:5];
	NSString* question10_selection1 = @"B. 介于A、C之间";
	NSNumber* question10_mark1 = [NSNumber numberWithInt:2];
	NSString* question10_selection2 = @"C. 不是的";
	NSNumber* question10_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question11 = @"11. 我善于控制自己的面部表情:";
	NSString* question11_selection0 = @"A. 是的";
	NSNumber* question11_mark0 = [NSNumber numberWithInt:5];
	NSString* question11_selection1 = @"B. 不太确定";
	NSNumber* question11_mark1 = [NSNumber numberWithInt:2];
	NSString* question11_selection2 = @"C. 不是的";
	NSNumber* question11_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question12 = @"12. 在就寝时,我常常:";
	NSString* question12_selection0 = @"A. 极易入睡";
	NSNumber* question12_mark0 = [NSNumber numberWithInt:5];
	NSString* question12_selection1 = @"B. 介于A、C之间";
	NSNumber* question12_mark1 = [NSNumber numberWithInt:2];
	NSString* question12_selection2 = @"C. 不易入睡";
	NSNumber* question12_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question13 = @"13. 有人侵扰我时,我:";
	NSString* question13_selection0 = @"A. 不露声色";
	NSNumber* question13_mark0 = [NSNumber numberWithInt:5];
	NSString* question13_selection1 = @"B. 介于A、C之间";
	NSNumber* question13_mark1 = [NSNumber numberWithInt:2];
	NSString* question13_selection2 = @"C. 大声抗议,以泄己愤";
	NSNumber* question13_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question14 = @"14. 在和人争辨或工作出现失误后,我常常感到震颤,精疲力竭,而不能继续安心工作:";
	NSString* question14_selection0 = @"A. 不是的";
	NSNumber* question14_mark0 = [NSNumber numberWithInt:5];
	NSString* question14_selection1 = @"B. 介于A、C之间";
	NSNumber* question14_mark1 = [NSNumber numberWithInt:2];
	NSString* question14_selection2 = @"C. 是的";
	NSNumber* question14_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question15 = @"15. 我常常被一些无谓的小事困扰:";
	NSString* question15_selection0 = @"A. 不是的";
	NSNumber* question15_mark0 = [NSNumber numberWithInt:5];
	NSString* question15_selection1 = @"B. 介于A、C之间";
	NSNumber* question15_mark1 = [NSNumber numberWithInt:2];
	NSString* question15_selection2 = @"C. 是的";
	NSNumber* question15_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question16 = @"16. 我宁愿住在僻静的郊区,也不愿住在嘈杂的市区:";
	NSString* question16_selection0 = @"A. 不是的";
	NSNumber* question16_mark0 = [NSNumber numberWithInt:5];
	NSString* question16_selection1 = @"B. 不太确定";
	NSNumber* question16_mark1 = [NSNumber numberWithInt:2];
	NSString* question16_selection2 = @"C. 是的";
	NSNumber* question16_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question17 = @"17. 我被朋友、同事起过绰号、讥讽过:";
	NSString* question17_selection0 = @"A. 从来没有";
	NSNumber* question17_mark0 = [NSNumber numberWithInt:5];
	NSString* question17_selection1 = @"B. 偶尔有过";
	NSNumber* question17_mark1 = [NSNumber numberWithInt:2];
	NSString* question17_selection2 = @"C. 这是常有的事";
	NSNumber* question17_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question18 = @"18. 有一种食物使我吃后呕吐:";
	NSString* question18_selection0 = @"A. 没有";
	NSNumber* question18_mark0 = [NSNumber numberWithInt:5];
	NSString* question18_selection1 = @"B. 记不清";
	NSNumber* question18_mark1 = [NSNumber numberWithInt:2];
	NSString* question18_selection2 = @"C. 有";
	NSNumber* question18_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question19 = @"19. 除去看见的世界外,我的心中没有另外的世界:";
	NSString* question19_selection0 = @"A. 没有";
	NSNumber* question19_mark0 = [NSNumber numberWithInt:5];
	NSString* question19_selection1 = @"B. 记不清";
	NSNumber* question19_mark1 = [NSNumber numberWithInt:2];
	NSString* question19_selection2 = @"C. 有";
	NSNumber* question19_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question20 = @"20. 我会想到若干年后有什么使自己极为不安的事:";
	NSString* question20_selection0 = @"A. 从来没有想过";
	NSNumber* question20_mark0 = [NSNumber numberWithInt:5];
	NSString* question20_selection1 = @"B. 偶尔想到过";
	NSNumber* question20_mark1 = [NSNumber numberWithInt:2];
	NSString* question20_selection2 = @"C. 经常想到";
	NSNumber* question20_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question21 = @"21. 我常常觉得自己的家庭对自己不好,但是我又确切地认识他们的确对我好:";
	NSString* question21_selection0 = @"A. 否";
	NSNumber* question21_mark0 = [NSNumber numberWithInt:5];
	NSString* question21_selection1 = @"B. 说不清楚";
	NSNumber* question21_mark1 = [NSNumber numberWithInt:2];
	NSString* question21_selection2 = @"C. 是";
	NSNumber* question21_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question22 = @"22. 天天我一回家就马上把门关上:";
	NSString* question22_selection0 = @"A. 否";
	NSNumber* question22_mark0 = [NSNumber numberWithInt:5];
	NSString* question22_selection1 = @"B. 不清楚";
	NSNumber* question22_mark1 = [NSNumber numberWithInt:2];
	NSString* question22_selection2 = @"C. 是";
	NSNumber* question22_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question23 = @"23. 我坐在小房间里把门关上,但我仍觉得心里不安:";
	NSString* question23_selection0 = @"A. 否";
	NSNumber* question23_mark0 = [NSNumber numberWithInt:5];
	NSString* question23_selection1 = @"B. 偶尔是";
	NSNumber* question23_mark1 = [NSNumber numberWithInt:2];
	NSString* question23_selection2 = @"C. 是";
	NSNumber* question23_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question24 = @"24. 当一件事需要我作决定时,我常觉得很难:";
	NSString* question24_selection0 = @"A. 否";
	NSNumber* question24_mark0 = [NSNumber numberWithInt:5];
	NSString* question24_selection1 = @"B. 偶尔是";
	NSNumber* question24_mark1 = [NSNumber numberWithInt:2];
	NSString* question24_selection2 = @"C. 是";
	NSNumber* question24_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question25 = @"25. 我常常用抛硬币、翻纸、抽签之类的游戏来猜测凶吉:";
	NSString* question25_selection0 = @"A. 否";
	NSNumber* question25_mark0 = [NSNumber numberWithInt:5];
	NSString* question25_selection1 = @"B. 偶尔是";
	NSNumber* question25_mark1 = [NSNumber numberWithInt:2];
	NSString* question25_selection2 = @"C. 是";
	NSNumber* question25_mark2 = [NSNumber numberWithInt:0];
	
	NSString* question26 = @"26. 为了工作我早出晚归,早晨起床我常常感到疲劳不堪:";
	NSString* question26_selection0 = @"A. 是";
	NSNumber* question26_mark0 = [NSNumber numberWithInt:0];
	NSString* question26_selection1 = @"B. 否";
	NSNumber* question26_mark1 = [NSNumber numberWithInt:5];
	
	NSString* question27 = @"27. 在某种心境下我会因为困惑陷入空想将工作搁置下来:";
	NSString* question27_selection0 = @"A. 是";
	NSNumber* question27_mark0 = [NSNumber numberWithInt:0];
	NSString* question27_selection1 = @"B. 否";
	NSNumber* question27_mark1 = [NSNumber numberWithInt:5];
	
	NSString* question28 = @"28. 我的神经脆弱稍有刺激就会使我战栗:";
	NSString* question28_selection0 = @"A. 是";
	NSNumber* question28_mark0 = [NSNumber numberWithInt:0];
	NSString* question28_selection1 = @"B. 否";
	NSNumber* question28_mark1 = [NSNumber numberWithInt:5];
	
	NSString* question29 = @"29. 睡梦中我常常被噩梦惊醒:";
	NSString* question29_selection0 = @"A. 是";
	NSNumber* question29_mark0 = [NSNumber numberWithInt:0];
	NSString* question29_selection1 = @"B. 否";
	NSNumber* question29_mark1 = [NSNumber numberWithInt:5];
	
	NSString* question30 = @"30. 工作中我愿意挑战艰巨的任务:";
	NSString* question30_selection0 = @"A. 从不";
	NSNumber* question30_mark0 = [NSNumber numberWithInt:1];
	NSString* question30_selection1 = @"B. 几乎不";
	NSNumber* question30_mark1 = [NSNumber numberWithInt:2];
	NSString* question30_selection2 = @"C. 一半时间";
	NSNumber* question30_mark2 = [NSNumber numberWithInt:3];
	NSString* question30_selection3 = @"D. 大多数时间";
	NSNumber* question30_mark3 = [NSNumber numberWithInt:4];
	NSString* question30_selection4 = @"E. 总是";
	NSNumber* question30_mark4 = [NSNumber numberWithInt:5];
	
	NSString* question31 = @"31. 我常发现别人好的意愿:";
	NSString* question31_selection0 = @"A. 从不";
	NSNumber* question31_mark0 = [NSNumber numberWithInt:1];
	NSString* question31_selection1 = @"B. 几乎不";
	NSNumber* question31_mark1 = [NSNumber numberWithInt:2];
	NSString* question31_selection2 = @"C. 一半时间";
	NSNumber* question31_mark2 = [NSNumber numberWithInt:3];
	NSString* question31_selection3 = @"D. 大多数时间";
	NSNumber* question31_mark3 = [NSNumber numberWithInt:4];
	NSString* question31_selection4 = @"E. 总是";
	NSNumber* question31_mark4 = [NSNumber numberWithInt:5];
	
	NSString* question32 = @"32. 能听取不同的意见,包括对自己的批评:";
	NSString* question32_selection0 = @"A. 从不";
	NSNumber* question32_mark0 = [NSNumber numberWithInt:1];
	NSString* question32_selection1 = @"B. 几乎不";
	NSNumber* question32_mark1 = [NSNumber numberWithInt:2];
	NSString* question32_selection2 = @"C. 一半时间";
	NSNumber* question32_mark2 = [NSNumber numberWithInt:3];
	NSString* question32_selection3 = @"D. 大多数时间";
	NSNumber* question32_mark3 = [NSNumber numberWithInt:4];
	NSString* question32_selection4 = @"E. 总是";
	NSNumber* question32_mark4 = [NSNumber numberWithInt:5];
	
	NSString* question33 = @"33. 我时常勉励自己,对未来充满希望:";
	NSString* question33_selection0 = @"A. 从不";
	NSNumber* question33_mark0 = [NSNumber numberWithInt:1];
	NSString* question33_selection1 = @"B. 几乎不";
	NSNumber* question33_mark1 = [NSNumber numberWithInt:2];
	NSString* question33_selection2 = @"C. 一半时间";
	NSNumber* question33_mark2 = [NSNumber numberWithInt:3];
	NSString* question33_selection3 = @"D. 大多数时间";
	NSNumber* question33_mark3 = [NSNumber numberWithInt:4];
	NSString* question33_selection4 = @"E. 总是";
	NSNumber* question33_mark4 = [NSNumber numberWithInt:5];
	
	
	_itemArray = [[NSMutableArray alloc] init];
	
	//1
	NSMutableDictionary* item = [[NSMutableDictionary alloc] init];
	[item setObject:question1 forKey:@"question"];
	NSMutableArray* selectionArray = [[NSMutableArray alloc] init];
	NSMutableDictionary* selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question1_selection0 forKey:@"text"];
	[selection setObject:question1_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question1_selection1 forKey:@"text"];
	[selection setObject:question1_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question1_selection2 forKey:@"text"];
	[selection setObject:question1_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//2
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question2 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question2_selection0 forKey:@"text"];
	[selection setObject:question2_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question2_selection1 forKey:@"text"];
	[selection setObject:question2_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question2_selection2 forKey:@"text"];
	[selection setObject:question2_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//3
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question3 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question3_selection0 forKey:@"text"];
	[selection setObject:question3_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question3_selection1 forKey:@"text"];
	[selection setObject:question3_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question3_selection2 forKey:@"text"];
	[selection setObject:question3_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//4
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question4 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question4_selection0 forKey:@"text"];
	[selection setObject:question4_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question4_selection1 forKey:@"text"];
	[selection setObject:question4_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question4_selection2 forKey:@"text"];
	[selection setObject:question4_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//5
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question5 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question5_selection0 forKey:@"text"];
	[selection setObject:question5_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question5_selection1 forKey:@"text"];
	[selection setObject:question5_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question5_selection2 forKey:@"text"];
	[selection setObject:question5_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//6
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question6 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question6_selection0 forKey:@"text"];
	[selection setObject:question6_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question6_selection1 forKey:@"text"];
	[selection setObject:question6_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question6_selection2 forKey:@"text"];
	[selection setObject:question6_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//7
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question7 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question7_selection0 forKey:@"text"];
	[selection setObject:question7_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question7_selection1 forKey:@"text"];
	[selection setObject:question7_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question7_selection2 forKey:@"text"];
	[selection setObject:question7_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//8
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question8 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question8_selection0 forKey:@"text"];
	[selection setObject:question8_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question8_selection1 forKey:@"text"];
	[selection setObject:question8_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question8_selection2 forKey:@"text"];
	[selection setObject:question8_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//9
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question9 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question9_selection0 forKey:@"text"];
	[selection setObject:question9_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question9_selection1 forKey:@"text"];
	[selection setObject:question9_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question9_selection2 forKey:@"text"];
	[selection setObject:question9_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//10
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question10 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question10_selection0 forKey:@"text"];
	[selection setObject:question10_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question10_selection1 forKey:@"text"];
	[selection setObject:question10_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question10_selection2 forKey:@"text"];
	[selection setObject:question10_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//11
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question11 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question11_selection0 forKey:@"text"];
	[selection setObject:question11_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question11_selection1 forKey:@"text"];
	[selection setObject:question11_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question11_selection2 forKey:@"text"];
	[selection setObject:question11_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//12
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question12 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question12_selection0 forKey:@"text"];
	[selection setObject:question12_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question12_selection1 forKey:@"text"];
	[selection setObject:question12_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question12_selection2 forKey:@"text"];
	[selection setObject:question12_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//13
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question13 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question13_selection0 forKey:@"text"];
	[selection setObject:question13_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question13_selection1 forKey:@"text"];
	[selection setObject:question13_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question13_selection2 forKey:@"text"];
	[selection setObject:question13_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//14
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question14 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question14_selection0 forKey:@"text"];
	[selection setObject:question14_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question14_selection1 forKey:@"text"];
	[selection setObject:question14_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question14_selection2 forKey:@"text"];
	[selection setObject:question14_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//15
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question15 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question15_selection0 forKey:@"text"];
	[selection setObject:question15_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question15_selection1 forKey:@"text"];
	[selection setObject:question15_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question15_selection2 forKey:@"text"];
	[selection setObject:question15_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//16
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question16 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question16_selection0 forKey:@"text"];
	[selection setObject:question16_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question16_selection1 forKey:@"text"];
	[selection setObject:question16_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question16_selection2 forKey:@"text"];
	[selection setObject:question16_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	
	//17
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question17 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question17_selection0 forKey:@"text"];
	[selection setObject:question17_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question17_selection1 forKey:@"text"];
	[selection setObject:question17_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question17_selection2 forKey:@"text"];
	[selection setObject:question17_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	
	//18
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question18 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question18_selection0 forKey:@"text"];
	[selection setObject:question18_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question18_selection1 forKey:@"text"];
	[selection setObject:question18_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question18_selection2 forKey:@"text"];
	[selection setObject:question18_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	
	//19
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question19 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question19_selection0 forKey:@"text"];
	[selection setObject:question19_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question19_selection1 forKey:@"text"];
	[selection setObject:question19_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question19_selection2 forKey:@"text"];
	[selection setObject:question19_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//20
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question20 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question20_selection0 forKey:@"text"];
	[selection setObject:question20_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question20_selection1 forKey:@"text"];
	[selection setObject:question20_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question20_selection2 forKey:@"text"];
	[selection setObject:question20_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//21
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question21 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question21_selection0 forKey:@"text"];
	[selection setObject:question21_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question21_selection1 forKey:@"text"];
	[selection setObject:question21_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question21_selection2 forKey:@"text"];
	[selection setObject:question21_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//22
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question22 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question22_selection0 forKey:@"text"];
	[selection setObject:question22_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question22_selection1 forKey:@"text"];
	[selection setObject:question22_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question22_selection2 forKey:@"text"];
	[selection setObject:question22_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//23
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question23 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question23_selection0 forKey:@"text"];
	[selection setObject:question23_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question23_selection1 forKey:@"text"];
	[selection setObject:question23_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question23_selection2 forKey:@"text"];
	[selection setObject:question23_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//24
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question24 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question24_selection0 forKey:@"text"];
	[selection setObject:question24_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question24_selection1 forKey:@"text"];
	[selection setObject:question24_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question24_selection2 forKey:@"text"];
	[selection setObject:question24_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//25
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question25 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question25_selection0 forKey:@"text"];
	[selection setObject:question25_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question25_selection1 forKey:@"text"];
	[selection setObject:question25_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question25_selection2 forKey:@"text"];
	[selection setObject:question25_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//26
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question26 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question26_selection0 forKey:@"text"];
	[selection setObject:question26_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question26_selection1 forKey:@"text"];
	[selection setObject:question26_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//27
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question27 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question27_selection0 forKey:@"text"];
	[selection setObject:question27_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question27_selection1 forKey:@"text"];
	[selection setObject:question27_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//28
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question28 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question28_selection0 forKey:@"text"];
	[selection setObject:question28_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question28_selection1 forKey:@"text"];
	[selection setObject:question28_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//29
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question29 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question29_selection0 forKey:@"text"];
	[selection setObject:question29_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question29_selection1 forKey:@"text"];
	[selection setObject:question29_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//30
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question30 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question30_selection0 forKey:@"text"];
	[selection setObject:question30_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question30_selection1 forKey:@"text"];
	[selection setObject:question30_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question30_selection2 forKey:@"text"];
	[selection setObject:question30_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question30_selection3 forKey:@"text"];
	[selection setObject:question30_mark3 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question30_selection4 forKey:@"text"];
	[selection setObject:question30_mark4 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//31
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question31 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question31_selection0 forKey:@"text"];
	[selection setObject:question31_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question31_selection1 forKey:@"text"];
	[selection setObject:question31_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question31_selection2 forKey:@"text"];
	[selection setObject:question31_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question31_selection3 forKey:@"text"];
	[selection setObject:question31_mark3 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question31_selection4 forKey:@"text"];
	[selection setObject:question31_mark4 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//32
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question32 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question32_selection0 forKey:@"text"];
	[selection setObject:question32_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question32_selection1 forKey:@"text"];
	[selection setObject:question32_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question32_selection2 forKey:@"text"];
	[selection setObject:question32_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question32_selection3 forKey:@"text"];
	[selection setObject:question32_mark3 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question32_selection4 forKey:@"text"];
	[selection setObject:question32_mark4 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	//33
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question33 forKey:@"question"];
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question33_selection0 forKey:@"text"];
	[selection setObject:question33_mark0 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question33_selection1 forKey:@"text"];
	[selection setObject:question33_mark1 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question33_selection2 forKey:@"text"];
	[selection setObject:question33_mark2 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question33_selection3 forKey:@"text"];
	[selection setObject:question33_mark3 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question33_selection4 forKey:@"text"];
	[selection setObject:question33_mark4 forKey:@"mark"];
	[selectionArray addObject: selection];
	[selection release];
	
	[item setObject:selectionArray forKey:@"selections"];
	[selectionArray release];
	[_itemArray addObject:item];
	[item release];
	
	_detailView = [[FDEQDetailView alloc] initWithFrame:self.view.bounds];
	_detailView._delegate = self;
	[_detailView updateContent:[_itemArray objectAtIndex:0] index:_index];
	[self.view addSubview: _detailView];
	
}

- (void)clickPreviousButton
{
	if(_index > 1)
	{
		_index--;
		
		if(_detailView)
		{
			[_detailView updateContent:[_itemArray objectAtIndex:_index - 1] 
								 index:_index];
		}
		
		self.title = [NSString stringWithFormat:@"EQ测试(%d/33)",_index];
	}
}

- (void)clickNextButton
{
	if(_index < 33)
	{
		_index++;
		
		if(_detailView)
		{
			[_detailView updateContent:[_itemArray objectAtIndex:_index - 1] 
								 index:_index];
		}
		
		self.title = [NSString stringWithFormat:@"EQ测试(%d/33)",_index];
	}
}

- (void)clickResultButton
{
	self.title = @"EQ测试结果";
	_timeLabel.hidden = YES;
	
	if(_detailView)
	[_detailView removeFromSuperview];
	
	if(nil == _scrollView)
	{
		if(NO == [RCTool isIpad])
		{
			_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,
																		 self.view.frame.size.width,
																		 self.view.frame.size.height - 50)];

			[_scrollView setContentSize:CGSizeMake([RCTool getScreenSize].width, [RCTool getScreenSize].height+200)];
			
			
			if(nil == _resultView)
			{
				_resultView = [[FDEQResultView alloc] initWithFrame:CGRectMake(0,0,
																			   self.view.frame.size.width,
																			   [RCTool getScreenSize].height+200)];
			}
		}
		else
		{
			_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,
																		 self.view.frame.size.width,
																		 self.view.frame.size.height - 90)];
			
			[_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, [RCTool getScreenSize].height+400)];
			
			
			if(nil == _resultView)
			{
				_resultView = [[FDEQResultView alloc] initWithFrame:CGRectMake(0,0,
																			   self.view.frame.size.width,
																			   [RCTool getScreenSize].height+400)];
			}
		}

		
		[_scrollView addSubview: _resultView];
	}
	
	int score = 0;
	
	for(NSDictionary* item in _itemArray)
	{
		int selectedIndex = -1;
		NSNumber* selectedIndexNum = [item objectForKey:@"selectedIndex"];
		if(selectedIndexNum)
			selectedIndex = [selectedIndexNum intValue];
		
		if(-1 == selectedIndex)
			continue;
		
		NSArray* selections = [item objectForKey:@"selections"];
		if(selectedIndex >= [selections count])
			continue;
		
		NSDictionary* selection = [selections objectAtIndex:selectedIndex];
		if(selection)
		{
			NSNumber* markNum = [selection objectForKey:@"mark"];
			score += [markNum intValue];
		}
		
	}
	
	if(_resultView)
		[_resultView updateContent:score];
	
	[self.view insertSubview:_scrollView atIndex:1];
}

- (void)handleTimer:(NSTimer*)timer
{
	if(_timeCount > -1)
		_timeCount--;
	
	if(_timeLabel)
	{
		if(_timeCount >= 0)
		{
			_timeLabel.text = [NSString stringWithFormat:@"%02d:%02d",
							   _timeCount / 60, _timeCount % 60];
		}
		else
			_timeLabel.text = @"已超时";
	}
	
}


@end
