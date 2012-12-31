function mcDrawGraphviz(graphviz_source_element, 
			graphviz_server_path, 
			image_tag_element) {
  var d = $(graphviz_source_element).text();  
  $.post(graphviz_server_path, d, function(data) {
    $(graphviz_source_element).hide();  
    $(image_tag_element).prepend('<img src=\"data:image/png;base64,' + data + '\" />');
  });
}

function setRenderer(dot_button_element,
                     dot_source_element,
                     graphviz_server_path,
                     output_element) {
  $(dot_button_element).click(function (e) {
    e.preventDefault();
    var d = $(dot_source_element).val();
    $.post(graphviz_server_path, d, function(data) {
      $(output_element).html('<img src=\"data:image/png;base64,' + data + '\" />');
    });
  });
}
