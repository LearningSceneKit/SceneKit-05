//
//  ViewController.m
//  SceneKit-05
//
//  Created by ShiWen on 2017/6/19.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "ViewController.h"


#import <SceneKit/SceneKit.h>

@interface ViewController ()

@property (nonatomic,strong) SCNView *mScnView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SCNScene *scene = [SCNScene scene];
    self.mScnView.scene = scene;
    [self.view addSubview:self.mScnView];
//    添加盒子
    [self addBox];
//    添加相机
    [self addCamera];

}
-(void)addBox{
    SCNBox *box = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
    box.firstMaterial.diffuse.contents = [UIImage imageNamed:@"box2.jpg"];
    SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
    [self.mScnView.scene.rootNode addChildNode:boxNode];
    [boxNode runAction:[self addAction]];
}
-(void)addCamera{
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 50);
    [self.mScnView.scene.rootNode addChildNode:cameraNode];
}

-(SCNView *)mScnView{
    if (!_mScnView) {
        _mScnView = [[SCNView alloc] initWithFrame:self.view.bounds];
        _mScnView.backgroundColor = [UIColor blackColor];
        _mScnView.center = self.view.center;
        _mScnView.allowsCameraControl = YES;
        
    }
    return _mScnView;
}

-(SCNAction*)addAction{
//    X轴转
    SCNAction *rotationX = [SCNAction rotateByAngle:-2*M_PI aroundAxis:SCNVector3Make(1, 0, 0) duration:2];
//    Y轴转
    SCNAction *rotationY = [SCNAction rotateByAngle:2*M_PI aroundAxis:SCNVector3Make(0, 1, 0) duration:2];
//    设置旋转顺序
    SCNAction *rotateSequence = [SCNAction sequence:@[rotationX,rotationY]];
    
    
    SCNAction *moveUP = [SCNAction moveTo:SCNVector3Make(0, 20, 0) duration:2];
    SCNAction *moveDown = [SCNAction moveTo:SCNVector3Make(0, -20, 0) duration:2];
//    设置移动顺序
    SCNAction *moveSequence = [SCNAction sequence:@[moveUP,moveDown]];
//    组合动作 上移x轴转动，下移y轴转动
    SCNAction *group = [SCNAction group:@[moveSequence,rotateSequence]];
    return [SCNAction repeatActionForever:group];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
