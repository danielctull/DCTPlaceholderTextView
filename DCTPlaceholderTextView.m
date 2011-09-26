/*
 DCTPlaceholderTextView.m
 
 Created by Daniel Tull on 17.09.2011.
 
 
 
 Copyright (c) 2011 Daniel Tull. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
 to endorse or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "DCTPlaceholderTextView.h"

@interface DCTPlaceholderTextView ()
- (void)dctInternal_reloadTextView;
@end

@implementation DCTPlaceholderTextView {
	__strong UIFont *originalFont;
	__strong UIColor *originalTextColor;
	BOOL firstResponder;
}

@synthesize placeholderFont;
@synthesize placeholderText;
@synthesize placeholderTextColor;

- (void)setPlaceholderText:(NSString *)text {
	placeholderText = text;
	[self dctInternal_reloadTextView];
}

- (UIFont *)placeholderFont {
	if (!placeholderFont) return self.font;
	
	return placeholderFont;
}

- (void)setPlaceholderFont:(UIFont *)font {
	placeholderFont = font;
	[self dctInternal_reloadTextView];
}

- (UIColor *)placeholderTextColor {
	if (!placeholderTextColor) return self.textColor;
	
	return placeholderTextColor;
}

- (void)setPlaceholderTextColor:(UIColor *)textColor {
	placeholderTextColor = textColor;
	[self dctInternal_reloadTextView];
}

- (void)setFont:(UIFont *)font {
	originalFont = font;
	[self dctInternal_reloadTextView];
}

- (void)setTextColor:(UIColor *)textColor {
	originalTextColor = textColor;
	[self dctInternal_reloadTextView];
}

- (BOOL)hasText {
	return ([self.text length] > 0);
}

- (void)dctInternal_reloadTextView {
	
	if ([self hasText] || firstResponder) {
		[super setText:self.text];
		[super setFont:originalFont];
		[super setTextColor:originalTextColor];
		return;
	}
	
	[super setText:self.placeholderText];
	[super setFont:self.placeholderFont];
	[super setTextColor:self.placeholderTextColor];
}

- (NSString *)text {
	NSString *text = [super text];
	
	if ([text isEqualToString:self.placeholderText]) return nil;
	
	return text;
}

- (BOOL)becomeFirstResponder {
	firstResponder = YES;
	[self dctInternal_reloadTextView];
	return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
	firstResponder = NO;
	[self dctInternal_reloadTextView];
	return [super resignFirstResponder];
}

@end
