//
//  RemoteModelListViewController.m
//  modelviewer
//
//  Created by Katarzyna Wilkosinska on 18.12.13.
//  Copyright (c) 2013 Katarzyna Wilkosinska. All rights reserved.
//

#import "RemoteModelListViewController.h"
#import "Model.h"
#import "ModelDetailsViewController.h"

@interface RemoteModelListViewController ()

@end

@implementation RemoteModelListViewController

@synthesize remoteModelList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSURL * url=[NSURL URLWithString:@"http://localhost/repository/modelist.json"];
    
    NSData * data=[NSData dataWithContentsOfURL:url];
    
    NSError * error;
    
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    
    self.remoteModelList = [[NSMutableArray alloc]init];
    
    NSArray * remoteModels = json[@"models"];
    
    for(NSDictionary * dict in remoteModels)
    {
        Model *model1 = [[Model alloc]initWithName:[dict valueForKey:@"name"] imageUrl:[dict valueForKey:@"imageUrl"] description:[dict valueForKey:@"description"] url:[dict valueForKey:@"url"]];
        [ self.remoteModelList addObject:model1];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.remoteModelList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RemoteModelListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
    Model *model = [self.remoteModelList objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showModelDetails"]) {
        
        ModelDetailsViewController *modelDetailInformation = [segue destinationViewController];
        Model *model = [self.remoteModelList objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        modelDetailInformation.name = model.name;
        modelDetailInformation.description = model.description;
        modelDetailInformation.imageUrl = model.imageUrl;
        modelDetailInformation.url = model.url;
    }
}

@end
