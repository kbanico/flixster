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
      if current_lesson.section.course.id != current_user.enrollments.course.id
        render text: "Unauthorized", status: :unauthorized
      end
    end


    helper_method :current_lesson
    def current_lesson
      @current_lesson ||= Lesson.find(params[:id])
    end
end
