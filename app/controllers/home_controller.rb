require "csv"

class HomeController < ApplicationController
  before_action :skip_authorization, except: :report

  def index
    @areas = Area.includes(:head).order(:name).all
    # @next_editions = Edition.visible(current_user && current_user.staff?).with_next_events(10)
    authorize :home
  end

  def contacts
  end

  def presentazione
  end

  def privacy
    # render layout: 'pages'
  end

  def search
    @txt = params[:search]
    @activities = Activity.where("name like ?", "%#{@txt}%")
    @schools = School.where("name like ? or code like ?", "%#{@txt}%", "%#{@txt}%")
  end

  def archive
    @area = Area.find(params[:id])
    @slug = @area.slug
    @slug = "scienze-naturali-ambientali" if @slug == "scienze-naturali-e-ambientali"
    @archive_page = "#{config.relative_url_root}/archivio/it/#{@slug}.html"

    render layout: "archive"
  end

  def report
    authorize :home
    @editions = Edition.includes(:audience, :events, :speakers, project: [:activity_type, :areas]).order(:academic_year, :name)
    result = CSV.generate(col_sep: "\t", quote_char: '"') do |csv|
      @editions.each do |edition|
        # matematica :-)
        if edition.project.area_ids.include?(6)
          csv << [
            edition.academic_year,
            edition.project.areas.map(&:name).join(", "),
            edition.project.activity_type,
            edition.project.name,
            edition.name,
            edition.audience,
            edition.events.map { |e| I18n.l(e.start_date, format: :day_with_year) }.join(", "),
            edition.speakers.map { |s| s.cn }.join(", ")
          ]
        end
      end
    end
    send_data result, filename: "report.csv", type: :csv
  end
end
