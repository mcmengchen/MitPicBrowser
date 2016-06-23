//
//  MicAssetModel.h
//  MitPicBrowser
//
//  Created by william on 16/6/23.
//  Copyright © 2016年 Mitchell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




typedef NS_ENUM(NSUInteger, MitAssetModelMediaType) {
    MitAssetModelMediaTypePhoto,
    MitAssetModelMediaTypeLivePhoto,
    MitAssetModelMediaTypeVideo,
    MitAssetModelMediaTypeAudio
};


@class PHAsset;
@interface MitAssetModel : NSObject

@property (nonatomic, strong) id asset;             ///< PHAsset or ALAsset
@property (nonatomic, assign) BOOL isSelected;      ///< The select status of a photo, default is No
@property (nonatomic, assign) MitAssetModelMediaType type;
@property (nonatomic, copy) NSString *timeLength;

/// Init a photo dataModel With a asset
/// 用一个PHAsset/ALAsset实例，初始化一个照片模型
+ (instancetype)modelWithAsset:(id)asset type:(MitAssetModelMediaType)type;
+ (instancetype)modelWithAsset:(id)asset type:(MitAssetModelMediaType)type timeLength:(NSString *)timeLength;
@end
