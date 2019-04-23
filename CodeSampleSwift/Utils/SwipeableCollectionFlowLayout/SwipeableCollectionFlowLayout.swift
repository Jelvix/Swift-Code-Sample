//
//  SwipeableCollectionFlowLayout.swift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//

import UIKit

enum SwipeDirection: CGFloat {
    case left = -2000.0
    case right = 2000.0
}

protocol SwipeableCollectionDelegate: class {
    func cardDidFinishSwiping(direction: SwipeDirection)
    func cardSwipeDidCancel()
    func cardDidChangeSwipeProgress(progress: CGFloat, swipeDirection: SwipeDirection)
}

class SwipeableCollectionFlowLayout: UICollectionViewLayout {
    weak var delegate: SwipeableCollectionDelegate?
    var gesturesEnabled: Bool = false {
        didSet {
            if (gesturesEnabled) {
                let recognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
                recognizer.maximumNumberOfTouches = 1
                collectionView?.addGestureRecognizer(recognizer)
                panGestureRecognizer = recognizer
            } else {
                if let recognizer = panGestureRecognizer {
                    collectionView?.removeGestureRecognizer(recognizer)
                }
            }
        }
    }
    
    fileprivate var cardsCount: Int = 2 //The maximum number of visible cards.
    fileprivate let draggedCellIndexPath = IndexPath(item: 0, section: 0)
    fileprivate var initialCellCenter: CGPoint?
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer?
    fileprivate let minXToSwipe: CGFloat = 100
    fileprivate let defaultRotationAngle: CGFloat = (CGFloat(Double.pi) / 10.0)
    
    override open var collectionViewContentSize : CGSize {
        return collectionView!.frame.size
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var indexPaths = [IndexPath]()
        for i in 0..<Int(collectionView!.numberOfItems(inSection: 0)) {
            indexPaths.append(IndexPath(item: i, section: 0))
        }
        let layoutAttributes = indexPaths.map { self.layoutAttributesForItem(at: $0) }.filter { $0 != nil }.map {
            $0!
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.isHidden = (attributes.indexPath.item >= cardsCount) //Hide cards for best perfomance
        attributes.frame = collectionView!.bounds
        if indexPath.item == 0  {
            attributes.zIndex = 100000
        } else {
            attributes.zIndex = (1000 - indexPath.item)
        }
        return attributes
    }
    
    //MARK: Handle pan gesture
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            bringTopCardToFront()
        case .changed:
            let newCenter = sender.translation(in: collectionView!)
            updateTopCardPosition(newCenter)
        default:
            didFinishDragging()
        }
    }
}

//MARK: Private part
extension SwipeableCollectionFlowLayout {
    fileprivate func bringTopCardToFront() {
        if let cell = collectionView!.cellForItem(at: draggedCellIndexPath) {
            initialCellCenter = cell.center
            collectionView?.bringSubview(toFront: cell)
        }
    }
    
    fileprivate func updateTopCardPosition(_ touchCoordinate:CGPoint) {
        if let cell = collectionView?.cellForItem(at: draggedCellIndexPath) {
            let rotationStrength = min(touchCoordinate.x / collectionView!.frame.width, 1)
            let rotationAngle = defaultRotationAngle * rotationStrength
            let scaleStrength = 1 - ((1 - 0.8) * fabs(rotationStrength))
            let scale = max(scaleStrength, 0.8)
            
            var transform = CGAffineTransform.identity
            transform = transform.scaledBy(x: scale, y: 1)
            transform = transform.rotated(by: rotationAngle)

            let newCenterX = (initialCellCenter!.x + touchCoordinate.x)
            let newCenterY = (initialCellCenter!.y + touchCoordinate.y)
            cell.center = CGPoint(x: newCenterX, y:newCenterY)
            cell.transform = transform
            
            let swipeProgress = abs(cell.center.x - initialCellCenter!.x) / minXToSwipe
            let swipeDirection: SwipeDirection = (initialCellCenter!.x > cell.center.x) ? .left : .right
            delegate?.cardDidChangeSwipeProgress(progress: swipeProgress, swipeDirection: swipeDirection)
        }
    }
    
    fileprivate func didFinishDragging() {
        if let cell = collectionView?.cellForItem(at: draggedCellIndexPath) {
            let deltaX = abs(cell.center.x - initialCellCenter!.x)
            let shouldSnapBack = (deltaX < minXToSwipe)
            if shouldSnapBack {
                UIView.animate(withDuration: AnimationConstants.animationSpeed, animations: {
                    cell.center = self.initialCellCenter!
                    cell.transform = CGAffineTransform.identity
                })
                self.delegate?.cardSwipeDidCancel()
            } else {
                collectionView?.isUserInteractionEnabled = false
                let swipeDirection: SwipeDirection = (initialCellCenter!.x > cell.center.x) ? .left : .right
                UIView.animate(withDuration: AnimationConstants.animationSpeed, animations: {
                    cell.center.x = swipeDirection.rawValue
                }, completion: { _ in
                    self.collectionView?.isUserInteractionEnabled = true
                    UIView.setAnimationsEnabled(false)
                    self.delegate?.cardDidFinishSwiping(direction: swipeDirection)
                    UIView.setAnimationsEnabled(true)
                })
            }
        }
    }
}
