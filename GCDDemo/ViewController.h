//
//  ViewController.h
//  GCDDemo
//
//  Created by lengshengren on 13-12-5.
//  Copyright (c) 2013年 lengshengren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *taskGroupButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)relatedUiAction:(id)sender;
- (IBAction)sycQueueAction:(id)sender;
- (IBAction)delayEventAction:(id)sender;
- (IBAction)taskGroupAction:(id)sender;
- (IBAction)timesDoSomething:(id)sender;
- (IBAction)ontTaskAction:(id)sender;
- (IBAction)asyQueueAction:(id)sender;


@end
