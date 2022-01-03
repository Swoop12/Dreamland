//
//  AdaptiveGrid.swift
//  Taro
//
//  Created by DevMountain on 1/5/21.
//

import SwiftUI

struct AdaptiveGridViewController<Item: Hashable, Cell: View>: UIViewRepresentable {
    
    let items: [Item]
    var cellProvider: (Item) -> Cell
    
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        context.coordinator.generateDataSource(collectionView: collectionView, cellProvider: cellProvider)
        collectionView.backgroundColor = UIColor.systemBackground
        context.coordinator.populateData()
        collectionView.delegate = context.coordinator
        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        context.coordinator.populateData()
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, UICollectionViewDelegateFlowLayout {
        
        enum Section {
            case main
        }
        
        var parent: AdaptiveGridViewController
        let items: [Item]
        var collectionDataSource: UICollectionViewDiffableDataSource<Section, Item>?
        
        init(_ parent: AdaptiveGridViewController) {
            self.parent = parent
            self.items = parent.items
        }
        
        func generateDataSource(collectionView: UICollectionView, cellProvider: @escaping (Item) -> Cell) {
            let reuseIdentifier = "AdaptiveGridCell"
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            let dataSource = UICollectionViewDiffableDataSource<Section, Item>.init(collectionView: collectionView) { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
                guard let self = self else {
                    fatalError("Could not return a cell from diffable datasource")
//                    return cell
                }
                let view = cellProvider(item)
                self.host(view, in: cell)
                return cell
            }
            self.collectionDataSource = dataSource
        }
        
        func populateData() {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            snapshot.appendSections([.main])
            snapshot.appendItems(items)
            collectionDataSource?.apply(snapshot)
        }
        
        private func host<T: View>(_ view: T, in cell: UICollectionViewCell) {
            let hostViewController = UIHostingController(rootView: view)
            hostViewController.view.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(hostViewController.view)
            NSLayoutConstraint.activate([
                hostViewController.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                hostViewController.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
                hostViewController.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                hostViewController.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
            ])
        }
        
        // MARK: - UICollectionViewDelegateFlowLayout
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            guard let item = collectionDataSource?.itemIdentifier(for: indexPath) else { return .zero }
            let view = parent.cellProvider(item)
            let hostViewController = UIHostingController(rootView: view)
            hostViewController.loadView()
            let size = hostViewController.view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            return size
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

struct AdaptiveGrid<Item: Hashable, Cell: View>: View {
    
    let items: [Item]
    var cellProvider: (Item) -> Cell
    
    var body: some View {
        AdaptiveGridViewController(items: items, cellProvider: cellProvider)
    }
   
}
