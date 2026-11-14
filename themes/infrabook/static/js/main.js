// InfraBook theme JavaScript
document.addEventListener('DOMContentLoaded', function() {
  // Skip to content link
  var skipLink = document.querySelector('.skip');
  if (skipLink) {
    skipLink.addEventListener('click', function(e) {
      e.preventDefault();
      document.getElementById('main').focus();
    });
  }
});