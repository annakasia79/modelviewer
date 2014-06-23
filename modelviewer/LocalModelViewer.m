//
//  LocalModelViewer.m
//  modelviewer
//
//  Created by Katarzyna Wilkosinska on 27.12.13.
//  Copyright (c) 2013 Katarzyna Wilkosinska. All rights reserved.
//

#import "LocalModelViewer.h"

@interface UIBackingWebView
- (void)_setWebGLEnabled:(BOOL)value;
@end

@interface LocalModelViewer ()

@end

@implementation LocalModelViewer

@synthesize modelUrl=_modelUrl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Enable WebGL
    id webDocumentView = [self.theWebView performSelector:@selector(_browserView)];
    id backingWebView = [webDocumentView performSelector:@selector(webView)];
    [(UIBackingWebView*)backingWebView _setWebGLEnabled:YES];
        
    
    NSLog(@"%s  %@", __func__, self.modelUrl);
    
    NSString *fullURL =  self.modelUrl;
    NSURL *websiteURL = [NSURL URLWithString:fullURL];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:websiteURL];
    [self.theWebView loadRequest:requestObj];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
