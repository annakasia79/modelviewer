//
//  LocalModelListViewController.m
//  modelviewer
//
//  Created by Katarzyna Wilkosinska on 18.12.13.
//  Copyright (c) 2013 Katarzyna Wilkosinska. All rights reserved.
//

#import "LocalModelListViewController.h"

@interface LocalModelListViewController ()

@end

@implementation LocalModelListViewController

@synthesize localModelList;

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
    
    
    NSURL * url=[NSURL URLWithString:@"http://localhost/local/modelist.json"];
    
    NSData * data=[NSData dataWithContentsOfURL:url];
    
    NSError * error;
    
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    
    self.localModelList = [[NSMutableArray alloc]init];
    
    NSArray * remoteModels = json[@"models"];
    
    for(NSDictionary * dict in remoteModels)
    {
        [ self.localModelList addObject:[dict valueForKey:@"name"]];
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
    return [self.localModelList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LocalModelListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *model = [self.localModelList objectAtIndex:indexPath.row];
    cell.textLabel.text = model;
    
    return cell;
}

@end
