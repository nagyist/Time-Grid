//
//  TGPost.h
//  Time Grid
//
//  Created by Jerome Thomere on 2/25/14.
//  Copyright (c) 2014 Jerome Thomere. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface TGPost : NSObject

+ (TGPost *) postWithData:(id<FBGraphObject>)data;
+ (NSArray *) postsWithQueryResult:(id)result;

typedef enum  {
    TgPostTypeUnknown = 0,
    TgPostTypeGroupCreated = 11,
    TGPostTypeEventCreated = 12,
    TGPostTypeStatusUpdate = 46,
    TgPostTypeWallPost  = 56,
    TGPostTypeNoteCreated = 66,
    TGPostTypeLinkPosted = 80,
    TGPostTypeVideoPosted = 128,
    TGPostTypePhotosPosted = 247,
    TGPostTypeAppStory = 237,
    TGPostTypeCommentCreated = 257,
    TGPostTypeCheckinPlace = 285
} TGPostType;

@property (readonly, nonatomic) TGPostType type;
@property (readonly, nonatomic) NSString *message;
@property (readonly, nonatomic) NSString *postDescription;

@end
