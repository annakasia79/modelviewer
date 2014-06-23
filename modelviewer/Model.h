//
//  Model.h
//  modelviewer
//
//  Created by Katarzyna Wilkosinska on 18.01.14.
//  Copyright (c) 2014 Katarzyna Wilkosinska. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject {
    NSString *_name;
    NSString *_imageUrl;
    
    NSString *_description;
    NSString *_url;
}


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *url;

-(id) initWithName: (NSString *) newName imageUrl: (NSString *) newimageUrl description: (NSString *) newDescription url: (NSString *) newUrl;

@end
