//
//  MitAlbumModel.h
//  MitPicBrowser
//
//  Created by william on 16/6/23.
//  Copyright © 2016年 Mitchell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MitAlbumModel : NSObject
@property (nonatomic, strong) NSString *name;        ///< The album name
@property (nonatomic, assign) NSInteger count;       ///< Count of photos the album contain
@property (nonatomic, strong) id result;             ///< PHFetchResult<PHAsset> or ALAssetsGroup<ALAsset>
@end
