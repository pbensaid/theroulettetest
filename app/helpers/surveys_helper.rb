module SurveysHelper

  def full_share_link(object,code)
    "#{url_for survey_path(object, mysecretcode: code, only_path:false)}"
  end

end
