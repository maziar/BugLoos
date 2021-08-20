//
//  PlayListViewController.swift
//  BugLoosTest
//
//  Created by Pelk on 8/18/21.
//

import UIKit
import GSKStretchyHeaderView

class PlayListViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playButtonTopConstraint: NSLayoutConstraint!
    
    
    let viewModel: PlayListViewModel
    lazy var navigator = ListNavigator(navigationController: self.navigationController,
                                       viewControllerFactory: ListNavigatorFactory())
    var stretchyHeaderView: PlayListStretchyHeaderView!
    let headerHeight: CGFloat = 300
    let playerBarHeight: CGFloat = 95
    let naigationHeight: CGFloat = 45
    
    init(playListViewModel: PlayListViewModel) {
        self.viewModel = playListViewModel
        super.init(nibName: PlayListViewController.nameOfClass, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setup()
        setupStretchyHeaderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewWillAppear()
    }
    
    func setup() {
        title = viewModel.playList.title
        playButton.setCurvedView(cornerRadius: 20)
    }
    
    func setupViewWillAppear() {
        tableView.reloadData()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.alpha = 0
    }
    
    func setupStretchyHeaderView() {
        stretchyHeaderView = PlayListStretchyHeaderView(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: screenWidth,
                                                             height: headerHeight))
        tableView.addSubview(stretchyHeaderView)
        stretchyHeaderView.maximumContentHeight = headerHeight
        stretchyHeaderView.config(playList: viewModel.playList)
    }
    
    func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: headerHeight,
                                              left: 0,
                                              bottom: playerBarHeight,
                                              right: 0)
        PlayListTableViewCell.register(for: tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        viewModel.playList.tracks[0].selected = true
        navigator.navigate(to: .playerView,
                           isPresent: true,
                           modalPresentationStyle: .fullScreen,
                           viewModel: PlayerViewModel(playList: viewModel.playList))
    }
}

extension PlayListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        viewModel.changeSelectedTracks(tracks: &viewModel.playList.tracks)
        viewModel.playList.tracks[indexPath.row].selected = true
        navigator.navigate(to: .playerView,
                           isPresent: true,
                           modalPresentationStyle: .fullScreen,
                           viewModel: PlayerViewModel(playList: viewModel.playList))
    }
}

extension PlayListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.playList.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayListTableViewCell.nameOfClass,
                                                 for: indexPath) as? PlayListTableViewCell
        
        guard let track = viewModel.playList.tracks[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        cell?.config(track: track)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension PlayListViewController: PlayListCellDelegate {
    func moreTap(trackId: Int) {
        print("more")
    }
    
    func removeTap(trackId: Int) {
        viewModel.changeRemoveTrack(trackId: trackId)
        tableView.reloadData()
    }
    
    func heartTap(trackId: Int) {
        let index = viewModel.changeHeartTrack(trackId: trackId)
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
}

extension PlayListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPos = scrollView.contentOffset.y;
        guard let navigation = navigationController else {
            return
        }
        let value = ((Int(yPos) * -1) - Int(navigation.navigationBar.frame.size.height))
        if (value < 1) {
            showNavbar()
        }
        else {
            hideNavbar()
            checkButtonConstraint(value: value)
        }
    }
    
    func checkButtonConstraint(value: Int) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear) { [self] in
            if value > 40 {
                playButtonTopConstraint.constant = stretchyHeaderView.frame.size.height - naigationHeight
                loadViewIfNeeded()
            }
            else {
                playButtonTopConstraint.constant = naigationHeight
                loadViewIfNeeded()
            }
        }
    }
    
    func showNavbar() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear) { [self] in
            navigationController?.navigationBar.isHidden = false
            navigationController?.navigationBar.alpha = 1
            loadViewIfNeeded()
        }
    }
    
    func hideNavbar() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear) { [self] in
            navigationController?.navigationBar.alpha = 0
            loadViewIfNeeded()
        }
    }
}
