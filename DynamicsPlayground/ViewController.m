//
//  ViewController.m
//  DynamicsPlayground
//
//  Created by Chris on 12/30/13.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

UIDynamicAnimator* _animator;
UIGravityBehavior* _gravity;
UICollisionBehavior* _collision;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView* square = [[UIView alloc] initWithFrame:(CGRectMake(100, 100, 100, 100))];
    square.backgroundColor = [UIColor redColor];
    [self.view addSubview:square];
    
    UIView* barrier = [[UIView alloc] initWithFrame:(CGRectMake(0, 300, 130, 20))];
    barrier.backgroundColor = [UIColor blueColor];
    [self.view addSubview:barrier];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];
    [_animator addBehavior:_gravity];
    _collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collision];
    
    CGPoint rightEdge = CGPointMake(barrier.frame.origin.x + barrier.frame.size.width, barrier.frame.origin.y);
    [_collision addBoundaryWithIdentifier:@"barrier"
                                fromPoint:barrier.frame.origin
                                  toPoint:rightEdge];
    _collision.action = ^{
        NSLog(@"%@, %@", NSStringFromCGAffineTransform(square.transform), NSStringFromCGPoint(square.center));
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
