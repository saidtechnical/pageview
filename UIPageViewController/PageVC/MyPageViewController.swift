//
//  MyPageViewController.swift
//  UIPageViewController
//
//  Created by myni girl on 14.04.2022.
//

import UIKit

class MyPageViewController: UIPageViewController {
    
    var cars = [CarHelper]()
    let mercedes = UIImage(named: "mercedes")
    let volksWagen = UIImage(named: "vw")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Cars"
        
        let firstCar = CarHelper(name: "Car - volksWagen ", image: volksWagen!)
        
        let secondCar = CarHelper(name: "Car - mercedes ", image: mercedes!)
        cars.append(firstCar)
        cars.append(secondCar)
        
    }
    
    lazy var arrayCarViewController: [CarViewController] = {
        
        var carsVC = [CarViewController]()
        for car in cars {
            carsVC.append(CarViewController(carWith: car))
        }
        return carsVC
    }()
    
    //MARK: - init UIPageViewController
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .pageCurl, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = .green
        self.dataSource = self
        self.delegate = self
        setViewControllers([arrayCarViewController[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MyPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewController = viewController as? CarViewController else { return nil}
        
        if let index = arrayCarViewController.index(of: viewController) {
            if index > 0 {
                return arrayCarViewController[index - 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewController = viewController as? CarViewController else { return nil}
        
        if let index = arrayCarViewController.index(of: viewController) {
            if index < cars.count - 1 {
                return arrayCarViewController[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return cars.count
    }
 
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
    
