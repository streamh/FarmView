//
//  FarmViewMultiplayerScene.m
//  FarmView
//
//  Created by Mac on 14-01-26.
//  Copyright (c) 2014年 Cisco. All rights reserved.
//

#import "FarmViewMultiLayersScene.h"

@interface FarmViewMultiLayersScene () <SKPhysicsContactDelegate>

@end


@implementation FarmViewMultiLayersScene




#pragma mark - Initialization and Deallocation
- (id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        //initialize the world.
        [self buildWorld];
        
    }
    return self;
}

- (void)dealloc {
    //release the resource.
}

#pragma mark - World Building
- (void)buildWorld {
    NSLog(@"Building the world");
    
    // Configure physics for the world.
    self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f); // no gravity
    self.physicsWorld.contactDelegate = self;
    
    [self addBackgroundTiles];
    
    [self addComponents];
    
}


- (void)addBackgroundTiles {
    // Tiles should already have been pre-loaded in +loadSceneAssets.
    for (SKNode *tileNode in [self backgroundTiles]) {
        [self addNode:tileNode atWorldLayer:APAWorldLayerGround];
    }
}


- (void)addComponents{
    //add the contents to the layers.
}



#pragma mark - Loop Update
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    // Update all players' heroes.
    NSLog(@"update the characters in the scence.");
    
    
//    for (APAHeroCharacter *hero in self.heroes) {
//        [hero updateWithTimeSinceLastUpdate:timeSinceLast];
//    }
    
    // Update the level boss.
//    [self.levelBoss updateWithTimeSinceLastUpdate:timeSinceLast];
    
    // Update the caves (and in turn, their goblins).
//    for (APACave *cave in self.goblinCaves) {
//        [cave updateWithTimeSinceLastUpdate:timeSinceLast];
//    }
}

- (void)didSimulatePhysics {
    [super didSimulatePhysics];
    
    
}


#pragma mark - Physics Delegate
- (void)didBeginContact:(SKPhysicsContact *)contact {

    
}


#pragma mark - Shared Assets
+ (void)loadSceneAssets {
   
    // Load the tiles that make up the ground layer.
    [self loadWorldTiles];
    
}

+ (void)loadWorldTiles {
    NSLog(@"Loading world tiles");
    NSDate *startDate = [NSDate date];
    
    SKTextureAtlas *tileAtlas = [SKTextureAtlas atlasNamed:@"Tiles"];
    
    sBackgroundTiles = [[NSMutableArray alloc] initWithCapacity:1024];
    for (int y = 0; y < kWorldTileDivisor; y++) {
        for (int x = 0; x < kWorldTileDivisor; x++) {
            int tileNumber = (y * kWorldTileDivisor) + x;
            SKSpriteNode *tileNode = [SKSpriteNode spriteNodeWithTexture:[tileAtlas textureNamed:[NSString stringWithFormat:@"tile%d.png", tileNumber]]];
            CGPoint position = CGPointMake((x * kWorldTileSize) - kWorldCenter,
                                           (kWorldSize - (y * kWorldTileSize)) - kWorldCenter);
            tileNode.position = position;
            tileNode.zPosition = -1.0f;
            tileNode.blendMode = SKBlendModeReplace;
            [(NSMutableArray *)sBackgroundTiles addObject:tileNode];
        }
    }
    NSLog(@"Loaded all world tiles in %f seconds", [[NSDate date] timeIntervalSinceDate:startDate]);
}

+ (void)releaseSceneAssets {
    // Get rid of everything unique to this scene (but not the characters, which might appear in other scenes).
    sBackgroundTiles = nil;

}

static NSArray *sBackgroundTiles = nil;
- (NSArray *)backgroundTiles {
    return sBackgroundTiles;
}
@end
