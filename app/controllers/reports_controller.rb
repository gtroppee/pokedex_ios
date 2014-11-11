class ReportsController < UIViewController
  attr_accessor :reports

  def initWithReports(reports)
    initWithNibName(nil, bundle:nil)
    self.reports = reports
    self
  end

  def loadView
    self.view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    self.view.backgroundColor = UIColor.whiteColor

    @mapView = mapView
    self.view.addSubview @mapView
  end

  private

    def mapView
      width  = UIScreen.mainScreen.bounds.size.width
      height = UIScreen.mainScreen.bounds.size.height

      view = MKMapView.alloc.initWithFrame([[0, 0], [width, height]])
      view.mapType = ::MKMapTypeStandard

      reports.each do |report| view.addAnnotation report end
      view
    end
end