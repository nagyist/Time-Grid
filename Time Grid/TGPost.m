//
//  TGPost.m
//  Time Grid
//
//  Created by Jerome Thomere on 2/25/14.
//  Copyright (c) 2014 Jerome Thomere. All rights reserved.
//

#import "TGPost.h"

@interface TGPost ()

@property (strong, nonatomic) id<FBGraphObject> data;

@end

@implementation TGPost

+ (TGPost *) postWithData:(id<FBGraphObject>)data {
    TGPost *post = [[TGPost alloc] init];
    post.data = data;
    NSLog(@"TGPost postWithData %@", data);
    return post;
}

+ (NSArray *) postsWithQueryResult:(id)result {
    NSMutableArray * posts = [NSMutableArray array];
    for (id<FBGraphObject>data in [result valueForKey:@"data"]) {
        [posts addObject:[TGPost postWithData:data]];
    }
    return posts;
}

- (NSString *) stringOrNilForKey:(NSString *)key {
    if ([self.data objectForKey:key] == [NSNull null]) {
        return nil;
    }
    return [self.data objectForKey:key];
}

- (TGPostType) type {
    if ([self.data objectForKey:@"type"] == [NSNull null]) {
        return TgPostTypeUnknown;
    }
    return [[self.data objectForKey:@"type"] integerValue];
}

- (NSString *) message {
    return [self stringOrNilForKey:@"message"];
}

- (NSString *) postDescription {
    return [self stringOrNilForKey:@"description"];
}

@end
