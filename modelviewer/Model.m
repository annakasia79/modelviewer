//
//  Model.m
//  modelviewer
//
//  Created by Katarzyna Wilkosinska on 18.01.14.
//  Copyright (c) 2014 Katarzyna Wilkosinska. All rights reserved.
//

#import "Model.h"

@implementation Model

@synthesize name = _name;
@synthesize imageUrl = _imageUrl;
@synthesize description = _description;
@synthesize url = _url;

-(id) initWithName:(NSString *)newName imageUrl:(NSString *)newImageUrl description:(NSString *)newDescription url:(NSString *)newUrl {
    self = [super init];
    if (nil != self) {
        self.name = newName;
        self.imageUrl = newImageUrl;
        self.description = newDescription;
        self.url = newUrl;
    }
    return self;
}

@end

