class FilesController < ApplicationController
  def index
    @queries = Query.all
  end

  def create
    query = Query.create!(query_params)
    redirect_to :files
  end

  def show
    query = Query.find_by(id: params[:id])
    work = query.process
    @header =  work[:header]
    @rows = work[:rows]
    @name = query.name
    @timestamp = query.timestamp
    @id = query.id
  end

  def destroy
    query = Query.find_by(id: params[:id])
    Query.delete(query)
    redirect_to :files
  end

  private
    def query_params
      p = params.require(:Query).permit(:name, :context)
      if p[:name].empty?
        p[:name] = p[:context].original_filename
      end
      p[:timestamp] = Time.now()
      return p
    end
end
