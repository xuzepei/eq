//
//  FDEQResultView.m
//  Food
//
//  Created by xuzepei on 10/14/11.
//  Copyright 2011 Rumtel Co.,Ltd. All rights reserved.
//

#import "FDEQResultView.h"
#import "RCTool.h"


@implementation FDEQResultView
@synthesize _information;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	
	if(NO == [RCTool isIpad])
	{
		NSString* temp = NSLocalizedString(@"得分:",@"");
		[temp drawInRect:CGRectMake(10, 20, 100, 20) 
				withFont:[UIFont boldSystemFontOfSize:20]];
		
		NSString* mark = [NSString stringWithFormat:@"%d",_score];
		[[UIColor colorWithRed:0.04 green:0.54 blue:0.22 alpha:1.00] set];
		[mark drawInRect:CGRectMake(66, 20, 100, 20) 
				withFont:[UIFont boldSystemFontOfSize:20]];
		
		if([_information length])
		{
			[[UIColor blackColor] set];
			[_information drawInRect:CGRectMake(10, 70, 300, 800) 
							withFont:[UIFont systemFontOfSize:18]];
		}
		
	}
	else
	{
		NSString* temp = NSLocalizedString(@"得分:",@"");
		[temp drawInRect:CGRectMake(40, 40, 400, 40) 
				withFont:[UIFont boldSystemFontOfSize:34]];
		
		NSString* mark = [NSString stringWithFormat:@"%d",_score];
		[[UIColor colorWithRed:0.04 green:0.54 blue:0.22 alpha:1.00] set];
		[mark drawInRect:CGRectMake(150, 40, 400, 40) 
				withFont:[UIFont boldSystemFontOfSize:34]];
		
		if([_information length])
		{
			[[UIColor blackColor] set];
			[_information drawInRect:CGRectMake(40, 140, self.bounds.size.width - 40*2, self.bounds.size.height) 
							withFont:[UIFont systemFontOfSize:26]];
		}
		
	}
	
}


- (void)dealloc {
	
	[_information release];
	
    [super dealloc];
}

- (void)updateContent:(int)score
{
	_score = score;
	
	self._information = NSLocalizedString(@"说明: \r\r测试后如果您的得分在90分以下,说明你的EQ较低,你常常不能控制自己,你极易被自己的情绪所影响。很多时候,你轻易被击怒、动火、发脾气，这是非常危险的信号──你的事业可能会毁于你的暴躁。对于此最好的解决办法是能够给不好的东西一个好的解释,保持头脑冷静使自己心情开朗。正如富兰克林所说: \"任何人生气都是有理的,但很少有令人信服的理由。\"\
	\r\r如果你的得分在90～129分,说明你的EQ一般,对于一件事,你不同时候的表现可能不一,这与你的意识有关,你比前者更具有EQ意识,但这种意识不是常常都有,因此需要你多加注重、时时提醒。\
	\r\r如果你的得分在130～149分,说明你的EQ较高,你是一个快乐的人,不易恐惊担忧,对于工作你热情投入、敢于负责,你为人更是正义正直、同情关怀,这是你的长处,应该努力保持。\
	\r\r如果你的EQ在150分以上,那你就是个EQ高手,你的情绪聪明是你事业有成的一个重要前提条件,但如果把握不好也可能成为你事业的阻碍。",@"");
	
	[self setNeedsDisplay];
}


@end
