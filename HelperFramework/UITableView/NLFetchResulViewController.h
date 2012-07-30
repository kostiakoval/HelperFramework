//
//  NLFetchResulViewController.h
//  GymTracker
//
//  Created by Konstantin on 5/11/12.
//  Copyright (c) 2012 nLink.no. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@protocol NLTableViewCellConfigurator;
@protocol NLFetchResulViewControllerConfigurator;
@interface NLFetchResulViewController : UIViewController <NSFetchedResultsControllerDelegate>
{
     NSFetchedResultsController *m_fetchedResultController;
}
@property (nonatomic,strong) IBOutlet UITableView *tableView;

// requried Prorerty for correct work. Set them them
@property (nonatomic,assign) IBOutlet id <NLTableViewCellConfigurator> cellConfigurator;      
@property (nonatomic,assign) IBOutlet id <NLFetchResulViewControllerConfigurator> fetchedController;     

@end


@protocol NLFetchResulViewControllerConfigurator <NSObject>
@required
- (NSFetchedResultsController*) configureFetchedResultController;
//- (id<NLTableViewCellConfigurator>) configureCellConfigurator;
@end

@protocol NLTableViewCellConfigurator <NSObject>
@required

- (NSString *)cellIdentifier;
- (void)configureCell:(UITableViewCell *)cell with:(NSManagedObject *)object;
- (UITableViewCell *)newCellL:(NSString *)identifier;

@end