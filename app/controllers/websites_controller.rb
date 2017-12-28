class WebsitesController < ApplicationController
  before_action :set_website, only: [:show, :edit, :update, :destroy]

  # GET /websites
  # GET /websites.json
  def index
    @websites = Website.all
  end

  # GET /websites/1
  # GET /websites/1.json
  def show
  end

  # GET /websites/new
  def new
    @website = Website.new
  end

  # GET /websites/1/edit
  def edit
  end

  # POST /websites
  # POST /websites.json
  def create
    @website = Website.new(website_params)

    respond_to do |format|
      if @website.save
        format.html { redirect_to @website, notice: 'Website was successfully created.' }
        format.json { render :show, status: :created, location: @website }
      else
        format.html { render :new }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /websites/1
  # PATCH/PUT /websites/1.json
  def update
    respond_to do |format|
      if @website.update(website_params)
        format.html { redirect_to @website, notice: 'Website was successfully updated.' }
        format.json { render :show, status: :ok, location: @website }
      else
        format.html { render :edit }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /websites/1
  # DELETE /websites/1.json
  def destroy
    @website.destroy
    respond_to do |format|
      format.html { redirect_to websites_url, notice: 'Website was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def fetchSingleWebsite(base_url)
    # fetches page
    require 'open-uri'
    page = Nokogiri::HTML(open(base_url))

    if page != nil
      newWebsite = Website.new(:url => base_url)
      newWebsite.save

      hrefs = page.css('a').map { |link| link.attribute('href').value }

      tokens = page.css('div').text.split

      tokens.each do |token|
        newToken = Token.new(:value => token)
        newToken.save

        newEdge = Edge.new()
        newEdge.token = Token.find_by_value(token)
        newEdge.website = Website.find_by_url(base_url)

        if newEdge.save

        else
          toModifyEdge = Edge.where(:token => newEdge.token, :website => newEdge.website).first
          toModifyEdge.quantity += 1
        end
      end

      hrefs.each do |href|
        if Website.where(:url => href).count == 0
          if href.include?('http')
            puts "Crawling for: " + href 
            fetchSingleWebsite(href)
          end
        end
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_website
      @website = Website.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def website_params
      params.require(:website).permit(:url)
    end
end
