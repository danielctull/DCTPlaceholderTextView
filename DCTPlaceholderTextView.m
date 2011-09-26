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
@end

@implementation DCTPlaceholderTextView {
	__strong UIFont *originalFont;
	__strong UIColor *originalTextColor;
}

@synthesize placeholderFont;
@synthesize placeholderText;
@synthesize placeholderTextColor;

- (void)setPlaceholderText:(NSString *)text {
	placeholderText = text;
	if (![self hasText]) self.text = text;
}

- (void)setPlaceholderFont:(UIFont *)f {
	placeholderFont = f;
	if (![self hasText]) self.placeholderText = self.placeholderText;
}

- (void)setPlaceholderTextColor:(UIColor *)color {
	placeholderTextColor = color;
	if (![self hasText]) self.placeholderText = self.placeholderText;
}

- (BOOL)hasText {
	return ([self.text length] > 0);
}

- (void)setText:(NSString *)text {
	
	if (text && ([text isEqualToString:@""] || ![text isEqualToString:self.placeholderText])) {
		self.font = originalFont;
		self.textColor = originalTextColor;
		[super setText:text];
		return;
	}
	
	originalFont = self.font;
	if (self.placeholderFont) self.font = self.placeholderFont;
		
	originalTextColor = self.textColor;
	if (self.placeholderTextColor) self.textColor = self.placeholderTextColor;
		
	[super setText:self.placeholderText];
}

- (NSString *)text {
	NSString *text = [super text];
	
	if ([text isEqualToString:self.placeholderText]) return nil;
	
	return text;
}

- (BOOL)becomeFirstResponder {
	
	if (![self hasText]) self.text = @"";
	
	return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
	
	self.placeholderText = self.placeholderText;
	
	return [super resignFirstResponder];
}

@end
