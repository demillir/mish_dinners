WickedPdf.config = {
  :exe_path                => WKHTMLTOPDF_PATH,
  :orientation             => 'Landscape',
  :page_size               => 'Letter',
  :print_media_type        => true,
  :margin                  => {:top    => 5, # default 10 (mm)
                               :bottom => 5,
                               :left   => 5,
                               :right  => 5},
  :disable_smart_shrinking => true,
  :zoom                    => 1.0,
}
