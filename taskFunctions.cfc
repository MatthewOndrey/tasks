<cfcomponent>

    <cffunction name="getAllTasks" access="remote" returntype="query">

        <cfquery name="getTasks" datasource="tasks">
            select id, title, description, dueDate From tasks
            order by dueDate asc
        </cfquery>

        <cfreturn getTasks />

    </cffunction>

    <cffunction name="getTaskById" access="remote" returntype="json">
        <cfargument name="id" type="numeric" required="true">

        <cfquery name="getTasksById" datasource="tasks">
            select id, title, description, dueDate From tasks
            where
            id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#"/>
        </cfquery>

        <cfreturn getTaskById />

    </cffunction>

    <cffunction name="insertTask" access="remote" returntype="boolean">
        <cfargument name="id" type="numeric" required="false"> <!--- ignored --->
        <cfargument name="title" type="string" required="true">
        <cfargument name="description" type="string" required="false">
        <cfargument name="dueDate" type="date" required="true">

        <cfquery name="insertTask" datasource="tasks">
            insert into tasks
                (title, description,dueDate)
                values (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#"/>,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.description#"/>,
                    <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.dueDate#"/>)
        </cfquery>

        <cfreturn true />

    </cffunction>

    <cffunction name="updateTask" access="remote" returntype="boolean">
        <cfargument name="id" type="numeric" required="true">
        <cfargument name="title" type="string" required="true">
        <cfargument name="description" type="string" required="false">
        <cfargument name="dueDate" type="date" required="true">

        <cfquery name="updateTask" datasource="tasks">
            update tasks set
            title =
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#"/>,
            description =
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.description#"/>,
            dueDate =
            <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.dueDate#"/>
            where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#"/>
        </cfquery>

        <cfreturn true />

    </cffunction>

    <cffunction name="deleteTaskById" access="remote" returntype="boolean">
        <cfargument name="id" type="numeric" required="true">

        <cfquery name="getTasksById" datasource="tasks">
            delete From tasks
            where
            id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#"/>
        </cfquery>

        <cfreturn true />

    </cffunction>

</cfcomponent>