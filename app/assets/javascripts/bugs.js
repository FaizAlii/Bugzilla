function change_status() {
  const completed_option = document.getElementById("completed");
  const resolved_option = document.getElementById("resolved");
  if (completed_option.style.display == 'none'){
    completed_option.style.display = 'block';
    resolved_option.style.display = 'none';
  }
  else{
    completed_option.style.display = 'none';
    resolved_option.style.display = 'block';
  }
}

document.addEventListener('turbolinks:load', () => {
  const type_dropdown = document.getElementById("bug_bug_type");
  const bug_heading = document.getElementById("bug_heading");
  const completed_option = document.getElementById("completed");
  const resolved_option = document.getElementById("resolved");
  if (bug_heading.getAttribute('name') == 'Bug'){
    completed_option.style.display = 'none';
    resolved_option.style.display = 'block';
  }
  else{
    completed_option.style.display = 'block';
    resolved_option.style.display = 'none';
  }
  type_dropdown.addEventListener('change', (event) => {
    change_status()
  });
});

document.addEventListener('turbolinks:load', () => {
  $('#bug_image').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      console.log(file);
      img.src = file.target.result;
      img.id = 'bug-img';
      $('#target').html(img);
      document.getElementById("previous-img").style.display = 'none';
    }
    reader.readAsDataURL(image);
    console.log(files);
  });
});
