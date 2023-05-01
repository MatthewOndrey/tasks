<html>
<html lang="en">
<head>
<cfinclude template="taskFunctions.cfc">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tasks</title>
    <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
          crossorigin="anonymous">
    <link rel="stylesheet" href="index.css">
<cfscript>

</cfscript>

<script type='text/javascript'>



    $(document).ready(function() {
        $('form').submit(function(event) {
            event.preventDefault();
            console.log('clicked');
            var formData = $(this).serialize();
            console.log(formData);
            $.ajax({
                url: 'taskFunctions.cfc?method=insertTask',
                type: 'POST',
                data: formData,
                dataType: 'json',
                success: function(response) {
                    console.log(response);
                    alert(response);
                }
            });
        });

      $.ajax({
          url: 'taskFunctions.cfc?method=getAllTasks',
          type: 'GET',
          dataType: "json",
          success: function(response) {
              var tasks = response.DATA;
              var html = '';
              for (var i = 0; i < tasks.length; i++) {
                  html += '<div>';
                  html += '<p>Task: ' + tasks[i][1] + '</p>';
                  html += '<p>Description: ' + tasks[i][2] + '</p>';
                  html += '<p>Due Date: ' + tasks[i][3] + '</p>';
                  html += '</div>';
              }
              $('#currentTasks').html(html);
          }
      })




    })

</script>

</head>

<body>
<cfoutput>
<cfset myTasks = new taskFunctions()>
<div class="container-fluid">

    <div class="taskForm" id="taskForm">
        <div class="taskHeader">
            Your Tasks -- #dateTimeFormat(now(), "short")#
        </div>
        <div id="currentTasks">

        </div>
        <div class="taskFormBody">
            <form id="taskForm">
                <label for="task">Task:</label><input type="text" id="title" name="title"><br>
                <label for="description">Description:</label>
                <input type="text" id="description" name="description"><br>
                <label for="dueDate">Due Date:</label>
                <input type="date" id="dueDate" name="dueDate"><br><br>
                <input type="submit" value="Submit">
            </form>
    <cfdump var="#myTasks#"/>


        </div>
        <div class="taskFooter">
          <button class="taskButton" name="task"></button>  LOAD
        </div>
    </div>


</div>
</cfoutput>
</body>

</html>