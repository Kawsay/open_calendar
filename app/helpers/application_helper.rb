module ApplicationHelper
  def active_link_to(text = '', path, **opts, &block)
    css_class = opts[:class]

    case opts[:endpoint]
      when String then css_class.concat(' active') if current_page.match(opts[:endpoint])
      when Array  then css_class.concat(' active') if opts[:endpoint].any? { |e| request.path.match(e) }
    end

    if block_given?
      link_to path, class: css_class, **opts, &block
    else
      link_to text, path, class: css_class, **opts,  &block
    end
  end

  def login_or_disconnect_link(**opts)
    if current_user
      link_to 'Déconnection', destroy_user_session_path, class: opts[:class], method: :delete
    else
      link_to 'Connection', new_user_session_path, class: opts[:class]
    end
  end
end
