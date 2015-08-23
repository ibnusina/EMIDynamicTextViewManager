//
//  EMIViewController.m
//  EMIDynamicTextViewManager
//
//  Created by Ibnu Sina on 08/23/2015.
//  Copyright (c) 2015 Ibnu Sina. All rights reserved.
//

#import "EMIViewController.h"
#import <EMIDynamicTextViewManager/EMIDynamicTextViewManager.h>
#import <ReactiveCocoa/RACSignal.h>
#import <ReactiveCocoa/RACTuple.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface EMIViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (strong, nonatomic) EMIDynamicTextViewManager *textViewManager;

@end

@implementation EMIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textViewManager = [[EMIDynamicTextViewManager alloc] initWithTextView:self.textView];
    @weakify(self)
    [[self.textViewManager textViewDidChangeSignal] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        NSNumber *isChange = (NSNumber *)tuple.first;
        NSNumber *newHeight = (NSNumber *)tuple.second;
        if ([isChange boolValue]) {
            self.textViewHeightConstraint.constant = [newHeight floatValue];
        }
    }];
    
    [self.textViewManager setPlaceholder:@"test"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
