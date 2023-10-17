//
//  Contractor.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import Foundation


// MARK: Cell Actions
/// Represents the logic layer. It contains view rendering logic (itself) and data retrieval logic (Repo)
protocol CellActions {
    /// Actions are closures that will be called to handle events happenning in View Model. For example when it should move to another scene
    associatedtype ActionsType
    
    var actions: ActionsType { get }
}


// MARK: MVVM
/// Represents a Model, View and ViewModel unit. whenever a view is needed to be created, use this MVVM to guarantee confoming to MVVM. All it does is the it makes sure that for the
/// view being created there is a CellActions and this is to avoid adding any logic in the view.
protocol CellModel {
    /// Type of view model and it conforms to ``CellActions``
    associatedtype CellModelType: CellActions
    
    
    var cellModel: CellModelType? { get set }
}
