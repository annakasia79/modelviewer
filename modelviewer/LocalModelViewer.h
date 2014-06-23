//
//  LocalModelViewer.h
//  modelviewer
//
//  Created by Katarzyna Wilkosinska on 27.12.13.
//  Copyright (c) 2013 Katarzyna Wilkosinska. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalModelViewer : UIViewController {
    NSString *_modelUrl;
}

@property (copy, nonatomic) NSString *modelUrl;
@property (weak, nonatomic) IBOutlet UIWebView *theWebView;

@end
