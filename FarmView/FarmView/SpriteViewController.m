//
//  SpriteViewController.m
//  FarmView
//
//  Created by Mac on 13-12-25.
//  Copyright (c) 2013年 Cisco. All rights reserved.
//

#import "SpriteViewController.h"
#import "FarmViewMultiLayersScene.h"

@interface SpriteViewController ()
@property (nonatomic) IBOutlet SKView *skView;
@property (nonatomic) IBOutlet UIImageView *gameLogo;
@property (nonatomic) IBOutlet UIActivityIndicatorView *loadingProgressIndicator;
@property (nonatomic) FarmViewMultiLayersScene *scene;
@end

@implementation SpriteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    SKView *spriteView = (SKView*)self.view;
//    
//    spriteView.showsFPS = YES;
//    spriteView.showsDrawCount = YES;
//    spriteView.showsNodeCount = YES;
    
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)viewWillAppear:(BOOL)animated
{
    // Start the progress indicator animation.
    [self.loadingProgressIndicator startAnimating];
    
    // Load the shared assets of the scene before we initialize and load it.
    [FarmViewMultiLayersScene loadSceneAssetsWithCompletionHandler:^{
        CGSize viewSize = self.view.bounds.size;
        NSLog(@"The view size is: %f, %f",viewSize.width,viewSize.height);
        // On iPhone/iPod touch we want to see a similar amount of the scene as on iPad.
        // So, we set the size of the scene to be double the size of the view, which is
        // the whole screen, 3.5- or 4- inch. This effectively scales the scene to 50%.
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            viewSize.height *= 2;
            viewSize.width *= 2;
        }
        
        FarmViewMultiLayersScene* background = [[FarmViewMultiLayersScene alloc] initWithSize:viewSize];
        background.scaleMode = SKSceneScaleModeAspectFill;
        self.scene = background;
    
        [self.loadingProgressIndicator stopAnimating];
        [self.loadingProgressIndicator setHidden:YES];
        
        
        [self.skView presentScene:background];
//        SKView *spriteView = (SKView*)self.view;
//        [spriteView presentScene:background];
//        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            self.archerButton.alpha = 1.0f;
//            self.warriorButton.alpha = 1.0f;
//        } completion:NULL];

    }];
    
#ifdef SHOW_DEBUG_INFO
    // Show debug information.
    self.skView.showsFPS = YES;
    self.skView.showsDrawCount = YES;
    self.skView.showsNodeCount = YES;
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
