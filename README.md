
Simple task application

ColdFusion based

Running local cfserver via CommandBox, start a mysql Docker instance and connect in the admin


`docker run --name=docker-mysql --env="MYSQL_ROOT_PASSWORD=root" --env="MYSQL_PASSWORD=root" --env="MYSQL_DATABASE=tasks" mysql
`


db table [tasks] can be created via:
`create_table.sql`

The component taskFunctions.cfc contains the following functions:

* getAllTasks()
* getTaskById()
* insertTask()
* updateTask()
* deleteTaskById()

