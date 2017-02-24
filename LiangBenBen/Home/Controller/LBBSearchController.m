//
//  LBBSearchController.m
//  LiangBenBen
//
//  Created by xue on 2017/1/13.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBSearchController.h"
#import "PYSearch.h"
#import "LBBTempViewController.h"
#import "UIView+PYExtension.h"
#import "UIColor+PYExtension.h"
#define PYMargin 10 // 默认边距
#define PYRectangleTagMaxCol 3 // 矩阵标签时，最多列数
#define PYSearchHistoriesPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"PYSearchhistories.plist"] // 搜索历史存储路径

@interface LBBSearchController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
/** 基本搜索TableView(显示历史搜索和搜索记录) */
@property (nonatomic, strong) UITableView *baseSearchTableView;
/** 搜索栏 */
@property (nonatomic, strong) UISearchBar *searchBar;


@property (nonatomic, strong) UILabel *hotSearchHeader;


/** 热门标签容器 */
@property (nonatomic, strong) UIView *hotSearchTagsContentView;

/** 头部内容view */
@property (nonatomic, strong) UIView *headerContentView;
/** 搜索历史 */
@property (nonatomic, strong) NSMutableArray *searchHistories;
//@property (nonatomic, strong) NSMutableArray *searchHistoriesDic;

/** 键盘正在移动 */
@property (nonatomic, assign) BOOL keyboardshowing;
/** 记录键盘高度 */
@property (nonatomic, assign) CGFloat keyboardHeight;
/** 搜索历史标签的清空按钮 */
@property (nonatomic, strong) UIButton *emptyButton;


/** 热门搜索 */
@property (nonatomic, strong) NSMutableArray *hotSearches;
@property (nonatomic, strong) NSMutableArray *hotSearchesDic;


/** 所有的热门标签 */
@property (nonatomic, strong) NSArray *hotSearchTags;

/** 搜索历史标签容器，只有在PYSearchHistoryStyle值为PYSearchHistoryStyleTag才有值 */
@property (nonatomic, strong) UIView *searchHistoryTagsContentView;


/** 搜索历史标题,只有当PYSearchHistoryStyle != PYSearchHistoryStyleCell才有值 */
@property (nonatomic, strong) UILabel *searchHistoryHeader;



/**
 * 排名标签背景色对应的16进制字符串（如：@"#ffcc99"）数组(四个颜色)
 * 前三个为分别为1、2、3 第四个为后续所有标签的背景色
 * 该属性只有在设置hotSearchStyle为PYHotSearchStyleColorfulTag才生效
 */
@property (nonatomic, strong) NSArray<NSString *> *rankTagBackgroundColorHexStrings;
/**
 * web安全色池,存储的是UIColor数组，用于设置标签的背景色
 * 该属性只有在设置hotSearchStyle为PYHotSearchStyleColorfulTag才生效
 */
@property (nonatomic, strong) NSMutableArray<UIColor *> *colorPol;

/** 所有的搜索历史标签,只有当PYSearchHistoryStyle != PYSearchHistoryStyleCell才有值 */
@property (nonatomic, copy) NSArray<UILabel *> *searchHistoryTags;


/** 搜索栏的背景色 */
@property (nonatomic, strong) UIColor *searchBarBackgroundColor;
/** 取消按钮 */
@property (nonatomic, weak) UIBarButtonItem *cancelButton;


/** 搜索建议是否隐藏 默认为：NO */
@property (nonatomic, assign) BOOL searchSuggestionHidden;
@end

@implementation LBBSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.hotSearches = [NSMutableArray new];
    
    self.hotSearchesDic = [NSMutableArray new];
    
    self.searchHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:PYSearchHistoriesPath]];
    
        [self setup];
        
        [self HotSearches:self.hotSearches];
    
    
}

/** 初始化 */
- (void)setup
{
    self.baseSearchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(SCREEN_WIDTH-10-40, 25, 40, 30);
    [right addTarget:self action:@selector(cancelDidClick) forControlEvents:UIControlEventTouchUpInside];
    [right setTitle:@"取消" forState:UIControlStateNormal];
    [right setTitleColor:RGBCOLOR(51, 51, 51) forState:UIControlStateNormal];
    right.titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIView *bc  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    bc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bc];
    // 创建搜索框
    UIView *titleView = [[UIView alloc] init];
    titleView.py_x = PYMargin * 0.5;
    titleView.py_y = 25;
    titleView.py_width = self.view.py_width -32 - titleView.py_x * 2;
    titleView.py_height = 30;
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:titleView.bounds];
    searchBar.py_width -= PYMargin * 1.5;
    searchBar.placeholder = @"请输入关键字";
    searchBar.backgroundImage = [UIImage imageNamed:@"PYSearch.bundle/clearImage"];
    //    searchBar.backgroundColor = kRGB(237, 237, 237);
    searchBar.delegate = self;
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    
    [[[self.searchBar.subviews firstObject] subviews] lastObject].backgroundColor = RGBCOLOR(237, 237, 237);
    
    UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PYSearch.bundle/cell-content-line"]];
    
    line.frame = CGRectMake(0, 64, SCREEN_WIDTH, .5);
    line.alpha = 0.7;
    [self.view addSubview:line];
    
    [bc addSubview:titleView];    // 设置头部（热门搜索）
    
    [self.view addSubview:right];
    
    UIView *headerView = [[UIView alloc] init];
    UIView *contentView = [[UIView alloc] init];
    contentView.py_y = PYMargin * 2;
    contentView.py_x = PYMargin * 1.5;
    contentView.py_width = SCREEN_WIDTH - contentView.py_x * 2;
    [headerView addSubview:contentView];
    UILabel *titleLabel = [self setupTitleLabel:@"热搜关键词"];
    self.hotSearchHeader = titleLabel;
    [contentView addSubview:titleLabel];
    // 创建热门搜索标签容器
    UIView *hotSearchTagsContentView = [[UIView alloc] init];
    hotSearchTagsContentView.py_width = contentView.py_width;
    hotSearchTagsContentView.py_y = CGRectGetMaxY(titleLabel.frame) + PYMargin*1;
    [contentView addSubview:hotSearchTagsContentView];
    self.hotSearchTagsContentView = hotSearchTagsContentView;
    self.headerContentView = contentView;
    self.baseSearchTableView.tableHeaderView = headerView;
    //    [self.baseSearchTableView reloadData];
    //    // 设置底部(清除历史搜索)
    UIView *footerView = [[UIView alloc] init];
    footerView.py_width = SCREEN_WIDTH;
    UILabel *emptySearchHistoryLabel = [[UILabel alloc] init];
    emptySearchHistoryLabel.textColor = [UIColor darkGrayColor];
    emptySearchHistoryLabel.font = [UIFont systemFontOfSize:13];
    emptySearchHistoryLabel.userInteractionEnabled = YES;
    emptySearchHistoryLabel.text = @"清除历史搜索";
    emptySearchHistoryLabel.textAlignment = NSTextAlignmentCenter;
    emptySearchHistoryLabel.py_height = 30;
    [emptySearchHistoryLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptySearchHistoryDidClick)]];
    emptySearchHistoryLabel.py_width = SCREEN_WIDTH;
    [footerView addSubview:emptySearchHistoryLabel];
    footerView.py_height = 30;
    self.baseSearchTableView.tableFooterView = footerView;
}

#pragma mark - 懒加载
- (UITableView *)baseSearchTableView
{
    if (!_baseSearchTableView) {
        UITableView *baseSearchTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        baseSearchTableView.backgroundColor =  RGBCOLOR(237, 237, 237);
        baseSearchTableView.delegate = self;
        baseSearchTableView.dataSource = self;
        [self.view addSubview:baseSearchTableView];
        _baseSearchTableView = baseSearchTableView;
    }
    return _baseSearchTableView;
}

/** 创建并设置标题 */
- (UILabel *)setupTitleLabel:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.tag = 1;
    titleLabel.textColor = RGBCOLOR(102, 102, 102);
    [titleLabel sizeToFit];
    titleLabel.py_x = 10;
    titleLabel.py_y = 40;
    return titleLabel;
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 没有搜索记录就隐藏
    self.baseSearchTableView.tableFooterView.hidden = self.searchHistories.count == 0;
    return  self.searchHistories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"PYSearchHistoryCellID";
    // 创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.textColor = RGBCOLOR(51, 51, 51);
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.backgroundColor = [UIColor clearColor];
        
        // 添加关闭按钮
        UIButton *closetButton = [[UIButton alloc] init];
        // 设置图片容器大小、图片原图居中
        closetButton.py_size = CGSizeMake(cell.py_height, cell.py_height);
        [closetButton setImage:[UIImage imageNamed:@"PYSearch.bundle/close"] forState:UIControlStateNormal];
        UIImageView *closeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PYSearch.bundle/close"]];
        [closetButton addTarget:self action:@selector(closeDidClick:) forControlEvents:UIControlEventTouchUpInside];
        closeView.contentMode = UIViewContentModeCenter;
        cell.accessoryView = closetButton;
        // 添加分割线
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PYSearch.bundle/cell-content-line"]];
        line.py_height = 0.5;
        line.alpha = 0.7;
        line.py_x = PYMargin;
        line.py_y = 43;
        line.py_width = SCREEN_WIDTH;
        [cell.contentView addSubview:line];
    }
    
    // 设置数据
    cell.imageView.image = [UIImage imageNamed:@"PYSearch.bundle/search_history"];
    cell.textLabel.text = self.searchHistories[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.searchHistories.count  ? @"  历史搜索" : nil;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出选中的cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.searchBar.text = cell.textLabel.text;
    [self searchBarSearchButtonClicked:self.searchBar];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 滚动时，回收键盘
    if (self.keyboardshowing) [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 键盘显示完成（弹出） */
- (void)keyboardDidShow:(NSNotification *)noti
{
    // 取出键盘高度
    NSDictionary *info = noti.userInfo;
    self.keyboardHeight = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.keyboardshowing = YES;
}

/** 点击取消 */
- (void)cancelDidClick
{
    [self.searchBar resignFirstResponder];
    
    // dismiss ViewController
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 回收键盘
    [searchBar resignFirstResponder];
    // 先移除再刷新
    
    if (![self.searchHistories containsObject:searchBar.text]) {
        
        //        [self.searchHistories addObject:searchBar.text];
        [self.searchHistories insertObject:searchBar.text atIndex:0];
        
    }
    
    // 保存搜索信息
    BOOL success =  [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:PYSearchHistoriesPath];
    
    if (success) {
        
        NSLog(@"22222 =3333= %@",searchBar.text);
    }
    
    
    [self.baseSearchTableView reloadData];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    NSLog(@"22222 == %@",searchText);
    
}



/** 选中标签 */
- (void)tagDidCLick:(UITapGestureRecognizer *)gr
{
    UILabel *label = (UILabel *)gr.view;
    self.searchBar.text = label.text;
    [self searchBarSearchButtonClicked:self.searchBar];
    
    
    // 刷新tableView
    [self.baseSearchTableView reloadData];
}
/** 点击清空某一个按钮 */

- (void)closeDidClick:(UIButton *)sender
{
    // 获取当前cell
    UITableViewCell *cell = (UITableViewCell *)sender.superview;
    
    // 移除搜索信息
    [self.searchHistories removeObject:cell.textLabel.text];
    // 保存搜索信息
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:PYSearchHistoriesPath];
    // 刷新tableView
    [self.baseSearchTableView reloadData];
    
}
/** 点击清空历史按钮 */
- (void)emptySearchHistoryDidClick
{
    // 移除所有历史搜索
    [self.searchHistories removeAllObjects];
    
    [self.baseSearchTableView reloadData];
    
    // 移除数据缓存
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:PYSearchHistoriesPath];
    
}

- (UIButton *)emptyButton
{
    if (!_emptyButton) {
        // 添加清空按钮
        UIButton *emptyButton = [[UIButton alloc] init];
        emptyButton.titleLabel.font = self.searchHistoryHeader.font;
        [emptyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [emptyButton setTitle:@"清空" forState:UIControlStateNormal];
        [emptyButton setImage:[UIImage imageNamed:@"PYSearch.bundle/empty"] forState:UIControlStateNormal];
        [emptyButton addTarget:self action:@selector(emptySearchHistoryDidClick) forControlEvents:UIControlEventTouchUpInside];
        [emptyButton sizeToFit];
        emptyButton.py_width += PYMargin;
        emptyButton.py_height += PYMargin;
        emptyButton.py_centerY = self.searchHistoryHeader.py_centerY;
        emptyButton.py_x = self.headerContentView.py_width - emptyButton.py_width;
        [self.headerContentView addSubview:emptyButton];
        _emptyButton = emptyButton;
    }
    return _emptyButton;
}

- (UIView *)searchHistoryTagsContentView
{
    if (!_searchHistoryTagsContentView) {
        UIView *searchHistoryTagsContentView = [[UIView alloc] init];
        searchHistoryTagsContentView.py_width = SCREEN_WIDTH - PYMargin * 2;
        searchHistoryTagsContentView.py_y = CGRectGetMaxY(self.hotSearchTagsContentView.frame)+ PYMargin;
        
        [self.headerContentView addSubview:searchHistoryTagsContentView];
        _searchHistoryTagsContentView = searchHistoryTagsContentView;
    }
    return _searchHistoryTagsContentView;
}

- (UILabel *)searchHistoryHeader
{
    if (!_searchHistoryHeader) {
        UILabel *titleLabel = [self setupTitleLabel:@"历史搜索"];
        [self.headerContentView addSubview:titleLabel];
        _searchHistoryHeader = titleLabel;
    }
    return _searchHistoryHeader;
}



#pragma mark  包装cancelButton
- (UIBarButtonItem *)cancelButton
{
    return self.navigationItem.rightBarButtonItem;
}

- (void)setCancelButton:(UIBarButtonItem *)cancelButton
{
    self.navigationItem.rightBarButtonItem = cancelButton;
}
/** 视图将要显示 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    // 没有热门搜索并且搜索历史为默认PYHotSearchStyleDefault就隐藏
    if (self.hotSearches.count == 0 ) {
        self.baseSearchTableView.tableHeaderView.py_height = 0;
        self.baseSearchTableView.tableHeaderView.hidden = YES;
    }
}

/** 视图完全显示 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 弹出键盘
    [self.searchBar becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //    self.navigationController.navigationBar.hidden = NO;
    
}


/**
 * 设置热门搜索标签(不带排名)
 * PYHotSearchStyleNormalTag || PYHotSearchStyleColorfulTag ||
 * PYHotSearchStyleBorderTag || PYHotSearchStyleARCBorderTag
 */
- (void)setupHotSearchNormalTags
{
    // 添加和布局标签
    self.hotSearchTags = [self addAndLayoutTagsWithTagsContentView:self.hotSearchTagsContentView tagTexts:self.hotSearches];
}

/**
 * 设置搜索历史标签
 * PYSearchHistoryStyleTag
 */
- (void)setupSearchHistoryTags
{
    // 隐藏尾部清除按钮
    self.baseSearchTableView.tableFooterView = nil;
    // 添加搜索历史头部
    self.searchHistoryHeader.py_y = self.hotSearches.count > 0 ? CGRectGetMaxY(self.hotSearchTagsContentView.frame) + PYMargin : 0;
    self.searchHistoryTagsContentView.py_y = CGRectGetMaxY(self.emptyButton.frame) + PYMargin;
    // 添加和布局标签
    self.searchHistoryTags = [self addAndLayoutTagsWithTagsContentView:self.searchHistoryTagsContentView tagTexts:[self.searchHistories copy]];
}

/** 添加标签 */
- (UILabel *)labelWithTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.userInteractionEnabled = YES;
    label.font = [UIFont systemFontOfSize:14];
    label.text = title;
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor py_colorWithHexString:@"#fafafa"];
    label.layer.cornerRadius = 3;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.py_width += 20;
    label.py_height += 14;
    return label;
}
/**  添加和布局标签 */
- (NSArray *)addAndLayoutTagsWithTagsContentView:(UIView *)contentView tagTexts:(NSArray*)tagTexts;
{
    // 清空标签容器的子控件
    [contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 添加热门搜索标签
    NSMutableArray *tagsM = [NSMutableArray array];
    for (int i = 0; i < tagTexts.count; i++) {
        UILabel *label = [self labelWithTitle:tagTexts[i]];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [contentView addSubview:label];
        [tagsM addObject:label];
    }
    
    // 计算位置
    CGFloat currentX = 0;
    CGFloat currentY = 0;
    CGFloat countRow = 0;
    CGFloat countCol = 0;
    
    // 调整布局
    for (UILabel *subView in tagsM) {
        // 当搜索字数过多，宽度为contentView的宽度
        if (subView.py_width > contentView.py_width) subView.py_width = contentView.py_width;
        if (currentX + subView.py_width + PYMargin * countRow > contentView.py_width) { // 得换行
            subView.py_x = 0;
            subView.py_y = (currentY += subView.py_height) + PYMargin * ++countCol;
            currentX = subView.py_width;
            countRow = 1;
        } else { // 不换行
            subView.py_x = (currentX += subView.py_width) - subView.py_width + PYMargin * countRow;
            subView.py_y = currentY + PYMargin * countCol;
            countRow ++;
        }
        
        subView.layer.cornerRadius = subView.py_height*0.5;
        subView.layer.borderColor = RGBCOLOR(203, 203, 203).CGColor;
        subView.layer.borderWidth = 0.5;
        subView.textColor = RGBCOLOR(51, 51, 51);
    }
    // 设置contentView高度
    contentView.py_height = CGRectGetMaxY(contentView.subviews.lastObject.frame);
    // 设置头部高度
    self.baseSearchTableView.tableHeaderView.py_height = self.headerContentView.py_height = CGRectGetMaxY(contentView.frame) + PYMargin;
    // 重新赋值, 注意：当操作系统为iOS 9.x系列的tableHeaderView高度设置失效，需要重新设置tableHeaderView
    [self.baseSearchTableView setTableHeaderView:self.baseSearchTableView.tableHeaderView];
    return [tagsM copy];
}

#pragma mark - setter
- (void)setSearchBarBackgroundColor:(UIColor *)searchBarBackgroundColor
{
    _searchBarBackgroundColor = searchBarBackgroundColor;
    
    // 取出搜索栏的textField设置其背景色
    for (UIView *subView in [[self.searchBar.subviews lastObject] subviews]) {
        if ([[subView class] isSubclassOfClass:[UITextField class]]) { // 是UItextField
            // 设置UItextField的背景色
            UITextField *textField = (UITextField *)subView;
            textField.backgroundColor = searchBarBackgroundColor;
            // 退出循环
            break;
        }
    }
}


- (void)setRankTagBackgroundColorHexStrings:(NSArray<NSString *> *)rankTagBackgroundColorHexStrings
{
    if (rankTagBackgroundColorHexStrings.count < 4) { // 不符合要求，使用基本设置
        NSArray *colorStrings = @[@"#f14230", @"#ff8000", @"#ffcc01", @"#ebebeb"];
        _rankTagBackgroundColorHexStrings = colorStrings;
    } else { // 取前四个
        _rankTagBackgroundColorHexStrings = @[rankTagBackgroundColorHexStrings[0], rankTagBackgroundColorHexStrings[1], rankTagBackgroundColorHexStrings[2], rankTagBackgroundColorHexStrings[3]];
    }
    
    // 刷新
    self.hotSearches = self.hotSearches;
}

- (void)HotSearches:(NSMutableArray *)hotSearches
{
    _hotSearches = hotSearches;
    // 没有热门搜索,隐藏相关控件，直接返回
    if (hotSearches.count == 0) {
        self.hotSearchTagsContentView.hidden = YES;
        self.hotSearchHeader.hidden = YES;
        return;
    };
    
    
    [self setupHotSearchNormalTags];
    
}

- (void)SearchHistoryStyle
{
    for (UILabel *tag in self.searchHistoryTags) {
        // 设置背景色为clearColor
        tag.backgroundColor = [UIColor clearColor];
        // 设置边框颜色
        tag.layer.borderColor = RGBCOLOR(223, 223, 223).CGColor;
        // 设置边框宽度
        tag.layer.borderWidth = 0.5;
        // 设置边框弧度为圆弧
        tag.layer.cornerRadius = tag.py_height * 0.5;
    }}

- (void)HotSearchStyle
{
    
    for (UILabel *tag in self.hotSearchTags) {
        // 设置背景色为clearColor
        tag.backgroundColor = [UIColor clearColor];
        // 设置边框颜色
        tag.layer.borderColor = RGBCOLOR(203, 203, 203).CGColor;
        // 设置边框宽度
        tag.layer.borderWidth = 0.5;
        tag.textColor = RGBCOLOR(51, 51, 51);
        // 设置边框弧度为圆弧
        tag.layer.cornerRadius = tag.py_height * 0.5;
    }
    
}




@end
