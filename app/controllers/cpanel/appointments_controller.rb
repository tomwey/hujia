# coding: utf-8
class Cpanel::AppointmentsController < Cpanel::ApplicationController
  def index
    @appointments = Appointment.order('created_at DESC').paginate :page => params[:page], :per_page => 30
  end
end