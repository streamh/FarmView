//
//  FarmViewMultiplayerScene.h
//  FarmView
//
//  Created by Mac on 14-01-26.
//  Copyright (c) 2014年 Cisco. All rights reserved.
//

#import "FarmBaseScene.h"

#define kWorldTileDivisor 32  // number of tiles
#define kWorldSize 4096       // pixel size of world (square)
#define kWorldTileSize (kWorldSize / kWorldTileDivisor)

#define kWorldCenter 2048

@interface FarmViewMultiLayersScene : FarmBaseScene

@end
