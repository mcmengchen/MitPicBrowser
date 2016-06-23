//
//  MicAssetModel.m
//  MitPicBrowser
//
//  Created by william on 16/6/23.
//  Copyright © 2016年 Mitchell. All rights reserved.
//

#import "MitAssetModel.h"

@implementation MitAssetModel

+ (instancetype)modelWithAsset:(id)asset type:(MitAssetModelMediaType)type{
    MitAssetModel *model = [[MitAssetModel alloc] init];
    model.asset = asset;
    model.isSelected = NO;
    model.type = type;
    return model;
}

+ (instancetype)modelWithAsset:(id)asset type:(MitAssetModelMediaType)type timeLength:(NSString *)timeLength {
    MitAssetModel *model = [self modelWithAsset:asset type:type];
    model.timeLength = timeLength;
    return model;
}
@end
