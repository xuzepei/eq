//
//  FDEQDetailView.m
//  Food
//
//  Created by xuzepei on 10/12/11.
//  Copyright 2011 Rumtel Co.,Ltd. All rights reserved.
//

#import "FDEQDetailView.h"
#import <QuartzCore/QuartzCore.h>
#import "FDEQDetailViewController.h"
#import "RCTool.h"
#import "FoodAppDelegate.h"

@implementation FDEQDetailView
@synthesize _item;
@synthesize _button0;
@synthesize _button1;
@synthesize _button2;
@synthesize _button3;
@synthesize _button4;
@synthesize _previous;
@synthesize _next;
@synthesize _resultButton;
@synthesize _delegate;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
	if(nil == _item)
		return;
	
	NSString* question = [_item objectForKey:@"question"];
	if([question length])
	{
		if(NO == [RCTool isIpad])
		{
			[question drawInRect:CGRectMake(10,20,[RCTool getScreenSize].width-20,100)
						withFont:[UIFont boldSystemFontOfSize:17]];
		}
		else
		{
			[question drawInRect:CGRectMake(40,40,self.bounds.size.width - 40*2,self.bounds.size.height - 40*2) 
						withFont:[UIFont boldSystemFontOfSize:28]];
		}
	}
	
}


- (void)dealloc {
	
	[_item release];
	
	[_button0 release];
	[_button1 release];
	[_button2 release];
	[_button3 release];
	[_button4 release];
	[_previous release];
	[_next release];
	[_resultButton release];
	
	[_delegate release];
	
    [super dealloc];
}

- (void)updateContent:(NSMutableDictionary*)item index:(int)index
{
	if(nil == item)
		return;
	
	self._item = item;
	_index = index;
	_selectedIndex = -1;
	[self setNeedsDisplay];
	
	CGSize size;
	if(NO == [RCTool isIpad])
	{
		size = [[_item objectForKey:@"question"] sizeWithFont:[UIFont boldSystemFontOfSize:17]
												   constrainedToSize:CGSizeMake([RCTool getScreenSize].width-20,CGFLOAT_MAX)];
		_offset_y = size.height + 30;
		
		if(nil == _previous)
		{
            CGFloat offset_y = 64.0f;
            if([RCTool isIphone5])
                offset_y = -40.0f;
            
			self._previous = [UIButton buttonWithType:UIButtonTypeCustom];
			_previous.frame = CGRectMake(10,self.frame.size.height - offset_y - 82,90,30);
			_previous.titleLabel.font = [UIFont systemFontOfSize: 16];
			_previous.layer.borderWidth = 1.0;
			_previous.layer.borderColor = [[UIColor blackColor] CGColor];
			[_previous setTitleColor:[UIColor blackColor] 
							forState:UIControlStateNormal];
			[_previous setTitleColor:[UIColor blueColor] 
							forState:UIControlStateHighlighted];
			[_previous setTitle:NSLocalizedString(@"上一题",@"")
					   forState:UIControlStateNormal];
			[_previous addTarget:self
						  action:@selector(clickPreviousButton:) 
				forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _previous];
		}
		
		_previous.hidden = (1 == _index) ? YES: NO;
		
		if(nil == _next)
		{
            CGFloat offset_y = 64.0f;
            if([RCTool isIphone5])
                offset_y = -40.0f;
            
			self._next = [UIButton buttonWithType:UIButtonTypeCustom];
			_next.frame = CGRectMake(self.frame.size.width - 100,self.frame.size.height - offset_y - 82,90,30);
			_next.titleLabel.font = [UIFont systemFontOfSize: 16];
			_next.layer.borderWidth = 1.0;
			_next.layer.borderColor = [[UIColor blackColor] CGColor];
			[_next setTitleColor:[UIColor blackColor] 
						forState:UIControlStateNormal];
			[_next setTitleColor:[UIColor blueColor] 
						forState:UIControlStateHighlighted];
			[_next setTitle:NSLocalizedString(@"下一题",@"")
				   forState:UIControlStateNormal];
			[_next addTarget:self
					  action:@selector(clickNextButton:) 
			forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _next];
		}
		
		_next.hidden = (33 == _index) ? YES: NO;
		
		if(nil == _resultButton)
		{
            CGFloat offset_y = 64.0f;
            if([RCTool isIphone5])
                offset_y = -40.0f;
            
			self._resultButton = [UIButton buttonWithType:UIButtonTypeCustom];
			_resultButton.frame = CGRectMake(self.frame.size.width - 100,self.frame.size.height - offset_y - 82,90,30);
			_resultButton.titleLabel.font = [UIFont systemFontOfSize: 16];
			_resultButton.layer.borderWidth = 1.0;
			_resultButton.layer.borderColor = [[UIColor blackColor] CGColor];
			[_resultButton setTitleColor:[UIColor blackColor] 
								forState:UIControlStateNormal];
			[_resultButton setTitleColor:[UIColor blueColor] 
								forState:UIControlStateHighlighted];
			[_resultButton setTitle:NSLocalizedString(@"完成",@"")
						   forState:UIControlStateNormal];
			[_resultButton addTarget:self
							  action:@selector(clickResultButton:) 
					forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _resultButton];
		}
		
		if(33 == _index)
			_resultButton.hidden = NO;
		else
			_resultButton.hidden = YES;
		
		if(nil == _button0)
		{
			self._button0 = [UIButton buttonWithType:UIButtonTypeCustom];
			_button0.tag = 0;
			_button0.titleLabel.font = [UIFont systemFontOfSize: 16];
			_button0.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
			[_button0 setTitleColor:[UIColor blueColor] 
						   forState:UIControlStateHighlighted];
			[_button0 addTarget:self
						 action:@selector(clickButton0:) 
			   forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _button0];
		}
		
		if(nil == _button1)
		{
			self._button1 = [UIButton buttonWithType:UIButtonTypeCustom];
			_button1.tag = 1;
			_button1.titleLabel.font = [UIFont systemFontOfSize: 16];
			_button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
			[_button1 setTitleColor:[UIColor blueColor] 
						   forState:UIControlStateHighlighted];
			[_button1 addTarget:self
						 action:@selector(clickButton1:) 
			   forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _button1];
			
			//_button1.layer.borderWidth = 1.0;
			//_button1.layer.borderColor = [[UIColor blackColor] CGColor];
		}
		
		if(nil == _button2)
		{
			self._button2 = [UIButton buttonWithType:UIButtonTypeCustom];
			_button2.tag = 2;
			_button2.titleLabel.font = [UIFont systemFontOfSize: 16];
			_button2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
			[_button2 setTitleColor:[UIColor blueColor] 
						   forState:UIControlStateHighlighted];
			[_button2 addTarget:self
						 action:@selector(clickButton2:) 
			   forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _button2];
		}
		
		if(nil == _button3)
		{
			self._button3 = [UIButton buttonWithType:UIButtonTypeCustom];
			_button3.tag = 3;
			_button3.titleLabel.font = [UIFont systemFontOfSize: 16];
			_button3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
			[_button3 setTitleColor:[UIColor blueColor] 
						   forState:UIControlStateHighlighted];
			[_button3 addTarget:self
						 action:@selector(clickButton3:) 
			   forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _button3];
		}
		
		if(nil == _button4)
		{
			self._button4 = [UIButton buttonWithType:UIButtonTypeCustom];
			_button4.tag = 4;
			_button4.titleLabel.font = [UIFont systemFontOfSize: 16];
			_button4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
			[_button4 setTitleColor:[UIColor blueColor] 
						   forState:UIControlStateHighlighted];
			[_button4 addTarget:self
						 action:@selector(clickButton4:) 
			   forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _button4];
		}
		
		_button0.hidden = YES;
		[_button0 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
		
		_button1.hidden = YES;
		[_button1 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
		
		_button2.hidden = YES;
		[_button2 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
		
		_button3.hidden = YES;
		[_button3 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
		
		_button4.hidden = YES;
		[_button4 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
		
		NSNumber* selectedIndexNum = [_item objectForKey:@"selectedIndex"];
		if(selectedIndexNum)
			_selectedIndex = [selectedIndexNum intValue];
		
		CGFloat offset_x = 13.0;
		NSArray* selections = [_item objectForKey:@"selections"];
		for(int i = 0; i < [selections count]; i++)
		{
			NSDictionary* selection = [selections objectAtIndex:i];
			
			if(0 == i)
			{
				_button0.hidden = NO;
				_button0.frame = CGRectMake(offset_x,_offset_y,[RCTool getScreenSize].width-20,40);
				[_button0 setTitle:[selection objectForKey:@"text"] 
						  forState:UIControlStateNormal];
				
				if(_selectedIndex == i)
					[_button0 setTitleColor:[UIColor blueColor] 
								   forState:UIControlStateNormal];
			}
			else if(1 == i)
			{
				_button1.hidden = NO;
				_button1.frame = CGRectMake(offset_x,_offset_y + 50*i,[RCTool getScreenSize].width-20,40);
				[_button1 setTitle:[selection objectForKey:@"text"] 
						  forState:UIControlStateNormal];
				
				if(_selectedIndex == i)
					[_button1 setTitleColor:[UIColor blueColor] 
								   forState:UIControlStateNormal];
			}
			else if(2 == i)
			{
				_button2.hidden = NO;
				_button2.frame = CGRectMake(offset_x,_offset_y + 50*i,[RCTool getScreenSize].width-20,40);
				[_button2 setTitle:[selection objectForKey:@"text"] 
						  forState:UIControlStateNormal];
				
				if(_selectedIndex == i)
					[_button2 setTitleColor:[UIColor blueColor] 
								   forState:UIControlStateNormal];
			}
			else if(3 == i)
			{	
				_button3.hidden = NO;
				_button3.frame = CGRectMake(offset_x,_offset_y + 50*i,[RCTool getScreenSize].width-20,40);
				[_button3 setTitle:[selection objectForKey:@"text"] 
						  forState:UIControlStateNormal];
				
				if(_selectedIndex == i)
					[_button3 setTitleColor:[UIColor blueColor] 
								   forState:UIControlStateNormal];
			}
			else if(4 == i)
			{
				_button4.hidden = NO;
				_button4.frame = CGRectMake(offset_x,_offset_y + 50*i,[RCTool getScreenSize].width-20,40);
				[_button4 setTitle:[selection objectForKey:@"text"] 
						  forState:UIControlStateNormal];
				
				if(_selectedIndex == i)
					[_button4 setTitleColor:[UIColor blueColor] 
								   forState:UIControlStateNormal];
			}
		}
	}
	else 
	{
		size = [[_item objectForKey:@"question"] sizeWithFont:[UIFont boldSystemFontOfSize:28]
											constrainedToSize:CGSizeMake(self.frame.size.width - 40*2,CGFLOAT_MAX)];
		_offset_y = size.height + 60;
		
		if(nil == _previous)
		{
            CGFloat offset_y = 64.0f;
            if([RCTool isIphone5])
                offset_y = -40.0f;
            
			self._previous = [UIButton buttonWithType:UIButtonTypeCustom];
			_previous.frame = CGRectMake(30,self.frame.size.height - offset_y - 143,150,50);
			_previous.titleLabel.font = [UIFont systemFontOfSize: 26];
			_previous.layer.borderWidth = 1.0;
			_previous.layer.borderColor = [[UIColor blackColor] CGColor];
			[_previous setTitleColor:[UIColor blackColor] 
							forState:UIControlStateNormal];
			[_previous setTitleColor:[UIColor blueColor] 
							forState:UIControlStateHighlighted];
			[_previous setTitle:NSLocalizedString(@"上一题",@"")
					   forState:UIControlStateNormal];
			[_previous addTarget:self
						  action:@selector(clickPreviousButton:) 
				forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _previous];
		}
		
		_previous.hidden = (1 == _index) ? YES: NO;
		
		if(nil == _next)
		{
            CGFloat offset_y = 64.0f;
            if([RCTool isIphone5])
                offset_y = -40.0f;
            
			self._next = [UIButton buttonWithType:UIButtonTypeCustom];
			_next.frame = CGRectMake(self.frame.size.width - 180,self.frame.size.height - offset_y- 143,150,50);
			_next.titleLabel.font = [UIFont systemFontOfSize: 26];
			_next.layer.borderWidth = 1.0;
			_next.layer.borderColor = [[UIColor blackColor] CGColor];
			[_next setTitleColor:[UIColor blackColor] 
						forState:UIControlStateNormal];
			[_next setTitleColor:[UIColor blueColor] 
						forState:UIControlStateHighlighted];
			[_next setTitle:NSLocalizedString(@"下一题",@"")
				   forState:UIControlStateNormal];
			[_next addTarget:self
					  action:@selector(clickNextButton:) 
			forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _next];
		}
		
		_next.hidden = (33 == _index) ? YES: NO;
		
		if(nil == _resultButton)
		{
            CGFloat offset_y = 64.0f;
            if([RCTool isIphone5])
                offset_y = -40.0f;
            
			self._resultButton = [UIButton buttonWithType:UIButtonTypeCustom];
			_resultButton.frame = CGRectMake(self.frame.size.width - 180,self.frame.size.height - offset_y- 143,150,50);
			_resultButton.titleLabel.font = [UIFont systemFontOfSize: 26];
			_resultButton.layer.borderWidth = 1.0;
			_resultButton.layer.borderColor = [[UIColor blackColor] CGColor];
			[_resultButton setTitleColor:[UIColor blackColor] 
								forState:UIControlStateNormal];
			[_resultButton setTitleColor:[UIColor blueColor] 
								forState:UIControlStateHighlighted];
			[_resultButton setTitle:NSLocalizedString(@"完成",@"")
						   forState:UIControlStateNormal];
			[_resultButton addTarget:self
							  action:@selector(clickResultButton:) 
					forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _resultButton];
		}
		
		if(33 == _index)
			_resultButton.hidden = NO;
		else
			_resultButton.hidden = YES;
		
		if(nil == _button0)
		{
			self._button0 = [UIButton buttonWithType:UIButtonTypeCustom];
			_button0.tag = 0;
			_button0.titleLabel.font = [UIFont systemFontOfSize: 26];
			_button0.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
			[_button0 setTitleColor:[UIColor blueColor] 
						   forState:UIControlStateHighlighted];
			[_button0 addTarget:self
						 action:@selector(clickButton0:) 
			   forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _button0];
		}
		
		if(nil == _button1)
		{
			self._button1 = [UIButton buttonWithType:UIButtonTypeCustom];
			_button1.tag = 1;
			_button1.titleLabel.font = [UIFont systemFontOfSize: 26];
			_button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
			[_button1 setTitleColor:[UIColor blueColor] 
						   forState:UIControlStateHighlighted];
			[_button1 addTarget:self
						 action:@selector(clickButton1:) 
			   forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _button1];
			
			//_button1.layer.borderWidth = 1.0;
			//_button1.layer.borderColor = [[UIColor blackColor] CGColor];
		}
		
		if(nil == _button2)
		{
			self._button2 = [UIButton buttonWithType:UIButtonTypeCustom];
			_button2.tag = 2;
			_button2.titleLabel.font = [UIFont systemFontOfSize: 26];
			_button2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
			[_button2 setTitleColor:[UIColor blueColor] 
						   forState:UIControlStateHighlighted];
			[_button2 addTarget:self
						 action:@selector(clickButton2:) 
			   forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _button2];
		}
		
		if(nil == _button3)
		{
			self._button3 = [UIButton buttonWithType:UIButtonTypeCustom];
			_button3.tag = 3;
			_button3.titleLabel.font = [UIFont systemFontOfSize: 26];
			_button3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
			[_button3 setTitleColor:[UIColor blueColor] 
						   forState:UIControlStateHighlighted];
			[_button3 addTarget:self
						 action:@selector(clickButton3:) 
			   forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _button3];
		}
		
		if(nil == _button4)
		{
			self._button4 = [UIButton buttonWithType:UIButtonTypeCustom];
			_button4.tag = 4;
			_button4.titleLabel.font = [UIFont systemFontOfSize: 26];
			_button4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
			[_button4 setTitleColor:[UIColor blueColor] 
						   forState:UIControlStateHighlighted];
			[_button4 addTarget:self
						 action:@selector(clickButton4:) 
			   forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _button4];
		}
		
		_button0.hidden = YES;
		[_button0 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
		
		_button1.hidden = YES;
		[_button1 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
		
		_button2.hidden = YES;
		[_button2 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
		
		_button3.hidden = YES;
		[_button3 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
		
		_button4.hidden = YES;
		[_button4 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
		
		NSNumber* selectedIndexNum = [_item objectForKey:@"selectedIndex"];
		if(selectedIndexNum)
			_selectedIndex = [selectedIndexNum intValue];
		
		CGFloat offset_x = 46.0;
		NSArray* selections = [_item objectForKey:@"selections"];
		for(int i = 0; i < [selections count]; i++)
		{
			NSDictionary* selection = [selections objectAtIndex:i];
			
			if(0 == i)
			{
				_button0.hidden = NO;
				_button0.frame = CGRectMake(offset_x,_offset_y,700,60);
				[_button0 setTitle:[selection objectForKey:@"text"] 
						  forState:UIControlStateNormal];
				
				if(_selectedIndex == i)
					[_button0 setTitleColor:[UIColor blueColor] 
								   forState:UIControlStateNormal];
			}
			else if(1 == i)
			{
				_button1.hidden = NO;
				_button1.frame = CGRectMake(offset_x,_offset_y + 80*i,700,60);
				[_button1 setTitle:[selection objectForKey:@"text"] 
						  forState:UIControlStateNormal];
				
				if(_selectedIndex == i)
					[_button1 setTitleColor:[UIColor blueColor] 
								   forState:UIControlStateNormal];
			}
			else if(2 == i)
			{
				_button2.hidden = NO;
				_button2.frame = CGRectMake(offset_x,_offset_y + 80*i,700,60);
				[_button2 setTitle:[selection objectForKey:@"text"] 
						  forState:UIControlStateNormal];
				
				if(_selectedIndex == i)
					[_button2 setTitleColor:[UIColor blueColor] 
								   forState:UIControlStateNormal];
			}
			else if(3 == i)
			{	
				_button3.hidden = NO;
				_button3.frame = CGRectMake(offset_x,_offset_y + 80*i,700,60);
				[_button3 setTitle:[selection objectForKey:@"text"] 
						  forState:UIControlStateNormal];
				
				if(_selectedIndex == i)
					[_button3 setTitleColor:[UIColor blueColor] 
								   forState:UIControlStateNormal];
			}
			else if(4 == i)
			{
				_button4.hidden = NO;
				_button4.frame = CGRectMake(offset_x,_offset_y + 80*i,700,60);
				[_button4 setTitle:[selection objectForKey:@"text"] 
						  forState:UIControlStateNormal];
				
				if(_selectedIndex == i)
					[_button4 setTitleColor:[UIColor blueColor] 
								   forState:UIControlStateNormal];
			}
		}
	}

	

}

- (void)clickButton0:(id)sender
{
	if(0 == _selectedIndex)
	{
		[_button0 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(1 == _selectedIndex)
	{
		[_button1 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(2 == _selectedIndex)
	{
		[_button2 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(3 == _selectedIndex)
	{
		[_button3 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(4 == _selectedIndex)
	{
		[_button4 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	
	_selectedIndex = 0;
	[_button0 setTitleColor:[UIColor blueColor] 
				   forState:UIControlStateNormal];
	[_item setObject:[NSNumber numberWithInt:_selectedIndex] 
			  forKey:@"selectedIndex"];
}

- (void)clickButton1:(id)sender
{
	if(0 == _selectedIndex)
	{
		[_button0 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(1 == _selectedIndex)
	{
		[_button1 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(2 == _selectedIndex)
	{
		[_button2 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(3 == _selectedIndex)
	{
		[_button3 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(4 == _selectedIndex)
	{
		[_button4 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	
	_selectedIndex = 1;
	[_button1 setTitleColor:[UIColor blueColor] 
				   forState:UIControlStateNormal];
	[_item setObject:[NSNumber numberWithInt:_selectedIndex] 
			  forKey:@"selectedIndex"];
	
}

- (void)clickButton2:(id)sender
{
	if(0 == _selectedIndex)
	{
		[_button0 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(1 == _selectedIndex)
	{
		[_button1 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(2 == _selectedIndex)
	{
		[_button2 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(3 == _selectedIndex)
	{
		[_button3 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(4 == _selectedIndex)
	{
		[_button4 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	
	_selectedIndex = 2;
	[_button2 setTitleColor:[UIColor blueColor] 
				   forState:UIControlStateNormal];
	[_item setObject:[NSNumber numberWithInt:_selectedIndex] 
			  forKey:@"selectedIndex"];
}

- (void)clickButton3:(id)sender
{
	if(0 == _selectedIndex)
	{
		[_button0 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(1 == _selectedIndex)
	{
		[_button1 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(2 == _selectedIndex)
	{
		[_button2 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(3 == _selectedIndex)
	{
		[_button3 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(4 == _selectedIndex)
	{
		[_button4 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	
	_selectedIndex = 3;
	[_button3 setTitleColor:[UIColor blueColor] 
				   forState:UIControlStateNormal];
	[_item setObject:[NSNumber numberWithInt:_selectedIndex] 
			  forKey:@"selectedIndex"];
}

- (void)clickButton4:(id)sender
{
	if(0 == _selectedIndex)
	{
		[_button0 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(1 == _selectedIndex)
	{
		[_button1 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(2 == _selectedIndex)
	{
		[_button2 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(3 == _selectedIndex)
	{
		[_button3 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	else if(4 == _selectedIndex)
	{
		[_button4 setTitleColor:[UIColor blackColor] 
					   forState:UIControlStateNormal];
	}
	
	_selectedIndex = 4;
	[_button4 setTitleColor:[UIColor blueColor] 
				   forState:UIControlStateNormal];
	[_item setObject:[NSNumber numberWithInt:_selectedIndex] 
			  forKey:@"selectedIndex"];
}

- (void)clickPreviousButton:(id)sender
{
	NSLog(@"clickPreviousButton");
	
	[_delegate clickPreviousButton];
}

- (void)clickNextButton:(id)sender
{
	NSLog(@"clickNextButton");
	
	if(-1 == _selectedIndex)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示",@"")
														message:NSLocalizedString(@"您需要先完成当前的题目,才能进入下一题！",@"")
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"确定",@"")
											  otherButtonTitles:nil];
		
		[alert show];
		[alert release];
		
		return;
	}
	
	[_delegate clickNextButton];
}

- (void)clickResultButton:(id)sender
{
    FoodAppDelegate* appDelegate = (FoodAppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate showInterstitialAd:nil];
    
	[_delegate clickResultButton];
    
    //[self performSelector:@selector(showAd) withObject:nil afterDelay:1.0];
}

- (void)showAd
{

}


@end
