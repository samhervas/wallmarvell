//
//  File.swift
//  Wallamarvel
//
//  Created by Samuel Hervás on 25/2/16.
//  Copyright © 2016 Samuel Hervás Gómez. All rights reserved.
//

import UIKit

class TransitionToCharacterDetail: NSObject,UIViewControllerAnimatedTransitioning {

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? HeroesCollectionViewController
            else {
                return
            }
        guard let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? DetailCharacterViewController
            else {
                return
            }
        
        guard let containerView = transitionContext.containerView()
            else {
                return
            }
        let duration = transitionDuration(transitionContext);
        guard let indexPath = fromViewController.collectionView!.indexPathsForSelectedItems()?[0]
            else{
                return
            }
        guard let cell = fromViewController.collectionView.cellForItemAtIndexPath(indexPath) as? CharacterCollectionViewCell
            else {
                return
            }
        
       let cellImageSnapshot = cell.thumbailImage.snapshotViewAfterScreenUpdates(false)
        cellImageSnapshot.frame = containerView.convertRect(cell.thumbailImage!.frame,fromView:cell.thumbailImage!.superview)
        
        toViewController.view.frame = transitionContext.finalFrameForViewController(toViewController);
        toViewController.view.alpha = 0;
        toViewController.thumbnailImage.hidden = true;
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(cellImageSnapshot)
        // A small trick to let the UI fully calculate the frames
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            UIView.animateWithDuration(duration, animations:{
                toViewController.view.alpha = 1.0;
                let frame = containerView.convertRect(toViewController.thumbnailImage.frame,fromView:toViewController.thumbnailImage.superview)
                cellImageSnapshot.frame = frame
                }, completion: { (finished: Bool) in
                    toViewController.thumbnailImage.hidden = false;
                    cell.hidden = false;
                    cellImageSnapshot.removeFromSuperview()
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
        }

    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
}