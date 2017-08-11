module WikisHelper
  require 'redcarpet/render_strip'

  def markdown(text)
    extensions = {
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks:true,
      autolink: true,
      # disable_indented_code_blocks: true,
      strikethrough: true,
      lax_spacing: true,
      # space_after_headers: true,
      superscript: true,
      underline: true,
      highlight: true,
      quote: true,
      footnotes: true,
    }

    options = {
      # filter_html: true,
      # no_images: true,
      # no_links: true,
      # no_styles: true,
      # escape_html: true,
      # safe_links_only: true,
      # with_toc_data: true,
      # hard_wrap: true,
      # xhtml: true,
      # prettify: true,
      # link_attributes: true,
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end

  def hide_markdown_format(text)
    renderer_remove = Redcarpet::Render::StripDown
    remove_markdown = Redcarpet::Markdown.new(renderer_remove)
    remove_markdown.render(text)
  end
end
