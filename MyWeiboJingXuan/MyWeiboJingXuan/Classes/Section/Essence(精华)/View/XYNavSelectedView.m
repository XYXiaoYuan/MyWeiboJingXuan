//
//  XYNavSelectedView.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYNavSelectedView.h"
#import "XYTitleButton.h"

@interface XYNavSelectedView ()
@property (nonatomic, weak)UIView *underLine;
@property (nonatomic, strong)XYTitleButton *selectedBtn;
@property (nonatomic, weak)XYTitleButton *allBtn;
@end


@implementation XYNavSelectedView

- (UIView *)underLine
{
    if (!_underLine) {
        UIView *underLine = [[UIView alloc] init];
        
        // 设置下划线的frame
        CGFloat underLineX = 0;
        CGFloat underLineY = self.xy_height;
        CGFloat underLineW = self.allBtn.titleLabel.xy_width;
        CGFloat underLineH = 2;
        underLine.frame = CGRectMake(underLineX, underLineY, underLineW, underLineH);
        underLine.backgroundColor = [UIColor redColor];
        [self addSubview:underLine];
        _underLine = underLine;
    }
    return _underLine;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    XYTitleButton *allBtn = [self createBtn:@"全部" tag:XYNavTypeTypeAll];
    XYTitleButton *videoBtn = [self createBtn:@"视频" tag:XYNavTypeTypeVideo];
    XYTitleButton *voiceBtn = [self createBtn:@"声音" tag:XYNavTypeTypeVoice];
    XYTitleButton *picBtn = [self createBtn:@"图片" tag:XYNavTypeTypePicture];
    XYTitleButton *wordBtn = [self createBtn:@"段子" tag:XYNavTypeTypeWord];
    
    [self addSubview:allBtn];
    [self addSubview:videoBtn];
    [self addSubview:voiceBtn];
    [self addSubview:picBtn];
    [self addSubview:wordBtn];
    _allBtn = allBtn;
    
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(@((XYSCREEN_W - 45 * XYWidthRatio) / 5));
    }];
    
    [videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(allBtn.mas_trailing);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(allBtn.mas_width);
    }];
    
    [voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(videoBtn.mas_trailing);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(allBtn.mas_width);

    }];
    
    [picBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(voiceBtn.mas_trailing);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(allBtn.mas_width);
    }];
    
    [wordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(picBtn.mas_trailing);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(allBtn.mas_width);
    }];
    
    // 强制更新一次
    [self layoutIfNeeded];
    // 默认选中最热
    [self titleButtonClick:allBtn];
    
}

- (XYTitleButton *)createBtn:(NSString *)title tag:(XYNavType)tag
{
    XYTitleButton *btn = [XYTitleButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = XYFont(17);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

// 点击事件
- (void)titleButtonClick:(XYTitleButton *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.xy_x = btn.xy_x + ((btn.xy_width - btn.titleLabel.xy_width) * 0.5);
    }];
    
    if (self.selectedBlock) {
        self.selectedBlock(btn.tag);
    }
}


@end
