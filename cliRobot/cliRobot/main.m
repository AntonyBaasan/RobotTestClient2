//
//  main.m
//  cliRobot
//
//  Created by Ankhbayar Baasandorj on 2014-12-02.
//  Copyright (c) 2014 Maple Hero Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteStore.h"
#import "RepositoryHandler.h"
#import "RepositoryHandlerCoreData.h"
#import "RepositoryHandlerCloud.h"
#import "RPComment.h"
#import "RPAnnotation.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        //Helper objects
        //Setup RepositoryHandler - Core Data
        RepositoryHandler* repoHandlerCoreData = [[RepositoryHandlerCoreData alloc] init];
        //Setup RepositoryHandler - Cloud
        RepositoryHandler* repoHandlerCloud = [[RepositoryHandlerCloud alloc] initWithURL:@"http://54.183.168.93/api/rpcomment"];
//        RepositoryHandler* repoHandlerCloud = [[RepositoryHandlerCloud alloc] initWithURL:@"http://localhost:3030/api/rpcomment"];
        
        //RPComment instance which we want to save
        RPComment* rpcommentObj = [[RPComment alloc] init];
        rpcommentObj.user = @"Your name";
        rpcommentObj.text = @"Hello World iOS";
        rpcommentObj.published = [[NSDate alloc] init];
        
        //Instantiate RemoteStore object for Class PRComment to be saved in Core Data
        RemoteStore *store = [[RemoteStore alloc]initForClass:"RPComment" delegate:repoHandlerCoreData];
        [store save:rpcommentObj];
        
        //Instantiate RemoteStore object for Class PRComment to be saved in Cloud
        RemoteStore *store2 = [[RemoteStore alloc]initForClass:"RPComment" delegate:repoHandlerCloud];
        [store2 save:rpcommentObj];
        

        
        //We can save different object with no code change (need correct backend API)
        
        RPAnnotation* rpannObj = [[RPAnnotation alloc] init];
        rpannObj.type = @"type1";
        rpannObj.desc = @"this is very lond description";
        
        
        //Instantiate RemoteStore object for Class RPAnnotation to be saved in Core Data
        RemoteStore *store3 = [[RemoteStore alloc]initForClass:"RPAnnotation" delegate:repoHandlerCoreData];
        [store3 save:rpannObj];
        
        //Instantiate RemoteStore object for Class RPAnnotation to be saved in Cloud
        RemoteStore *store4 = [[RemoteStore alloc]initForClass:"RPAnnotation" delegate:repoHandlerCloud];
        [store4 save:rpannObj];//!!! This will not work. Required proper API on the server
        
        
    }
    return 0;
}
