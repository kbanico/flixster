class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show]

  def show
    # if current_user.enrolled_in(current_lesson.section.course.id)
    #   redirect_to courses_path(current_lesson.course)
    # end

  end

  private
    def require_authorized_for_current_lesson
      if !current_user.enrolled_in?(current_lesson.section.course) && current_lesson.section.course.user != current_user
        # render text: "Unauthorized", status: :unauthorized
        redirect_to course_path(current_lesson.section.course), alert: 'You are not authorized to do that'
      end
    end


    helper_method :current_lesson
    def current_lesson
      @current_lesson ||= Lesson.find(params[:id])
    end
end
