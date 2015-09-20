
//
//  InstaImageViewController.h
//  API-Practice
//
//  Created by Justine Gartner on 9/19/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstaImageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic) NSDictionary *instagramPost;

@end
