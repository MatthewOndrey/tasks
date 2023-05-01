<html>
<html lang="en">
<head>
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

        // Function to format our date
        $.date = function(dateObject) {
            var d = new Date(dateObject);
            var day = d.getDate();
            var month = d.getMonth() + 1;
            var year = d.getFullYear();
            if (day < 10) {
                day = "0" + day;
            }
            if (month < 10) {
                month = "0" + month;
            }
            var date = month + "/" + day + "/" + year;
            return date;
        };

        // Gets all tasks from our DB
        $.ajax({
            url: 'taskFunctions.cfc?method=getAllTasks',
            type: 'GET',
            dataType: "json",
            success: function(response) {
                var tasks = response.DATA;
                var html = '';
                for (var i = 0; i < tasks.length; i++) {
                    html += '<tbody class="taskItem" id="taskItem"><tr class="row editRow" id="editRow" data-id="' + tasks[i][0] + '">';
                    html += '<td class="radioEdit"><input type="radio" value="' + tasks[i][0] + '"></td>';
                    html += '<td class="col taskTitle">' + tasks[i][1] + '</td>';
                    html += '<td class="col taskDescription"> ' + tasks[i][2] + '</td>';
                    html += '<td class="col taskDate">Due by ' + $.date(tasks[i][3]) + '</td></tr>';
                    html += '<tr class="tableBreak"><td colspan="5"><hr class="greenLine"></td></tr></tbody>';
                }
                html += '<tbody class="taskItem" id="taskItem"><tr class="row editRow" id="editRow">' +
                        '<td class="radioEdit"><input type="radio" value="" enabled=false></td>' +
                        '<td class="col taskTitle">= Delete a Task</td></tr></tbody>';
                $('#currentTasks').html(html);
            }
        })
    }

    // Delete a task by its id
    function deleteTask(id) {
      var currentId = 'id=' + id;
        $.ajax({
            url: 'taskFunctions.cfc?method=deleteTaskById',
            type: 'POST',
            data: currentId,
            success: function(response) {
              getTasks();
            },
            error: function(jqXHR, errorThrown) {
                console.log("Error: " + errorThrown);
            }
        });
    }

    // Save a task
    function saveTask(formData) {
        $.ajax({
            url: 'taskFunctions.cfc?method=insertTask',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                getTasks();
                $('#taskInput').trigger("reset"); // Reset the form after a submit
            }
        });
    }

    // Update a task
    function updateTask(formData) {
        $.ajax({
            url: 'taskFunctions.cfc?method=updateTask',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                getTasks();
                $('#taskInput').trigger("reset"); // Reset the form after an update
            }
        });
    }

    $(document).ready(function() {

        // When page loads, get the current list of tasks
        getTasks();

        // Task click detection
        $(".container").click(function() {
          //activeElement : input#radioEdit.radioedit
            var clickedToDelete = $('this').context.activeElement.defaultValue;
            if (clickedToDelete > 0) {
                console.log(clickedToDelete);
                deleteTask(clickedToDelete);
            }
        });

        // On submit form action
        $('form').submit(function(event) {
            event.preventDefault();
            var currentid = $("#id").val();
            var formData = $(this).serialize();
            if (currentid > 0) {
              // if the hidden id is more than 0 then it is an edit of an existing task
                updateTask(formData)
            } else {
                saveTask(formData)
            }
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
                <form id="taskInput">
                    <input type="hidden" id="id" name="id" value="0">
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