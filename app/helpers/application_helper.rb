module ApplicationHelper
  def active_link_to(text = '', path, **opts, &block)
    css_class = opts[:class]

    case opts[:endpoint]
      when String then css_class.concat(' active') if current_page? opts[:endpoint]
      when Array  then css_class.concat(' active') if opts[:endpoint].include? request.path
    end

    if block_given?
      link_to path, class: css_class, &block
    else
      link_to text, path, class: css_class, &block
    end
  end

  def login_or_disconnect_link(**opts)
    if current_administrator
      link_to 'Déconnection', destroy_administrator_session_path, class: opts[:class], method: :delete
    else
      link_to 'Connection', new_administrator_session_path, class: opts[:class]
    end
  end
end
