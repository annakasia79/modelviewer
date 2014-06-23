//
//  ModelDetailsViewController.m
//  modelviewer
//
//  Created by Katarzyna Wilkosinska on 18.01.14.
//  Copyright (c) 2014 Katarzyna Wilkosinska. All rights reserved.
//

#import "ModelDetailsViewController.h"
#import "LocalModelViewer.h"

@interface ModelDetailsViewController ()
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *convesionProgress;

@end

@implementation ModelDetailsViewController
@synthesize name=_name;
@synthesize description=_description;
@synthesize imageUrl=_imageUrl;
@synthesize url=_url;

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
	self.nameLabel.text = self.name;
    self.descriptionText.text = self.description;

    
    NSURL *imageURL = [NSURL URLWithString:self.imageUrl];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    self.imageView.image = image;
    
    
    /* bundels models
     
     NSURL * url=[NSURL URLWithString:@"http://pipeline.v-must.net/api/v1/bundles"];
     
     NSData * data=[NSData dataWithContentsOfURL:url];
     
     NSError * error;
     
     NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
     
     
     NSArray * bundles = json[@"bundles"];
     
     
     NSLog(@"%s  %@", __func__, json[@"bundles"]);
     
     {
     "bundles": [
     {
     "description": "Basic viewer application",
     "display_name": "Basic",
     "name": "basic"
     },
     {
     "description": "Standard viewer application",
     "display_name": "Standard",
     "name": "standard"
     },
     {
     "description": "CAD Viewer application",
     "display_name": "CAD Viewer",
     "name": "cadViewer"
     },
     {
     "description": "Fullsize viewer",
     "display_name": "Fullsize",
     "name": "fullsize"
     },
     {
     "description": "Metadata viewer",
     "display_name": "Metadata",
     "name": "metadata"
     },
     {
     "description": "POP geometry template",
     "display_name": "POP Geometry",
     "name": "pop"
     },
     {
     "description": "Radiance Scaling viewer",
     "display_name": "Radiance Scaling",
     "name": "radianceScaling"
     },
     {
     "description": "Walkthrough viewer",
     "display_name": "Walkthrough",
     "name": "walkthrough"
     }
     ],
     "count": 8,
     "next": null,
     "prev": null
     }
     
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)converModel:(id)sender {[self.convesionProgress startAnimating];
    
    //NSDictionary *json = @{  @"payload" : self.url, @"template" : @"fullsize" }; //do not work basic fullsize and pop optim. for ios
    NSDictionary *json = @{  @"payload" : self.url, @"template" : @"pop" };
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:0 error:&error];
    NSString *jsonInputString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //NSURL *url = [NSURL URLWithString:@"http://pipeline.v-must.net/api/v1/jobs"];
    NSURL *url = [NSURL URLWithString:@"http://localhost:5001/api/v1/jobs"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[jsonInputString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    id jsonResponseData = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
   
    
    BOOL ready = false;
    
    while(!ready) //TODO
    {
    
        [self.convesionProgress startAnimating];
        
        
        sleep(5);
    
        NSURL *statusurl=[NSURL URLWithString:jsonResponseData[@"job_url"]];
        NSMutableURLRequest *statusrequest = [NSMutableURLRequest requestWithURL:statusurl];
        [statusrequest setHTTPMethod:@"HEAD"];
        NSHTTPURLResponse *statusresponse;
        NSError *statuserror;
        [NSURLConnection sendSynchronousRequest:statusrequest returningResponse:&statusresponse error:&statuserror];
        
        int code = [statusresponse statusCode];
        
        if(code == 200) {
            ready = true;
            
            NSURL *modelurl=[NSURL URLWithString:jsonResponseData[@"job_url"]];
            NSData *modeldata=[NSData dataWithContentsOfURL:modelurl];
            NSError *modelerror;
            NSMutableDictionary  *modeljson = [NSJSONSerialization JSONObjectWithData:modeldata options: NSJSONReadingMutableContainers error: &modelerror];
            
            NSLog(@"%s  %@", __func__, modeljson);
            
           [self.convesionProgress stopAnimating];
            self.statusView.text = modeljson[@"message"];
            self.url = modeljson[@"preview_url"];
            self.convertModel.hidden = true;
            self.showModel.hidden = false;
        }

   }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showConvertModel"]) {        
        LocalModelViewer *website = [segue destinationViewController];
        website.modelUrl = self.url;
    }
}


@end
