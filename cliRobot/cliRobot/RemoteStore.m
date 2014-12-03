//
//  RemoteStore.m
//  cliRobot
//
//  Created by Ankhbayar Baasandorj on 2014-12-02.
//  Copyright (c) 2014 Maple Hero Studio. All rights reserved.
//

#import "RemoteStore.h"
#import <objc/runtime.h>

@interface RemoteStore(){
    NSMutableArray *propertyList;
    unsigned int outPropCount;
}

@end

@implementation RemoteStore


-(RemoteStore*)initForClass:(char*) className delegate:(id<RemoteStoreDelegate>) del{
    
    self.remoteStoreDelegate = del;//set delegate
    
    Class objType = objc_getClass(className);
    
    if(objType == NULL)
        [NSException raise:@"Invalid type exception" format:@"Can't find type %s", className];
    
    propertyList = [[NSMutableArray alloc] init];
    
    objc_property_t *properties = class_copyPropertyList(objType, &outPropCount);
    
    for(int i=0; i< outPropCount; i++){
        objc_property_t property = properties[i];
        //We can improve this class analyzing more information
        fprintf(stdout, "%s :: %s\n", property_getName(property), property_getAttributes(property));
        
        NSString *propertyName = [NSString stringWithFormat:@"%s", property_getName(property)];
        [propertyList addObject:propertyName];
    }
    
    return self;
}

-(void)save:(id) obj{
    
    //for future improvements: if need to handle before send to remote
    NSMutableDictionary *dictionaryForJson = [[NSMutableDictionary alloc] init];
    for(int i=0; i< outPropCount; i++){
        id val = [obj valueForKey:propertyList[i]];
        
        if(val != NULL)
            [dictionaryForJson setObject:val forKey:propertyList[i]];
    }

    //Delegation call
    [_remoteStoreDelegate saveObject:dictionaryForJson];
}

@end
