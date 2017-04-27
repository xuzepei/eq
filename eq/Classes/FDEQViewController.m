//
//  FDEQViewController.m
//  Food
//
//  Created by xuzepei on 10/11/11.
//  Copyright 2011 Rumtel Co.,Ltd. All rights reserved.
//

#import "FDEQViewController.h"
#import "RCTool.h"
#import "FDEQDetailViewController.h"
#import "FDEQStartView.h"

@implementation FDEQViewController
@synthesize _itemArray;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
		_itemArray = [[NSMutableArray alloc] init];
		
		self.title = NSLocalizedString(@"EQ 情商",@"");
		
		UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[button setTitle:NSLocalizedString(@"准备好了, 开始测试！",@"") 
				forState:UIControlStateNormal];
		[button addTarget:self action:@selector(clickStartButton:) 
		 forControlEvents:UIControlEventTouchUpInside];
		
		if(NO == [RCTool isIpad])
		{
			//self.view.frame = CGRectMake(0,0,[RCTool getScreenSize].width,[RCTool getScreenSize].height);
			
			button.frame = CGRectMake(0,0,200,30);
			button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
			button.center = CGPointMake([RCTool getScreenSize].width/2.0, [RCTool getScreenSize].height - 20 - 42 - 50 - 30);
		}
		else
		{
			//self.view.frame = CGRectMake(0,0,[RCTool getScreenSize].width,[RCTool getScreenSize].height);
			
			button.frame = CGRectMake(0,0,300,50);
			button.titleLabel.font = [UIFont boldSystemFontOfSize:26];
			button.center = CGPointMake([RCTool getScreenSize].width/2.0, [RCTool getScreenSize].height - 50 - 90 - 42);
		}
		
		
		[self.view addSubview: button];
		
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
    self.title = NSLocalizedString(@"EQ 情商",@"");
    
    
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
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.title = nil;
}



 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
     
     FDEQStartView* tempView = [[FDEQStartView alloc] initWithFrame:self.view.frame];
     self.view = tempView;
     [tempView release];
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
	
	[_itemArray release];
	
    [super dealloc];
}

- (void)updateContent:(NSDictionary*)dict
{
	if(nil == dict)
		return;

	
}

- (void)clickStartButton:(id)sender
{
	FDEQDetailViewController* temp = [[FDEQDetailViewController alloc] 
								initWithNibName:nil bundle:nil];
	
	[temp updateContent];
	[self.navigationController pushViewController:temp animated:YES];
	[temp release];
}


@end
