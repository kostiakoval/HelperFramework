//
//  NLTableViewController.h
//  HelperFramework
//
//  Created by Konstantin on 7/4/12.
//  Copyright (c) 2012 nLink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLSmallTableViewController : UIViewController
{
    struct {
        int clearsSelectionOnViewWillAppear:1;
    } m_viewControllerFlags;
}

@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property(nonatomic) BOOL clearsSelectionOnViewWillAppear;

@end
