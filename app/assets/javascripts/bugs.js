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
  const completed_option = document.getElementById("completed");
  const resolved_option = document.getElementById("resolved");
  if (type_dropdown.value = 'bug'){
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
