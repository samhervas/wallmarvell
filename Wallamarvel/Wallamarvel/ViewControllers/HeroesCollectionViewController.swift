//
//  HeroesCollectionViewController.swift
//  Wallamarvel
//
//  Created by Samuel Hervás on 23/2/16.
//  Copyright © 2016 Samuel Hervás Gómez. All rights reserved.
//

import UIKit

class HeroesCollectionViewController: UIViewController, UICollectionViewDelegate,UISearchBarDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var collectionView: CharacterCollectionView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private var page = 0;
    private let limit = 20;
    
    private let dataSource = CharacterCollectionDataSource()
    private let segueIdentifier = "showCharacterDetail"
    
    // MARK: - UIViewController cycle life
    
    override func viewDidLoad() {
        self.collectionView.dataSource = dataSource
        self.collectionView.delegate = self
        self.searchBar.delegate = self
        self.navigationController?.delegate = self
        
        loadCharacters(page*limit)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == segueIdentifier) {
            let destination = segue.destinationViewController as! DetailCharacterViewController
            let indexPath = sender as! NSIndexPath
            let character = dataSource.filterCharacter![indexPath.row]
            destination.character = character
        }
    }
    
    func loadCharacters(offset:Int) {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        HTTPClient.sharedInstance.requestCharacters(offset, completionHandler: { (response) -> Void in
            let dataSource = self.collectionView.dataSource as! CharacterCollectionDataSource
            if var merge = dataSource.characters {
                merge += response
                dataSource.characters = merge
            } else {
                dataSource.characters = response
            }
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        })

    }
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(segueIdentifier, sender: indexPath)
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            dataSource.filterKeyword = nil
            view.endEditing(true)
        } else {
            dataSource.filterKeyword = searchText
        }
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        if (fromVC == self) {
            return TransitionToCharacterDetail()
        }
        else {
            return nil
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if (bottomEdge >= scrollView.contentSize.height) {
            page += 1
            loadCharacters(page*limit)
        }
    }
    
}
