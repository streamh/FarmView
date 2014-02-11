//
//  FarmBackgroundScene.h
//  FarmView
//
//  Created by Mac on 13-12-25.
//  Copyright (c) 2013年 Cisco. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
/* The layers in a scene. */
typedef enum : uint8_t {
	APAWorldLayerGround = 0,
	APAWorldLayerBelowCharacter,
	APAWorldLayerCharacter,
	APAWorldLayerAboveCharacter,
	APAWorldLayerTop,
	kWorldLayerCount
} APAWorldLayer;

#define kMinTimeInterval (1.0f / 60.0f)

/* Completion handler for callback after loading assets asynchronously. */
typedef void (^APAAssetLoadCompletionHandler)(void);

@interface FarmBaseScene : SKScene

@property (nonatomic, readonly) SKNode *world;              // root node to which all game renderables are attached
@property (nonatomic) BOOL worldMovedForUpdate;                 // indicates the world moved before or during the current update


/* Start loading all the shared assets for the scene in the background. This method calls +loadSceneAssets
 on a background queue, then calls the callback handler on the main thread. */
+ (void)loadSceneAssetsWithCompletionHandler:(APAAssetLoadCompletionHandler)callback;

/* Overridden by subclasses to load scene-specific assets. */
+ (void)loadSceneAssets;

/* Overridden by subclasses to release assets used only by this scene. */
+ (void)releaseSceneAssets;

/* Overridden by subclasses to update the scene - called once per frame. */
- (void)updateWithTimeSinceLastUpdate:(NSTimeInterval)timeSinceLast;

/* All sprites in the scene should be added through this method to ensure they are placed in the correct world layer. */
- (void)addNode:(SKNode *)node atWorldLayer:(APAWorldLayer)layer;


@end
