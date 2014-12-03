//
//  RepositoryHandlerCloud.m
//  cliRobot
//
//  Created by Ankhbayar Baasandorj on 2014-12-02.
//  Copyright (c) 2014 Maple Hero Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RepositoryHandlerCloud.h"

@interface RepositoryHandlerCloud(){
    BOOL finished;
}
@end

@implementation RepositoryHandlerCloud

-(RepositoryHandlerCloud*)initWithURL:(NSString*) url
{
    self.url = url;
    return self;
}

//Delegated method
//Implementation for Cloud repository
-(void)saveObject:(NSMutableDictionary *)dict{
    NSLog(@"saveObject from RepositoryHandlerCloud called");
    
    NSMutableDictionary *stringDict = [[NSMutableDictionary alloc] init];
    for(id key in dict) {
        [stringDict setObject:(NSString*)[[dict objectForKey:key] description] forKey:key];
    }
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:stringDict options:0 error:&err];
    
    //Post into server
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:self.url]]];
    NSString *postLength = [NSString stringWithFormat:@"%lu",[jsonData length]];
    
//    [request setURL:[NSURL URLWithString:self.url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    
    NSLog(@"Is%@ main thread", ([NSThread isMainThread] ? @"" : @" NOT"));

    
    [conn scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    [conn start];
    
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
}


- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError:%@", error);
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data{
    NSLog(@"ReceivedData:%@", [NSString stringWithUTF8String:[data bytes]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

}
- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response{
}

@end
