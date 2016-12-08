$(document).ready(function() {
    $('#img').click(function () {
       $ajax({
           type: 'POST',
           url: '${contextPath}/createNewTournament',
           success: function(data) {
               $('.content').html(data);
           }
       });
    });

});
