class NifsController < ApplicationController
  # GET /nifs
  # GET /nifs.xml
  def index
    @nifs = Nif.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nifs }
    end
  end

  # GET /nifs/1
  # GET /nifs/1.xml
  def show
    @nif = Nif.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nif }
    end
  end

  # GET /nifs/new
  # GET /nifs/new.xml
  def new
    @nif = Nif.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nif }
    end
  end

  # GET /nifs/1/edit
  def edit
    @nif = Nif.find(params[:id])
  end

  # POST /nifs
  # POST /nifs.xml
  def create
    @nif = Nif.new(params[:nif])

    respond_to do |format|
      if @nif.save
        format.html { redirect_to(@nif, :notice => 'Nif was successfully created.') }
        format.xml  { render :xml => @nif, :status => :created, :location => @nif }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @nif.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nifs/1
  # PUT /nifs/1.xml
  def update
    @nif = Nif.find(params[:id])

    respond_to do |format|
      if @nif.update_attributes(params[:nif])
        format.html { redirect_to(@nif, :notice => 'Nif was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nif.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nifs/1
  # DELETE /nifs/1.xml
  def destroy
    @nif = Nif.find(params[:id])
    @nif.destroy

    respond_to do |format|
      format.html { redirect_to(nifs_url) }
      format.xml  { head :ok }
    end
  end
end
