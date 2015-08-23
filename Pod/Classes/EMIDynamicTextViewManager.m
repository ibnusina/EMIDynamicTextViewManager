//
//  EMIDynamicTextViewManager.m
//  Pods
//
//  Created by Ibnu Sina on 8/23/15.
//
//

#import "EMIDynamicTextViewManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface EMIDynamicTextViewManager() <UITextViewDelegate>
@property (strong, nonatomic)UITextView *textVIew;
@property (strong, nonatomic)void(^didFinishEdittingBlock)(NSString *text);
@property (strong, nonatomic)NSString *placeholder;
@property float prevHeight;
@property (strong, nonatomic)RACSubject *textViewChangeSubject;
@property (strong, nonatomic)RACSubject *textViewBeginEditingSubject;
@property (strong, nonatomic)RACSubject *textViewEndEditingSubject;
@property (assign, nonatomic)BOOL isNewLineEnabled;
@end

@implementation EMIDynamicTextViewManager

- (instancetype)initWithTextView:(UITextView *)textView
{
    self = [super init];
    if(!self) return nil;
    
    _textVIew = textView;
    _textVIew.delegate = self;
    _textVIew.scrollEnabled = NO;
    [self changeTextViewFrameHeight:[self getTextViewHeight]];
    self.prevHeight = textView.frame.size.height;
    self.textViewChangeSubject = [RACSubject new];
    self.textViewBeginEditingSubject = [RACSubject new];
    self.textViewEndEditingSubject = [RACSubject new];
    return self;
    
}

- (void)scrollableTextView:(BOOL)scrollable
{
    self.textVIew.scrollEnabled = scrollable;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    if (_textVIew.text.length == 0) {
        _textVIew.text = placeholder;
    }
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:
(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"] && (!self.isNewLineEnabled)) {
        [textView resignFirstResponder];
    }
    return YES;
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"Did begin editing");
    if ([textView.text isEqualToString:_placeholder]) {
        textView.text = @"";
    }
    [textView becomeFirstResponder];
    [self.textViewBeginEditingSubject sendNext:nil];
    
}

-(void)textViewDidChange:(UITextView *)textView{
    BOOL isTextViewHeightChange = NO;
    CGFloat height = [self getTextViewHeight];
    if (height != self.prevHeight) {
        isTextViewHeightChange = YES;
    }
    [self textViewHeigthDidChange:isTextViewHeightChange newHeight:height];
    self.prevHeight = height;
    
}

- (void)updateFrameHeight
{
    CGFloat height = [self getTextViewHeight];
    if (height != self.prevHeight) {
        [self changeTextViewFrameHeight:height];
        self.prevHeight = height;
    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"Did End editing");
    if ([textView.text isEqualToString:@""]) {
        textView.text = _placeholder;
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [self.textViewEndEditingSubject sendNext:@YES];
    [textView resignFirstResponder];
    return YES;
    
}

-(void)setDidFinishEdittingHandler:(void(^)(NSString *text))block
{
    self.didFinishEdittingBlock = block;
    
}

- (CGFloat)getTextViewHeight
{
    CGFloat newHeight = [self.textVIew sizeThatFits:CGSizeMake(self.textVIew.frame.size.width, FLT_MAX)].height;
    return newHeight;
    
}

- (RACSignal *)textViewDidChangeSignal
{
//    return self.textViewChangeSubject;
    return [self rac_signalForSelector:@selector(textViewHeigthDidChange:newHeight:)];
    
}

- (RACSignal *)textViewDidBeginEditingSignal
{
    return self.textViewBeginEditingSubject;
}

- (RACSignal *)textViewDidEndEditingSignal
{
    return self.textViewEndEditingSubject;
}

- (void)enableNewLine:(BOOL)enable
{
    self.isNewLineEnabled = enable;
}

- (void)changeTextViewFrameHeight:(CGFloat)height
{
    CGRect frame = self.textVIew.frame;
    frame.size.height = height;
    self.textVIew.frame = frame;
}

#pragma mark - for delegating height change

- (void)textViewHeigthDidChange:(BOOL)didChange newHeight:(CGFloat)change
{
    
}

@end
