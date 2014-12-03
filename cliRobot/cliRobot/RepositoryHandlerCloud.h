//
//  RepositoryHandlerCloud.h
//  cliRobot
//
//  Created by Ankhbayar Baasandorj on 2014-12-02.
//  Copyright (c) 2014 Maple Hero Studio. All rights reserved.
//

#import "RepositoryHandler.h"

@interface RepositoryHandlerCloud : RepositoryHandler <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property NSString* url;

-(RepositoryHandlerCloud*)initWithURL:(NSString*) url;

@end
