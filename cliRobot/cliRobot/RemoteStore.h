//
//  RemoteStore.h
//  cliRobot
//
//  Created by Ankhbayar Baasandorj on 2014-12-02.
//  Copyright (c) 2014 Maple Hero Studio. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol RemoteStoreDelegate
-(void)saveObject:(NSMutableDictionary *)dict;
@end


@interface RemoteStore : NSObject

@property NSString* name;

-(RemoteStore*)initForClass:(char*) className delegate:(id<RemoteStoreDelegate>) del;
-(void)save:(id) obj;
@property (nonatomic, weak) id<RemoteStoreDelegate> remoteStoreDelegate;


@end
