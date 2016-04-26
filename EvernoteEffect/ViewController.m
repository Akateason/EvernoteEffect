//
//  ViewController.m
//  EvernoteEffect
//
//  Created by teason on 16/4/25.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "ViewController.h"
#import "EvernoteLayout.h"
#import "CollectionViewCell.h"

static NSString *reuseIdentifier = @"Cell" ;
static CGFloat topPadding = 20 ;

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray      *colorArray ;
    NSInteger           rowNumber ;
    UICollectionView    *collectionView ;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    colorArray = [@[] mutableCopy] ;
    rowNumber = 15 ;
    self.view.backgroundColor = [UIColor lightGrayColor] ;
    EvernoteLayout *layout = [[EvernoteLayout alloc] init] ;
    collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,
                                                                        topPadding,
                                                                        screenWidth,
                                                                        screenHeight - topPadding)
                                        collectionViewLayout:layout] ;
    collectionView.backgroundColor = [UIColor lightGrayColor] ;
    collectionView.dataSource = self ;
    collectionView.delegate = self ;
    collectionView.alwaysBounceVertical = false ;
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, verticallyPadding, 0) ;
    
    [self.view addSubview:collectionView] ;
    UINib *nib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil] ;
    [collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier] ;
    
    double random = arc4random() % 360 ;
    for (int i = 0; i < rowNumber; i++)
    {
        double rate = ((int)(random + i * 6.)) % 360 / 360. ;
        UIColor *color = [UIColor colorWithHue:rate
                                    saturation:0.8
                                    brightness:1.
                                         alpha:1.] ;
        [colorArray addObject:color] ;
    }
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return colorArray.count ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath] ;
    cell.backgroundColor = colorArray[colorArray.count - 1 - indexPath.section] ;
    cell.label.text = [NSString stringWithFormat:@"Notebook + %@",@(indexPath.section + 1)] ;
    cell.label.textColor = [UIColor whiteColor] ;
    return cell ;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
