//
//  Copyright (c) 2012 modocache
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//


#import "MDCWebViewController.h"


@interface MDCWebViewController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end


@implementation MDCWebViewController


#pragma mark - Object Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"UIWebView";
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                 UIViewAutoresizingFlexibleHeight;

    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,
                                                               self.view.frame.size.width,
                                                               self.view.frame.size.height)];
    self.webView.autoresizingMask = self.view.autoresizingMask;
    self.webView.delegate = self;

    // On iOS5+ this can be accessed via self.webView.scrollView
    UIScrollView *scrollView = [self.webView valueForKey:@"_scrollView"];
    scrollView.delegate = self;
    self.scrollBarLabel = [[MDCScrollBarLabel alloc] initWithScrollView:scrollView];
    [scrollView addSubview:self.scrollBarLabel];

    [self.view addSubview:self.webView];
}


#pragma mark - UIViewController Overrides

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSURL *url = [NSURL URLWithString:@"http://www.google.com/"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)viewDidUnload
{
    self.scrollBarLabel = nil;
    self.webView.delegate = nil;
    self.webView = nil;

    [super viewDidUnload];
}


#pragma mark - MDCScrollBarViewController Overrides

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];

    // Set label
    UIScrollView *webScrollView = [self.webView valueForKey:@"_scrollView"];

    float progress = webScrollView.contentOffset.y / webScrollView.contentSize.height;
    self.scrollBarLabel.text = [NSString stringWithFormat:@"%f", progress];
}

@end
