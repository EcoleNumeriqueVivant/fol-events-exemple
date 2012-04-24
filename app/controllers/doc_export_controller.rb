# coding: utf-8

class DocExportController < ApplicationController


  def event
    @event = Event.find(params[:event])
    respond_to do |format|
      format.pdf {
        render :pdf => "event", :locals => { :params => { event: @event} }
      }
      format.xml {
        render :locals => { :params => nil }
      }
    end
    
  end

end
