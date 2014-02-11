//
//  FarmBackgroundScene.m
//  FarmView
//
//  Created by Mac on 13-12-25.
//  Copyright (c) 2013年 Cisco. All rights reserved.
//

#import "FarmBaseScene.h"

@interface FarmBaseScene()
@property BOOL contentCreated;
@property (nonatomic) SKNode *world;                    // root node to which all game renderables are attached
@property (nonatomic) NSMutableArray *layers;           // different layer nodes within the world
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval; // the previous update: loop time interval
@end


@implementation FarmBaseScene

#pragma mark - Initialization
- (instancetype)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
      
        _world = [[SKNode alloc] init];
        [_world setName:@"world"];
        _layers = [NSMutableArray arrayWithCapacity:kWorldLayerCount];
        for (int i = 0; i < kWorldLayerCount; i++) {
            SKNode *layer = [[SKNode alloc] init];
            layer.zPosition = i - kWorldLayerCount;
            [_world addChild:layer];
            [(NSMutableArray *)_layers addObject:layer];
        }
        
        [self addChild:_world];
        
    }
    return self;
}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:GCControllerDidConnectNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:GCControllerDidDisconnectNotification object:nil];
}



-(void)didMoveToView:(SKView *)view
{
    if(!self.contentCreated)
    {
        [self  createSceneContents];
        self.contentCreated = YES;
    }
}

-(void)createSceneContents
{
    NSLog(@"createSceneContents");
    self.backgroundColor = [SKColor blackColor];
 
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild:[self newBackgroundNode]];
}

-(SKSpriteNode *)newBackgroundNode
{
    SKSpriteNode *backNode = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(64,32)];
    backNode.name = @"helloNode";//@ 这个和下面的一样
    backNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    return backNode;
}



#pragma mark - Loop Update
- (void)update:(NSTimeInterval)currentTime {
    NSLog(@"update the scene:");
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = kMinTimeInterval;
        self.lastUpdateTimeInterval = currentTime;
        self.worldMovedForUpdate = YES;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
}


#pragma mark - Add the character into the scence
- (void)addNode:(SKNode *)node atWorldLayer:(APAWorldLayer)layer {
    SKNode *layerNode = self.layers[layer];
    [layerNode addChild:node];
}

#pragma mark - response to the touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    SKNode *helloNode = [self childNodeWithName:@"helloNode"]; //@与上面的相同
    if(helloNode !=nil)
    {
        helloNode.name = nil;
        SKAction *moveUp = [SKAction moveByX:0 y:100.0 duration:0.5]; //向上移动
        SKAction *zoom = [SKAction scaleTo:2.0 duration:0.25];    //扩大两倍
        SKAction *pause = [SKAction waitForDuration:0.5];    //暂停
        SKAction *fadeAway = [SKAction fadeOutWithDuration:0.25];  //消失
        SKAction *remove = [SKAction removeFromParent];
        SKAction *moveSequence = [SKAction sequence:@[moveUp, zoom, pause, fadeAway, remove]];
        [helloNode runAction:moveSequence];

    }
}

#pragma mark - Shared Assets
+ (void)loadSceneAssetsWithCompletionHandler:(APAAssetLoadCompletionHandler)handler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        // Load the shared assets in the background.
        [self loadSceneAssets];
        
        if (!handler) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Call the completion handler back on the main queue.
            handler();
        });
    });
}


#pragma mark - Shared Assets
+ (void)loadSceneAssets {
    // Overridden by subclasses.
}

+ (void)releaseSceneAssets {
    // Overridden by subclasses.
}

- (void)updateWithTimeSinceLastUpdate:(NSTimeInterval)timeSinceLast {
    // Overridden by subclasses.
}



@end
