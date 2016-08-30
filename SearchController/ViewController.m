//
//  ViewController.m
//  SearchController
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 金人网络. All rights reserved.
//
#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
const CGFloat kNavigationBarHeight = 44;
const CGFloat kStatusBarHeight = 20;
@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView * _mainScrollView;
    UITableView * _tableView;
    
}
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic,strong) UIView * headView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //去掉背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉底部线条
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //给导航栏添加背景view
    CGRect backView_frame = CGRectMake(0, -kStatusBarHeight, kScreenWith, kNavigationBarHeight+kStatusBarHeight);
    UIView *backView = [[UIView alloc] initWithFrame:backView_frame];
    UIColor *backColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0];
    //给当前颜色加上透明度
    backView.backgroundColor = [backColor colorWithAlphaComponent:0.0f];
    [self.navigationController.navigationBar addSubview:backView];
    self.backView = backView;
    self.backColor = backColor;
    //标题
    self.navigationItem.title = @"个人信息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    
    _dataArray = [[NSMutableArray alloc]init];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, kScreenWith, kScreenHeight+64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    CGRect bounds = CGRectMake( 0 , 0 , kScreenWith, 200) ;
    UIView * contentView = [[UIView alloc]initWithFrame:bounds];
    contentView.backgroundColor = [UIColor grayColor];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:bounds];
    imageView.center = contentView.center;
    imageView.image = [UIImage imageNamed:@"beijing.jpg"];
    
    self.headView = contentView;
    self.headerImageView = imageView;
    [self.headView addSubview:self.headerImageView];
    
    UIView * topView = [[UIView alloc]initWithFrame:bounds];
    [topView addSubview:self.headView];
    _tableView.tableHeaderView = topView;
    
    for (NSInteger i = 0; i<50; i++) {
        NSString * str= [NSString stringWithFormat:@"%ld.............",i];
        [_dataArray addObject:str];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIDE = @"cellIde";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIDE];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIDE];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"offset %lf ",scrollView.contentOffset.y);
    
    
    CGFloat offset_Y = scrollView.contentOffset.y;
    CGFloat alpha = (offset_Y + 64)/136.0f;
    self.backView.backgroundColor = [self.backColor colorWithAlphaComponent:alpha];
    
    if (offset_Y < -64) {
        //放大比例
        CGFloat add_topHeight = -(offset_Y+kNavigationBarHeight+kStatusBarHeight);
        self.scale = (200+add_topHeight)/200;
        //改变 frame
        CGRect contentView_frame = CGRectMake(0, -add_topHeight, kScreenWith, 200+add_topHeight);
        
        
        _headView.frame = contentView_frame;
        CGRect imageView_frame = CGRectMake(-(kScreenWith*self.scale-kScreenWith)/2.0f,
                                            0,
                                            kScreenWith*self.scale,
                                            200+add_topHeight);
        self.headerImageView.frame = imageView_frame;
    }
    
}


@end
