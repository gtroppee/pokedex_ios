class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.backgroundColor = UIColor.whiteColor

    @root_controller = RootController.alloc.initWithNibName(nil, bundle:nil)
    @navigation_controller =
      UINavigationController.alloc.initWithRootViewController(@root_controller)

    @window.rootViewController = @navigation_controller
    @window.makeKeyAndVisible
    true
  end
end