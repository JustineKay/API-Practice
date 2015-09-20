//
//  InstaImageViewController.m
//  API-Practice
//
//  Created by Justine Gartner on 9/19/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import "InstaImageViewController.h"

@interface InstaImageViewController ()

@end

@implementation InstaImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //get the images dictionary
    NSDictionary *images = [self.instagramPost objectForKey:@"images"];
    
    //get the standard resolution dictionary
    NSDictionary *sr = [images objectForKey:@"standard_resolution"];
    
    
    NSString *urlString = [sr objectForKey:@"url"];
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    NSData  *pictureData = [NSData dataWithContentsOfURL:url];
    
    
    UIImage *picture = [UIImage imageWithData:pictureData];
    
    self.imageView.image = picture;
    
}

@end
