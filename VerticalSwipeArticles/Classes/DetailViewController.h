//
//  DetailViewController.h
//  VerticalSwipeArticles
//
//  Created by Peter Boctor on 12/26/10.
//
// Copyright (c) 2011 Peter Boctor
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE
//

#import "VerticalSwipeScrollView.h"

@interface DetailViewController : UIViewController <VerticalSwipeScrollViewDelegate, UIScrollViewDelegate>
{
}

@property (nonatomic, strong) IBOutlet UIView* headerView;
@property (nonatomic, strong) IBOutlet UIImageView* headerImageView;
@property (nonatomic, strong) IBOutlet UILabel* headerLabel;
@property (nonatomic, strong) IBOutlet UIView* footerView;
@property (nonatomic, strong) IBOutlet UIImageView* footerImageView;
@property (nonatomic, strong) IBOutlet UILabel* footerLabel;
@property (nonatomic, strong) VerticalSwipeScrollView* verticalSwipeScrollView;
@property (nonatomic, strong) UIWebView* previousPage;
@property (nonatomic, strong) UIWebView* nextPage;
@property (nonatomic, strong) NSArray* appData;
@property (nonatomic) NSUInteger startIndex;

@end

