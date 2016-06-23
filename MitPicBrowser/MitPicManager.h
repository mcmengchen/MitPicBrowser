//
//  MitPicManager.h
//  MitPicBrowser
//
//  Created by william on 16/6/23.
//  Copyright © 2016年 Mitchell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "MitAlbumModel.h"
#import "MitAssetModel.h"


@interface MitPicManager : NSObject

+ (instancetype)manager;
/**
 *   是否修改照片的方向
 */
@property (nonatomic, assign) BOOL shouldFixOrientation;
@property (nonatomic, assign) CGFloat photoPreviewMaxWidth;
/// Return YES if Authorized 返回YES如果得到了授权
- (BOOL)authorizationStatusAuthorized;
- (NSString *)getAssetIdentifier:(id)asset;

/**
 *  获取相机胶卷
 *
 *  @param allowPickingVideo 允许返回视频
 *  @param completion        回调
 */
- (void)getCameraRollAlbum:(BOOL)allowPickingVideo completion:(void (^)(MitAlbumModel *model))completion;

/**
 *  获取相册数组
 *
 *  @param allowPickingVideo 允许返回视频
 *  @param completion        回调
 */
- (void)getAllAlbums:(BOOL)allowPickingVideo completion:(void (^)(NSArray<MitAlbumModel *> *models))completion;

/**
 *  根据获取的结果获取 Asset 数组
 *
 *  @param result            获取结果
 *  @param allowPickingVideo 允许返回视频
 *  @param completion        回调
 */
- (void)getAssetsFromFetchResult:(id)result allowPickingVideo:(BOOL)allowPickingVideo completion:(void (^)(NSArray<MitAssetModel *> *models))completion;
- (void)getAssetFromFetchResult:(id)result atIndex:(NSInteger)index allowPickingVideo:(BOOL)allowPickingVideo completion:(void (^)(MitAssetModel *model))completion;

/// Get photo 获得照片

/**
 *  获取照片
 *
 *  @param model      相册模型
 *  @param completion 回调
 */
- (void)getPostImageWithAlbumModel:(MitAlbumModel *)model completion:(void (^)(UIImage *postImage))completion;
- (void)getPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;
- (PHImageRequestID)getPhotoWithAsset:(id)asset photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;
- (void)getOriginalPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info))completion;

/**
 *  获取视频
 *
 *  @param asset       相册
 *  @param completion  回调
 */
- (void)getVideoWithAsset:(id)asset completion:(void (^)(AVPlayerItem * playerItem, NSDictionary * info))completion;

/**
 *  获取一组照片的大小
 *
 *  @param photos     一组照片
 *  @param completion 回调
 */
- (void)getPhotosBytesWithArray:(NSArray *)photos completion:(void (^)(NSString *totalBytes))completion;
@end
