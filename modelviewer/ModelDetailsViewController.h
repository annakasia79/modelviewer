//
//  ModelDetailsViewController.h
//  modelviewer
//
//  Created by Katarzyna Wilkosinska on 18.01.14.
//  Copyright (c) 2014 Katarzyna Wilkosinska. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModelDetailsViewController : UIViewController {
    NSString *_name;
    NSString *_description;
    NSString *_imageUrl;
    NSString *_Url;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *statusView;
@property (weak, nonatomic) IBOutlet UIButton *convertModel;
@property (weak, nonatomic) IBOutlet UIButton *showModel;


@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *description;
@property (copy, nonatomic) NSString *imageUrl;
@property (copy, nonatomic) NSString *url;

@end
