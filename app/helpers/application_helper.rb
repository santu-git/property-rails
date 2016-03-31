module ApplicationHelper
  def is_admin?
    current_user.try(:admin?)
  end

  def paperclip_icon_url(field)
    case field.content_type
    when 'application/pdf'
      'fa fa-file-pdf-o'
    when 'image/jpg','image/jpeg','image/png','image/gif'
      'fa fa-file-image-o'
    else
      'fa fa-file-o'
    end
  end

  def is_image?(field)
    case field.content_type
    when 'image/jpg','image/jpeg','image/png','image/gif'
      true
    else
      false
    end
  end  

end
