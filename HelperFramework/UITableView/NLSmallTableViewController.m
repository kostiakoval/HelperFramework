//
//  NLTableViewController.m
//  HelperFramework
//
//  Created by Konstantin on 7/4/12.
//  Copyright (c) 2012 nLink. All rights reserved.
//

#import "NLSmallTableViewController.h"

@interface NLSmallTableViewController ()

@end

@implementation NLSmallTableViewController
@synthesize tableView = m_tableView;
@dynamic clearsSelectionOnViewWillAppear;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    m_viewControllerFlags.clearsSelectionOnViewWillAppear = YES;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.tableView = nil;
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (m_viewControllerFlags.clearsSelectionOnViewWillAppear) {
        [m_tableView deselectRowAtIndexPath:[m_tableView indexPathForSelectedRow] animated:YES];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)clearsSelectionOnViewWillAppear
{
    return m_viewControllerFlags.clearsSelectionOnViewWillAppear;
}

- (void)setClearsSelectionOnViewWillAppear:(BOOL)clearsSelectionOnViewWillAppear
{
    m_viewControllerFlags.clearsSelectionOnViewWillAppear = clearsSelectionOnViewWillAppear;
}

@end
