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

    function getTasks() {
        $.ajax({
            url: 'taskFunctions.cfc?method=getAllTasks',
            type: 'GET',
            dataType: "json",
            success: function(response) {
                var tasks = response.DATA;
                var html = '';
                for (var i = 0; i < tasks.length; i++) {
                    html += '<div class="row editRow" id="editRow" data-id="' + tasks[i][0] + '">';
                    html += '<span class="col taskTitle">' + tasks[i][1] + '</span>';
                    html += '<span class="col taskDescription"> ' + tasks[i][2] + '</span>';
                    html += '<span class="col taskDate">Due by ' + tasks[i][3] + '</span></div></div><br/>';
                }
                $('#currentTasks').html(html);
            }
        })
    }


    $(document).ready(function() {

        getTasks();

        $(".editRow").click(function() {
            console.log($(this).data("id"));
        });

        $('form').submit(function(event) {
            event.preventDefault();
            var formData = $(this).serialize();
            $.ajax({
                url: 'taskFunctions.cfc?method=insertTask',
                type: 'POST',
                data: formData,
                dataType: 'json',
                success: function(response) {
                    alert('Task Saved');
                }
            });
        });

    })

</script>

</head>

<body>
<cfoutput>
<div class="container-fluid taskBody">

    <div class="taskForm" id="taskForm">
        <div class="taskHeader">
            Your Tasks -- #dateTimeFormat(now(), "short")#
        </div>

        <div class="taskFormBody">
            <form id="taskForm">
                <label for="task">Task Title:</label><input type="text" id="title" name="title"><br>
                <label for="description">Description:</label>
                <input type="text" id="description" name="description"><br>
                <label for="dueDate">Due Date:</label>
                <input type="date" id="dueDate" name="dueDate"><br><br>
                <input type="submit" value="Submit">
            </form>

        </div>

    </div>
</div>
        <div id="currentTasks" class="container"></div>



</cfoutput>
</body>

</html>