//
//  EMIDynamicTextViewManager.h
//  Pods
//
//  Created by Ibnu Sina on 8/23/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RACSignal;

@interface EMIDynamicTextViewManager : NSObject
- (instancetype)initWithTextView:(UITextView *)textView;
- (void)scrollableTextView:(BOOL)scrollable;
- (void)setDidFinishEdittingHandler:(void(^)(NSString *text))block;
- (void)setPlaceholder:(NSString *)placeholder;
- (RACSignal *)textViewDidChangeSignal;
- (RACSignal *)textViewDidBeginEditingSignal;
- (RACSignal *)textViewDidEndEditingSignal;
- (CGFloat)getTextViewHeight;
- (void)updateFrameHeight;
- (void)enableNewLine:(BOOL)enable;
@end
