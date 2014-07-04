//
//  FDEQStartView.m
//  Food
//
//  Created by xuzepei on 10/11/11.
//  Copyright 2011 Rumtel Co.,Ltd. All rights reserved.
//

#import "FDEQStartView.h"
#import "RCTool.h"

@implementation FDEQStartView


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
    
	NSString* text = NSLocalizedString(@"情商(EQ)又称情绪智力,是近年来心理学家们提出的与智商相对应的概念。它主要是指人在情绪、情感、意志、耐受挫折等方面的品质。以往认为,一个人能否在一生中取得成就,智力水平是第一重要的,即智商IQ越高,取得成就的可能性就越大。但现在专家普遍认为,情商水平的高低对一个人能否取得成功也有着重大的影响作用。\r\r本套题为专业EQ测试题,共33题,测试时间25分钟,最大EQ为174分。请不要紧张,自己平时是怎样的反映就怎样回答,不要刻意。这样的成绩才真实有效。",@"");

	if(NO == [RCTool isIpad])
	{
		[text drawInRect:CGRectMake(10,10,self.bounds.size.width - 20,self.bounds.size.height - 80) withFont:[UIFont systemFontOfSize:16]];
	}
	else
	{
		[text drawInRect:CGRectMake(40,40,self.bounds.size.width - 40*2,self.bounds.size.height) withFont:[UIFont systemFontOfSize:26]];
		
	}
	
}


- (void)dealloc {
    [super dealloc];
}


@end
