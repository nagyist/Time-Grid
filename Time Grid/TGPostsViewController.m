//
//  TGPostsViewController.m
//  Time Grid
//
//  Created by Jerome Thomere on 2/23/14.
//  Copyright (c) 2014 Jerome Thomere. All rights reserved.
//

#import "TGPostsViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface TGPostsViewController ()

@property (strong,nonatomic) NSArray* posts;

@end

@implementation TGPostsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self requestFeed];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) requestFeed {
    NSString *fqlQuery = @"SELECT post_id, created_time,  type FROM stream WHERE filter_key in (SELECT filter_key FROM stream_filter WHERE uid=me() AND type='newsfeed')AND is_hidden = 0 LIMIT 100";

    // Make the API request that uses FQL
    [FBRequestConnection startWithGraphPath:@"/fql"
                                 parameters:[NSDictionary dictionaryWithObjectsAndKeys: fqlQuery, @"q", nil]
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error)
     {
         if (error) {
             NSLog(@"Error: %@", [error localizedDescription]);
         }  else {
             //NSLog(@"Result: %@", result);
             self.posts = [result valueForKey:@"data"];
             [self.collectionView reloadData];
         }
     }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.posts count];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UILabel* postLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    NSDictionary *post = [self.posts objectAtIndex:indexPath.row];
    postLabel.text = [post valueForKey:@"post_id"];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCell" forIndexPath:indexPath];
    [cell addSubview:postLabel];
    return cell;
}


@end
