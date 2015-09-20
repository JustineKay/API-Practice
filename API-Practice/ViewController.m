//
//  ViewController.m
//  API-Practice
//
//  Created by Justine Gartner on 9/19/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import "ViewController.h"
#import "InstaImageViewController.h"
#import "APIManager.h"

@interface ViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *instagramData;

@end


@implementation ViewController


- (IBAction)refreshTableView:(UIBarButtonItem *)sender {
    
    [self fetchInstagramData];
    
}


-(void)fetchInstagramData{
    
    //create an instagram url
    NSURL *instagramURL = [NSURL URLWithString:@"https://api.instagram.com/v1/tags/wanderlust/media/recent?client_id=ac0ee52ebb154199bfabfb15b498c067"];
    
    //
    [APIManager GetRequestWithURL:instagramURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"%@", json);
        
        self.instagramData = [json objectForKey:@"data"];
        
        [self.tableView reloadData];
        
    }];

}

//From the first version of this practice project, before implementing the table view
/*-(void)fetchAppleData{
    
    //create url
    NSURL *url = [NSURL   URLWithString:@"https://itunes.apple.com/search?term=apple&media=software"];
    
    
    [APIManager GetRequestWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //deserialize data from the server into JSON
        NSDictionary *allData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        //store the first object in the results array into a new variable
        ///called results
        NSArray *results = [allData objectForKey:@"results"];
        
        //store the first object in the results array in a variable
        //called firstResult
        NSDictionary *firstResult = [results firstObject];
        
        //store the array of screenshots in a new variable
        //called screenshots
        NSArray *screenshots = [firstResult objectForKey:@"screenshotUrls"];
        
        //get the first screenshot url string from our array
        NSString *imageURLString = [screenshots firstObject];
        
        //create a url from our imageURLString
        NSURL *imageURL = [NSURL URLWithString:imageURLString];
        
        //create a data object from our imageURL
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        //create an image with the data from our url
        UIImage *image = [UIImage imageWithData:imageData];
        
        //self.imageView.image = image;
        
    }];

}*/

#pragma mark - navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    NSDictionary *currentInstagramItem = self.instagramData[indexPath.row];
    
    InstaImageViewController *viewController = segue.destinationViewController;
    
    viewController.instagramPost = currentInstagramItem;
    
}


#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    
    [self fetchInstagramData];
    
    
}


#pragma mark - tableview datasource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.instagramData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    
    NSDictionary *currentInstagramItem = self.instagramData[indexPath.row];
    
    NSDictionary *user = [currentInstagramItem objectForKey:@"user"];
    
    NSString *username = [user objectForKey: @"username"];
    
    cell.textLabel.text = username;
    
    return cell;
}






@end
