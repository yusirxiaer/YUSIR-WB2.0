//
//  YSDiscoveryViewController.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/9.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSDiscoveryViewController.h"
#import "YSCommandHeader.h"
#import "YSSearchBar.h"
#define IMG_X      0
#define IMG_Y      20
#define IMG_NUM   5
@interface YSDiscoveryViewController ()

@end

@implementation YSDiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showScrollView];
    self.timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doSome:) userInfo:nil repeats:YES];
//    添加搜索栏
    [self setUpSearchBar];
}

-(void)setUpSearchBar{
    // 创建搜索框对象
    YSSearchBar *searchBar = [YSSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;

}
-(void)showScrollView{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    
    
    self.scrollView.backgroundColor = [UIColor orangeColor];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    for (int i = 0; i < IMG_NUM; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d", i+1];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageX = i * SCREEN_WIDTH;
        imageView.frame=CGRectMake(imageX, imageY, SCREEN_WIDTH, 109);
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(IMG_NUM*SCREEN_WIDTH-50, 109);
}
-(void)showPageControl{

    self.pageControl.numberOfPages = IMG_NUM;
    //    self.pageControl.backgroundColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.scrollView.contentOffset = CGPointZero;
    // 为page control添加事件响应方法
    [self.pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.pageControl];
    
}

#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    拖动的过程中通过current contentOffsent的值改变page control的currentPage
    CGFloat page = (scrollView.contentOffset.x+scrollView.frame.size.width/2)/(scrollView.frame.size.width);
    self.pageControl.currentPage=page;
}

-(void)pageControlValueChanged:(UIPageControl *)sender{
    // 根据当前页的index更改scroll view的contentOffset
    int index = (int)sender.currentPage;
    //        self.scrollView.contentOffset = CGPointMake(index*SCREEN_WIDTH, 0);
    [self.scrollView setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:YES];
    
}
-(void)doSome:(NSTimer *)timer{
    
    //  更改page control
    self.pageControl.currentPage =(self.pageControl.currentPage+1)%self.pageControl.numberOfPages;
    self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage*SCREEN_WIDTH, 0);
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"---------");
    [self.timer invalidate];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    NSLog(@"----------");
    self.timer =[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(doSome:) userInfo:nil repeats:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
